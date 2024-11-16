public class NewAccountAction {
	@invocableMethod
    public static List<decimal> updateAccRevenue(List<ID> ids) {
        List<Opportunity> oppList = [SELECT AccountId, Amount FROM Opportunity WHERE Id =:ids[0]];
        List<Account> accList = [SELECT AnnualRevenue FROM Account WHERE Id =:oppList[0].AccountId];
        
        List<Decimal> annualRevenueList = new List<Decimal>();
        accList[0].AnnualRevenue = accList[0].AnnualRevenue + oppList[0].Amount;
        update accList;

        annualRevenueList.add(accList[0].AnnualRevenue);
        return annualRevenueList;
        
    }
}