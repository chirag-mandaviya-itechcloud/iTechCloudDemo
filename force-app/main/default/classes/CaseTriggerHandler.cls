public class CaseTriggerHandler {
    public static void AfterInsert(List<Case> newCases) {
        AddCaseNumberToAccount(newCases);
    }

    public static void BeforeInsert(List<Case> newCases) {
        LinkCaseToContact(newCases);
    }

    public static void AddCaseNumberToAccount(List<Case> newCase) {
        List<Account> accounts = new List<Account>();
        for(Case ca: newCase) {
            Account acc = [SELECT Id, Case_Number__c FROM Account WHERE Id =: ca.AccountId];
            acc.Case_Number__c = ca.CaseNumber;
            accounts.add(acc);
        }
        if(accounts.size() > 0) {
            update accounts;
        }
    }

    public static void LinkCaseToContact(List<Case> newCase) {
        System.debug('link to contact');
        List<Contact> conList = new List<Contact>();
        Map<Case, Contact> caseContactMap = new Map<Case, Contact>();
        for(Case c: newCase) {
            if(c.SuppliedEmail != null){
                System.debug(c.SuppliedEmail);
                List<Contact> con = [SELECT Id, Email, Account.Name FROM Contact WHERE Email =: c.SuppliedEmail LIMIT 1];
                if (con.size() == 0) {
                    System.debug('consize' + con.size());
                    Contact cont = new Contact(
                        AccountId = c.AccountId,
                        LastName = 'Contact Created From Case',
                        Email = c.SuppliedEmail);
                    conList.add(cont);
                    caseContactMap.put(c, cont);
                    // c.ContactId = cont.Id;
                }
                else {
                    c.ContactId = con[0].Id;
                }
            }
        }
        if (!conList.isEmpty()) {
            insert conList;

            for(Case c: caseContactMap.keySet()) {
                Contact insertedContact = caseContactMap.get(c);
                c.ContactId = insertedContact.Id;
            }
        }
    }
}