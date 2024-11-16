@isTest
public class AccountTestUtilityTest {
    @TestSetup
    static void makeData(){
        List<Account> listAccount = TestUtility.CreateAccounts(5, 'Test');
        for (Integer i=0;i<5;i++) {
            listAccount[i].name='Test'+i;
            listAccount[i].Active__c='No';
            listAccount[i].Phone='9999999999';
        }
        insert listAccount;
        // helloT1
    }
    
    @isTest
    private static void AccountTestUtilityTest() {
        Account updatedAcc = [SELECT Id, Phone, Custom_Phone__c FROM Account WHERE Name LIKE '%Test%' Limit 1];
        System.Assert.areEqual('9999999999', updatedAcc.Custom_Phone__c);
    }
}