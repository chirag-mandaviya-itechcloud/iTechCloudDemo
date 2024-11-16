trigger AccountTrigger on Account (before insert, after insert, after update) {


    if(Trigger.isInsert && Trigger.isBefore){
        AccountTriggerHandler.CreateAccounts(Trigger.new);
    }
    
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore) {
        AccountTriggerHandler.PreventNameDuplication(Trigger.new);
    }

    if ((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter) {
        AccountTriggerHandler.CreateContact(Trigger.new);
    }
}