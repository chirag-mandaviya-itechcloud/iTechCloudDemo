@isTest
public with sharing class CaseTriggerHandlerTest {
    @TestSetup
    static void makeData(){

        Account acc = new Account();
        acc.name = 'Test Account';
        insert acc; 

        Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = 'Test';
        con.accountId = acc.Id;
        con.Email = 'semail@gmail.com';
        con.Phone = '9743800309';
        insert con;
    }

    @isTest
    static void LinkCaseToExistsContactTest() {
        Case ca = new Case();
        ca.SuppliedEmail = 'semail@gmail.com';
        ca.Status = 'New';
        ca.Origin = 'Web';
        insert ca;

        Case addedCase = [SELECT Id, ContactId, SuppliedEmail FROM Case WHERE Id =:ca.Id LIMIT 1];
        Contact con = [SELECT Id, Email, Account.Name FROM Contact WHERE Email =: addedCase.SuppliedEmail LIMIT 1];
        System.Assert.areEqual(con.Id, addedCase.ContactId);
    }

    @isTest
    static void LinkCaseToNewContact(){
        Case ca = new Case();
        ca.SuppliedEmail = 'abcd@gmail.com';
        ca.Status = 'New';
        ca.Origin = 'Web';
        insert ca;

        Case addedCase = [SELECT Id, ContactId, SuppliedEmail FROM Case WHERE Id =:ca.Id LIMIT 1];
        Contact con = [SELECT Id, Email, Account.Name FROM Contact WHERE Email =: addedCase.SuppliedEmail LIMIT 1];
        System.Assert.areEqual(con.Id, addedCase.ContactId);
    }

    @isTest
    static void AddCaseNumberToAccountTest(){
        Account acc = [SELECT Id, Case_Number__c FROM Account WHERE Name LIKE '%Test%'];
        Case ca = new Case();
        ca.Status = 'New';
        ca.Origin = 'Web';
        ca.AccountId = acc.Id;
        insert ca;

        Case addedCase = [SELECT Id, ContactId, SuppliedEmail FROM Case WHERE Id =:ca.Id];
        Account acc1 = [SELECT Id, Case_Number__c FROM Account WHERE Id =: addedCase.AccountId];
        System.assertEquals(ca.CaseNumber, acc1.Case_Number__c);
    }
}