@isTest
private with sharing class AccountSelectorTest {
  @TestSetup
  static void makeData() {
    TestDataFactory.createAccountsWithContacts(200, 10);
  }
  @isTest
  static void getAccountsTest() {
    List<Contact> contacts = [
      SELECT ID, 
             Name, 
             AccountId
      FROM Contact
    ];
    Map<Id, Account> accounts = new Map<Id, Account>();
    User testUser = TestDataFactory.createTestUser('Standard User');
    System.runAs(testUser) {
      Test.startTest();
      accounts = AccountSelector.getAccounts(contacts);
      Test.stopTest();
      for (Contact ct : contacts) {
        Id expectedAccountId = ct.AccountId;
        Id actualAccountId = accounts.get(ct.AccountId).Id;
        System.assertEquals(
          expectedAccountId,
          actualAccountId,
          'Test  getAccountsTest() failed'
        );
      }
    }
  }
  @isTest
  static void getAccountsTestNegative() {
    List<Contact> contacts = new List<Contact>();
    Map<Id, Account> accounts = new Map<Id, Account>();
    User testUser = TestDataFactory.createTestUser('Standard User');
    System.runAs(testUser){
        Test.startTest();
        accounts = AccountSelector.getAccounts(contacts);
        Test.stopTest();
        Integer expectedSize = 0;
        System.assertEquals(expectedSize, accounts.size(),'Test getAccountsTestNegative() failed');
    }
  }
}
