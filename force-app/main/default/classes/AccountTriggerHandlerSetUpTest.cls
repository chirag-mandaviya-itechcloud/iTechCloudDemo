@isTest
public class AccountTriggerHandlerSetUpTest {
    @TestSetup
    static void makeData(){

        List<Account> listAccount = new List<Account>();
        for (Integer i=0;i<5;i++) {
            Account acc = new Account();
            acc.name='Test'+i;
            acc.Active__c='No';
            acc.Rating='Cold';
            acc.Phone = '9999999999';
            listAccount.add(acc);
        }
        insert listAccount;
    }
    @isTest
    private static void AccountTriggerHandlerSetUpTest() {
        Account updatedAcc = [SELECT Id, Phone, Custom_Phone__c FROM Account WHERE Name LIKE '%Test%' Limit 1];
        System.Assert.areEqual('9999999999', updatedAcc.Custom_Phone__c);
    }
}