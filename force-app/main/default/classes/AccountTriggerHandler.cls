public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accList) {
        for(Account acc : accList) {
            acc.Custom_Phone__c = acc.Phone;
        }
    }

    public static void CreateContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList) {
            if (acc.Create_Related_Contact__c == true) {
                Contact con = new Contact();
                con.LastName = acc.Name;
                con.Phone = acc.Phone;
                con.AccountId = acc.Id;
                conList.add(con);
            }
        }

        if (conList.size() > 0) {
            insert conList;
        }
    }

    public static void PreventNameDuplication(List<Account> accList) {
        Set<String> accNameSet = new Set<String>();
        for(Account acc : accList) {
            if (acc.Name != null) {
                accNameSet.add(acc.Name);
            }
        }

        if(accNameSet.size() > 0) {
            Map<String, Account> accNameMap = new Map<String, Account>();
            for(Account acc : [SELECT Id, Name FROM Account WHERE Name IN :accNameSet]) {
                accNameMap.put(acc.Name, acc);
            }

            if(accNameMap.size() > 0) {
                for(Account acc : accList) {
                    if(accNameMap.get(acc.Name) != null) {
                        acc.Name.addError('Duplicate name');
                    }
                }
            }
        }
    }
}