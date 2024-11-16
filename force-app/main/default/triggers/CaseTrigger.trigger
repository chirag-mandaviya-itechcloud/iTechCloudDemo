trigger CaseTrigger on Case (before insert, after insert) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            CaseTriggerHandler.BeforeInsert(Trigger.new);
        }
        when AFTER_INSERT {
            CaseTriggerHandler.AfterInsert(Trigger.new);
        }
    }
}