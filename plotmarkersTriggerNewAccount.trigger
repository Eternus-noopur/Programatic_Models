trigger plotmarkersTriggerNewAccount on Account (after insert) {
    PlotMarkersHandler.plotMarkersMethodForAccountAndContact(trigger.newMap);
}