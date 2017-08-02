global class CollectionOfClosedWonOpportunities implements Database.Batchable<sObject> , Database.Stateful {
    global Map<Id,Map<String,List<Opportunity>>> mapContactOpportunity =new Map<Id,Map<String,List<Opportunity>>>();
    global Map<Id,Double> aggregateAmountOnAccount = new Map<Id,Double>();

    global Database.QueryLocator start (Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, (SELECT Name, Amount'+
                                        ' FROM Opportunities WHERE StageName=\'Closed Won\''+
                                        ' AND CloseDate=today), (SELECT Contact.Email'+
                                        ' From AccountContactRoles WHERE IsPrimary = true)'+
                                        ' FROM Account WHERE Id IN (SELECT AccountId'+
                                        ' FROM Opportunity WHERE StageName= \'Closed Won\''+
                                        ' AND CloseDate =today) AND Id IN (SELECT AccountId'+
                                        ' FROM AccountContactRole WHERE IsPrimary = true)'
        );
    }
    global void execute(Database.BatchableContext bc, List<Account> accounts) {
        Double total;
        for(Account account : accounts) {
            total = 0.0;
            mapContactOpportunity.put(account.Id,new Map<String,List<Opportunity>>());
            mapContactOpportunity.get(account.Id).put(account.AccountContactRoles[0].Contact.Email,account.Opportunities);
            for(Opportunity opportunity : account.Opportunities) {
                if(opportunity.Amount!=null) {
                    total = total + opportunity.Amount;
                }
            }
            aggregateAmountOnAccount.put(account.Id,total);
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
            for(String MailId : mapContactOpportunity.get(Id).keySet()) {
                if(MailId != null) {
                    mailAddress.add(MailId);
                    for(Opportunity opportunity : mapContactOpportunity.get(Id).get(MailId)) {
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