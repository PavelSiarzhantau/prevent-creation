trigger ContactTrigger on Contact (before insert) {
    ContactTriggerHandler.handleTriggerEvent(Trigger.new);
}