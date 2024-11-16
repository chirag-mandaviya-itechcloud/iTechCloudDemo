@isTest
private class AccountTriggerHandlerTest {

    @isTest
    static void MatchCustomPhoneTest() {
        Account acc = new Account();
        acc.name = 'Test Account';
        acc.Phone = '1111111111';
        insert acc;

        Account createdAcc = [SELECT Id, Phone, Custom_Phone__c FROM Account WHERE Id=:acc.Id LIMIT 1];
        System.Assert.areEqual('1111111111', createdAcc.Custom_Phone__c);
    }
    
    @isTest
    static void CreateRelatedContactWhileCreateTest() {

        Account newAcc = new Account();
        newAcc.name = 'Test Account 2';
        newAcc.Phone = '9999999999';
        newAcc.Create_Related_Contact__c = true;
        insert newAcc;

        Contact relatedCon = [SELECT Id, LastName, Phone, AccountId FROM Contact WHERE AccountId =: newAcc.Id];
        System.Assert.areEqual(newAcc.Name, relatedCon.LastName);
        System.Assert.areEqual(newAcc.Phone, relatedCon.Phone);
    }

    @isTest
    static void CreateRelatedContactWhileUpdateTest() {

        Account newAcc = new Account();
        newAcc.name = 'Test Account 2';
        newAcc.Phone = '9999999999';
        newAcc.Create_Related_Contact__c = true;
        insert newAcc;

        Account acc = [SELECT Id, Phone, Name, Custom_Phone__c FROM Account WHERE Id=:newAcc.Id LIMIT 1];
        acc.Create_Related_Contact__c = true;
        update acc;

        Contact relatedCon = [SELECT Id, LastName, Phone, AccountId, Email FROM Contact WHERE AccountId =:acc.Id LIMIT 1];
        System.Assert.areEqual(acc.Name, relatedCon.LastName);
        System.Assert.areEqual(acc.Phone, relatedCon.Phone);
    }

    @isTest
    static void PreventNameDuplicationTest() {

        Account acc = new Account();
        acc.name = 'Test Account';
        acc.Phone = '1111111111';
        insert acc;

        Account acc2 = new Account();
        acc2.name = 'Test Account';
        acc2.Phone = '2222222222';
        // insert acc2; 

        Test.startTest();
        // Try to insert the duplicate account and catch the expected exception.
        Database.SaveResult sr = Database.insert(acc2, false);
        Test.stopTest();

        System.assertEquals('Duplicate name', sr.getErrors()[0].getMessage());
    }
}