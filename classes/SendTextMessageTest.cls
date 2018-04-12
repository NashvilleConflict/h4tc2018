@isTest    
class SendTextMessageTest
{
    @isTest private static void testCallout()
    {
        insert new SMS_Message__c(name = 'SMS Text', SMS_Text_Message__c = 'test');
        Test.StartTest();
        Database.Batchable<sObject> exceptionLogArchive = new VolunteerJobBtach();
        database.executeBatch(exceptionLogArchive );
        
        Test.setMock(HttpCalloutMock.class, new SendTextMessageMock());
        HttpResponse res = SendTextMessage.sendText('number','text');
        System.debug('res:'+res);
    Test.StopTest();
    }
    
    @isTest private static void testBatch(){
        
        insert new SMS_Message__c(name = 'SMS Text', SMS_Text_Message__c = 'test');
        
        Campaign can = new Campaign();
        can.name='test';
        can.isActive=true;
        insert can;

        GW_Volunteers__Volunteer_Job__c  job = new GW_Volunteers__Volunteer_Job__c();
        job.Mediation_Date_Time__c = DateTime.now().addDays(-30);
        job.Mediation_Status__c ='Completed';
        job.Plaintiff1_Phone__c='5168393543';
        job.GW_Volunteers__Campaign__c =can.Id;
        
        insert job;
        
        VolunteerJobBtach c = new VolunteerJobBtach();

        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new SendTextMessageMock());
        Database.executeBatch(new VolunteerJobBtach());
        Test.StopTest();
    
        }

}