trigger plotmarkersTriggerNewAccount on Account (after insert) {
    plotMarkersHandlerAccount.plotMarkersMethod(trigger.new);
}