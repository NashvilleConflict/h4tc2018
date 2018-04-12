global class VolunteerJobBtach implements Database.Batchable<sObject>,Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
    
    String d1 = DateTime.now().addDays(-30).format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');

    String d2 = DateTime.now().addDays(-29).format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');


    String status ='Completed';
    
         system.debug('HCA :::');
        String query = 'SELECT Id, Mediation_Status__c,Mediation_Date_Time__c,Plaintiff1_Phone__c,Plaintiff1_Phone_Formatted__c,Plaintiff2_Phone__c,Plaintiff2_Phone_Formatted__c,Defendant1_Phone__c,Defendant1_Phone_Formatted__c,Defendant2_Phone__c,Defendant2_Phone_Formatted__c FROM GW_Volunteers__Volunteer_Job__c where Mediation_Date_Time__c > '+d1+' AND Mediation_Date_Time__c < '+d2+' AND Mediation_Status__c =\'Completed\'';
        system.debug('Query :::' + query);
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<GW_Volunteers__Volunteer_Job__c > scope) {
    String text = SMS_Message__c.getall().values()[0].SMS_Text_Message__c;
        for(GW_Volunteers__Volunteer_Job__c job : scope){
            
            
            if(job.Plaintiff1_Phone__c != null){
            job.Plaintiff1_Phone_Formatted__c = formatPhone(job.Plaintiff1_Phone__c);
            SendTextMessage.sendText( job.Plaintiff1_Phone_Formatted__c,text);
            }
            
            if(job.Plaintiff2_Phone__c != null){
            job.Plaintiff2_Phone_Formatted__c = formatPhone(job.Plaintiff2_Phone__c);
            SendTextMessage.sendText( job.Plaintiff2_Phone_Formatted__c,text);
            }
            
            
            if(job.Defendant1_Phone__c != null){
            job.Defendant1_Phone_Formatted__c = formatPhone(job.Defendant1_Phone__c);
            SendTextMessage.sendText( job.Defendant1_Phone_Formatted__c,text);
            }
            
            if(job.Defendant2_Phone__c != null){
            job.Defendant2_Phone_Formatted__c = formatPhone(job.Defendant2_Phone__c);
            SendTextMessage.sendText( job.Defendant2_Phone_Formatted__c ,text);
            }
        }
        update scope;
    }
    
    String formatPhone(String  phone){
        System.debug('HCA1:'+phone);
        String phone2 = phone.replaceAll('[^0-9]', '');
        
        if(phone2.startswith('+1')){
                phone2 = phone2;
            }
            if(phone2.startswith('1')){
                phone2 = '+' + phone2;
            }
            else{
                phone2 = '+1'+phone2;
            }
        System.debug('HCA1:'+phone2);   
        return phone2;
            
    }
    
    global void finish(Database.BatchableContext BC) {
    }

}