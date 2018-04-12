global class  VolunteerJobScheduler implements Schedulable     {
    global void execute(SchedulableContext ctx) {
        database.executeBatch(new VolunteerJobBtach());
}}