public class LeadProcessor implements Database.Batchable<sObject>, Database.stateful{
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([Select LeadSource From Lead ]);
    }

    public void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead Leads:scope){
            Leads.LeadSource='Dreamforce';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        
    }
}