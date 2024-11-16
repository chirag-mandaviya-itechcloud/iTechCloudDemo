public class TestUtility {
    public static List<Account> CreateAccounts(Integer count, String Name) {
        List<Account> listAccount = new List<Account>();
        
        for (Integer i=0;i<count;i++) {
            Account acc = new Account();
            acc.name=name+i;
            listAccount.add(acc);
        }
        // insert listAccount;
        return listAccount;
    }
}