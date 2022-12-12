@isTest
public with sharing class TestDataFactory {

    public static List<Contact> createContacts(Boolean isCreate, Integer countOfContacts){
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < countOfContacts; i++) {
            contacts.add(new Contact(LastName = 'Test ' + i ));
        }
        if(isCreate){
            insert contacts;
        }
        return contacts;
    }
    public static List<Account> createAccounts(Boolean isCreate, Integer countOfAccounts){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < countOfAccounts; i++) {
            accounts.add(new Account(Name = 'Test ' + i,external_id__c = i));
        }
        if(isCreate){
            insert accounts;
        }
        return accounts;
    }
    public static void createAccountsWithContacts(Integer countOfAccounts, 
                                                           Integer countOfContacts){
        Boolean isCreateAccounts = true;
        List<Account> accounts = createAccounts(isCreateAccounts, 200);
        List<Contact> contacts = new List<Contact>();
        for(Account acc : accounts){
            List<Contact> contactsPerAccount = new List<Contact>();
            for (Integer i = 0; i < countOfContacts; i++) {
                contactsPerAccount.add(new Contact(LastName = 'Test ' + i, AccountId = acc.Id));
            }
            contacts.addAll(contactsPerAccount);

        }
        insert contacts;
    }
    public static User createTestUser(String profile) {
        User user = new User(
            ProfileId = [SELECT Id 
                         FROM Profile 
                         WHERE Name = :profile]
            .Id,
            LastName = 'last',
            Email = 'Cpt.Awesome@awesomesauce.com',
            UserName = 'Cpt.Awesome.' +
                DateTime.now().getTime() +
                '@awesomesauce.com',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert user;
        // insert new PermissionSetAssignment(
        //     AssigneeId = user.Id,
        //     PermissionSetId = [SELECT Id
        //                        FROM PermissionSet
        //                        WHERE Name = 'Access_to_Sensor_and_sensor_events_access']
        //     [0]
        //     .Id
        // );
        return user;
    }
}
