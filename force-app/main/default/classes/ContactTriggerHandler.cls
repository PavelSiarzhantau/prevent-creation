public with sharing class ContactTriggerHandler {
    public static void handleTriggerEvent(List<Contact> contacts){
        System.TriggerOperation  opeartionType = Trigger.operationType;
        switch on opeartionType {
            when BEFORE_INSERT {
                System.debug('before insert');
                ContactService.preventContactCreation(contacts);
            }
            // add event 
        }
    }
}
