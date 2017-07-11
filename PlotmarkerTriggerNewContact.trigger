trigger PlotmarkerTriggerNewContact on Contact (after insert) {
    PlotMarkerTriggerContactHandler.plotMarkersMethod(trigger.new);
}