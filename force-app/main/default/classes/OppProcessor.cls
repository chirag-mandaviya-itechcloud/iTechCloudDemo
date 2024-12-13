public class OppProcessor implements Database.Batchable<sObject>, Database.stateful {
    public integer rCount = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Name FROM Opportunity]);
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> opps) {
        for (Opportunity opp : opps) {
            opp.LeadSource = 'Web';
        }
        update opps;
        rCount = rCount + opps.size();
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Total records processed ' + rCount);
    }
}