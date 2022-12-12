public with sharing class AccountSelector {
    
    public static Map<Id,Account> getAccounts(List<Contact> contacts){
        List<Id> listOfAccountIds = new List<Id>();
        Map<Id,Account> accounts = new Map<Id,Account>();
        if(contacts.size() != 0){
            for(Contact ct : contacts){
                listOfAccountIds.add(ct.AccountId);
            }
            accounts =  new Map<Id,Account>([SELECT Id,
                                                   Name,
                                                   Bad_Debtor__c
                                            FROM Account
                                            WHERE Id IN: listOfAccountIds]);
        }
        
        return accounts;
    }
}
