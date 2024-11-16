public class PrimaryContactOnAccountHandler {
    public static void CheckPrimary(List<Contact> newContacts) {
        for(Contact con: newcontacts) {
            if (con.Is_Primary__c == true) {
                List<Contact> conList = new List<Contact>();
                conList = [SELECT Id, AccountId, Is_Primary__c FROM Contact WHERE AccountID =:con.AccountId AND Is_Primary__c = true AND Id != :con.Id];
                if (!conList.isEmpty()) {
                    con.addError('Cannot Insert Primary Contact');
                }
            }
        }
    }
}