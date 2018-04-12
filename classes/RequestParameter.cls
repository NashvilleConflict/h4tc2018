public class RequestParameter{
    @InvocableVariable(required=true)
    public String method;
    @InvocableVariable(required=true)
    public String baseURL;
    @InvocableVariable(required=true)
    public String URI;
    @InvocableVariable(required=true)
    public String body;
}