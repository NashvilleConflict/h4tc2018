public class SendTextMessage {
    //this is the method that can be called from Flow or Process Builder
    @InvocableMethod(label='handleNewRequests' description='Reconstitue the Request based on the variables passed from Flow')
    public static void handleRequests(RequestParameter[] requestParameters) {
        HttpRequest[] requests = new HttpRequest[]{};
        for(RequestParameter parameters: requestParameters) requests.add(createRequest(parameters));
        system.debug(requests);
    }
    public static HttpRequest createRequest(RequestParameter parameters){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:'+parameters.baseURL+'/'+parameters.URI);
        req.setMethod(parameters.method);
        req.setBody(parameters.body);
        return req;
    }
    public static HttpResponse sendText(String toNumber, String textMsg) {

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/AC2d3c3a0d7249b09d081f2b29e566c328/Messages');
        req.setMethod('POST');
        req.setBody('From='+EncodingUtil.urlEncode('+16152402110', 'UTF-8')+'&To='+EncodingUtil.urlEncode(toNumber, 'UTF-8')+ '&Body='+EncodingUtil.urlEncode(textMsg, 'UTF-8'));
        Blob headerValue = Blob.valueOf('AC2d3c3a0d7249b09d081f2b29e566c328' +':' +'332107429f513b41819ef991409c6367');
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        try {
            
            res = http.send(req);
            return res;
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e.getMessage());
            System.debug(res.toString());
            return null;
        }

    }

}