public with sharing class UpdateAccounts {
    public static void UpdateAccount() {
        List<Account> accList = new List<Account>();
        Set<Id> accIdSet = new Set<Id>();

        for (Contact con : [SELECT Id, Account.Id FROM Contact
                            WHERE Name LIKE '%Test%'
                            AND Account.Id != NULL]) {
                                    
            if (!accIdSet.contains(con.Account.Id)) {
                Account acc = new Account();
                // Create new default values
                acc.Id = con.Account.Id;
                acc.Active__c = 'Yes';
                acc.Rating = 'Hot';
                accList.add(acc);
                accIdSet.add(con.Account.Id);
            }
        }   
        if(!accList.isEmpty()) {
            update accList;
        }
    }
}