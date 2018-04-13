public class RequestQueue implements Queueable, Database.AllowsCallouts{
    //requests passed from handler
    private RequestParameter[] requestParameters;
    //add requests to this context
    public RequestQueue(RequestParameter[] requestParameters) {
        this.requestParameters = requestParameters;
    }
    //perform callouts and possibly store responses
    public void execute(QueueableContext context) {
        Request_Response__c[] requestResponses = new Request_Response__c[]{};
        for(RequestParameter parameters: requestParameters){
            HttpResponse response = new Http().send(RequestHandler.createRequest(parameters));
            if(parameters.storeResponses) requestResponses.add(new Request_Response__c(Request_Test__c=parameters.requestTest==null?null:parameters.requestTest.Id,Status__c = response.getStatus(),Status_Code__c = response.getStatusCode(),Body__c = response.getBody()));
        }
        if(!requestResponses.isEmpty()) insert requestResponses;
    }
    
}