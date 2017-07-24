trigger PlotmarkerTriggerNewContact on Contact (after insert) {
    PlotMarkersHandler.plotMarkersMethodForAccountAndContact(trigger.newMap);
}