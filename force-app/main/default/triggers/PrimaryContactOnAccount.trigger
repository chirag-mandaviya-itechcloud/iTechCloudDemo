trigger PrimaryContactOnAccount on Contact (before insert, before update) {
    if (Trigger.isInsert && Trigger.isBefore || Trigger.isUpdate && Trigger.isBefore) {
        PrimaryContactOnAccountHandler.CheckPrimary(Trigger.new);
    }
}