public class OpportunityTriggerHandler {
    public static void AfterInsert(List<Opportunity> newOpps) {
        SumOfAmountOnAccount(newOpps, null);
    }

    public static void AfterUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        SumOfAmountOnAccount(newOpps, oldOppsMap);
    }

    public static void AfterDelete(Map<Id, Opportunity> oldOppsMap) {
        SumOfAmountOnAccount(null, oldOppsMap);
    }

    public static void AfterUndelete(List<Opportunity> newOpps) {
        SumOfAmountOnAccount(newOpps, null);
    }

    public static void BeforeInsert(List<Opportunity> newOpps) {
        // 
    }

    public static void SumOfAmountOnAccount(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        Set<Id> accIdSet = new Set<Id>();
        if (newOpps != null && newOpps.size() > 0) {
            for( Opportunity opp : newOpps ) {
                if (
                    (oldOppsMap == null && opp.AccountId != null && opp.Amount != null) || 
                    (oldOppsMap != null && opp.AccountId != null && opp.Amount != null && opp.Amount != oldOppsMap.get(opp.Id).Amount)
                ){
                    accIdSet.add(opp.AccountId);
                }
            }
        }
        else {
            for(Opportunity opp: oldOppsMap.values()) {
                if(opp.AccountId != null && opp.Amount != null) {
                    accIdSet.add(opp.AccountId);
                }
            }
        }

        if (accIdSet != null && accIdSet.size() > 0) {
            List<AggregateResult> oppList = [SELECT SUM(Amount)totalAmount, AccountId FROM Opportunity WHERE AccountId IN :accIdSet GROUP BY AccountId];
            List<Account> accList = new List<Account>();

            if (oppList != null && oppList.size() > 0) {
                for (AggregateResult ar : oppList) {
                    Account a = new Account(
                        Id = (Id)ar.get('AccountId'),
                        Total_Amount_of_Opportunities__c = Integer.valueOf(ar.get('totalAmount'))
                    );
                    accList.add(a);
                }
            }

            if(accList != null && accList.size() > 0){
                try {
                    update accList;
                } catch (Exception e) {
                    System.debug('DML Exception'+e);
                }
            }
        }
    }
}