trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            OpportunityTriggerHandler.AfterInsert(Trigger.new);
        }

        when AFTER_UPDATE {
            OpportunityTriggerHandler.AfterUpdate(Trigger.new, Trigger.oldMap);
        }

        when AFTER_DELETE {
            OpportunityTriggerHandler.AfterDelete(Trigger.oldMap);
        }

        when AFTER_UNDELETE {
            OpportunityTriggerHandler.AfterUndelete(Trigger.new);
        }

        when BEFORE_INSERT {
            OpportunityTriggerHandler.BeforeInsert(Trigger.new);
        }
    }
}