/************************************************************************

A. Collection of Closed Won Opportunities
1. The Primary contact associated with an account needs to know which all are the closed won
opportunities for his account per day.
2. Create a process which will run every day in the midnight & collect all the Closed won opportunities of
that account in a day & send an email to Primary Contact.
3. The email body should contain the Opportunity Name & it's respective amount with the aggregated
amount in the end.

*************************************************************************/
global class CollectionOfClosedWonOpportunities implements Database.Batchable<sObject> , Database.Stateful {
    global Map<Id,Map<String,List<Opportunity>>> mapContactOpportunity =new Map<Id,Map<String,List<Opportunity>>>();
    global Map<Id,Double> aggregateAmountOnAccount = new Map<Id,Double>();
    global Database.QueryLocator start (Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, (SELECT Name, Amount'+
                                        ' FROM Opportunities WHERE StageName=\'Closed Won\''+
                                        ' AND CloseDate=today), (SELECT Contact.Email'+
                                        ' From AccountContactRoles WHERE IsPrimary = true)'+
                                        ' FROM Account'
        );
    }
    global void execute(Database.BatchableContext bc, List<Account> accounts) {
        Double total;
        Map<String,List<Opportunity>> mapContactEmailOpportunity = new  Map<String,List<Opportunity>>();
        for(Account account : accounts) {
            String email;
            for(AccountContactRole acountContactRole : account.AccountContactRoles)
            {
                if(String.isNotBlank(acountContactRole.Contact.Email))
                {
                    email = acountContactRole.Contact.Email;
                    break;
                }
            }
            if((String.isNotBlank(email)))
            {
                if(!account.AccountContactRoles.isEmpty() && !account.Opportunities.isEmpty())
                {
                    total = 0.0;
                    mapContactEmailOpportunity.put(account.AccountContactRoles[0].Contact.Email,account.Opportunities);
                    mapContactOpportunity.put(account.Id,mapContactEmailOpportunity);
                    for(Opportunity opportunity : account.Opportunities) {
                        if(opportunity.Amount!=null) {
                            total = total + opportunity.Amount;
                        }
                    }
                    aggregateAmountOnAccount.put(account.Id,total);
                }
            }
        }
    }
    global void finish(Database.BatchableContext bc) {
        Boolean isMailIdNull = false;
        String mailBody='';
        String[] mailAddress=new String[]{};
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
        for(String Id : mapContactOpportunity.keySet()) {
            isMailIdNull = false;
            mailBody = '';
            mailAddress.clear();
            for(String mailId : mapContactOpportunity.get(Id).keySet()) {
                if(mailId != null) {
                    mailAddress.add(mailId);
                    for(Opportunity opportunity : mapContactOpportunity.get(Id).get(mailId)) {
                        mailBody += 'Opportunity:::' + opportunity.Name + '\n';
                        mailBody += 'Amount:::' + opportunity.Amount + '\n';
                    }
                    mailBody += system.label.TotalAmount+ aggregateAmountOnAccount.get(Id) + '\n\n\n';
                    mailBody += system.label.ThankYouLabel;
                } else {
                   isMailIdNull = true;
                }
            }
            if(!isMailIdNull) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(mailAddress);
                mail.setSubject(system.label.EmailSubject);
                mail.setPlainTextBody(system.label.EmailBody+mailBody);
                listMail.add(mail);
            }
        }
        Messaging.sendEmail(listMail);
    }
}