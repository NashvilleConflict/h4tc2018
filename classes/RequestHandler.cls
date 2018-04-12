public class RequestHandler{
    //this is the method that can be called from Flow or Process Builder
    @InvocableMethod(label='handleNewRequests' description='Reconstitue the Request based on the variables passed from Flow')
    public static List<Request_Response__c[]> handleRequests(RequestParameter[] requestParameters) {
        HttpRequest[] requests = new HttpRequest[]{};
        for(RequestParameter parameters: requestParameters) requests.add(createRequest(parameters));
        Request_Response__c[] responses = new Request_Response__c[]{};
        for(HttpRequest request : requests){
            HttpResponse response = new Http().send(request);
            Request_Response__c requestResponse = new Request_Response__c(Status__c = response.getStatus(),Status_Code__c = response.getStatusCode(),Body__c = response.getBody());
            responses.add(requestResponse);
        }
        List<Request_Response__c[]> listOfResponses = new List<Request_Response__c[]>();
        listOfResponses.add(responses);
        return listOfResponses;
    }
    public static HttpRequest createRequest(RequestParameter parameters){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:'+parameters.namedCredential+'/'+parameters.URI);
        req.setMethod(parameters.method);
        req.setBody(parameters.body);
        return req;
    }
}