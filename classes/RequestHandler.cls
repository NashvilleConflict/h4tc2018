public class RequestHandler{
    //this is the method that can be called from Flow or Process Builder
    @InvocableMethod(label='handleNewRequests' description='Reconstitue the Request based on the variables passed from Flow')
    public static void handleRequests(RequestParameter[] requestParameters) {
        ID jobID = System.enqueueJob(new RequestQueue(requestParameters));
    }
    public static HttpRequest createRequest(RequestParameter parameters){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:'+parameters.namedCredential+'/'+parameters.URI);
        req.setMethod(parameters.method);
        req.setBody(parameters.body);
        return req;
    }
}