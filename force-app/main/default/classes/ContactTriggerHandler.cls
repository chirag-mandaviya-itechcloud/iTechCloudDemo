public class ContactTriggerHandler {
    public static void BeforeInsert(List<Contact> newCon) {
        PreventCreateThirdContact(newCon);
    }

    public static void PreventCreateThirdContact(List<Contact> newCon) {
        For (Contact con : newCon) {
            List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId =: con.AccountId];
            If (conList.size()>=2) {
                con.addError('You can\'t create third contact');
            }
        }
    }
}