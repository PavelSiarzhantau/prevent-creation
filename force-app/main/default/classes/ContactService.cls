public with sharing class ContactService {

    private static final String ERROR_MESSAGE = 'Impossible to create a contact to the current account because the account has a debt';
    public static void preventContactCreation(List<Contact> contacts){
        Map<Id,Account> accounts = AccountSelector.getAccounts(contacts);
        Boolean isBedDebtor;
        for(Contact ct : contacts){
            isBedDebtor = accounts.get(ct.AccountId).Bad_Debtor__c;
            if(isBedDebtor){
                System.debug('ContactName:::: ' + ct.LastName);
                System.debug('Account Name:::: ' + accounts.get(ct.AccountId).Name);
                System.debug('Account isBadDeptor:::: ' + isBedDebtor);
                ct.addError(ERROR_MESSAGE);
            }
        }
    }
}
