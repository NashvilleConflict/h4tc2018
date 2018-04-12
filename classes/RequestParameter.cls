public class RequestParameter{
    @InvocableVariable(required=false)
    public String method;
    @InvocableVariable(required=false)
    public String namedCredential;
    @InvocableVariable(required=false)
    public String URI;
    @InvocableVariable(required=false)
    public String body;
    @InvocableVariable(required=false)
    public Boolean storeResponses;
    @InvocableVariable(required=false)
    public Request_Test__c requestTest;
}