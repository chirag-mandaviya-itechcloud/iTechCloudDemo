@isTest
public with sharing class UpdateAccountsTest {
    @isTest
    private static void updateAccountsTest() {
        Account acc = new Account();
        acc.name = 'Test Account';
        acc.Active__c = 'No';
        acc.Rating = 'Cold';
        insert acc;

        Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = 'Test';
        con.accountId = acc.Id;
        insert con;

        UpdateAccounts.UpdateAccount();

        Account updatedAcc = [SELECT Id, Active__c, Rating FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Yes', updatedAcc.Active__c);
    }
}