@isTest
public class RequestHandlerTest{
    @isTest private static void handleRequestsTest(){
        Test.setMock(HttpCalloutMock.class, new RequestHandlerTestMock());
        Test.startTest();
            insert new Request_Test__c(Body__c='test',URI__c='uri',Store_Response__c=true);
        Test.stopTest();
        system.debug([SELECT Body__c,Status_Code__c,Status__c FROM Request_Response__c]);
    }
}