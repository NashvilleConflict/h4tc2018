public class PhoneUtility{
    //variables set by process builder
    public class PhoneParameter{
        @InvocableVariable(required=true)
        public String objectName;
        @InvocableVariable(required=true)
        public Id recordId;
        @InvocableVariable(required=true)
        public String phoneValue;
        @InvocableVariable(required=true)
        public String phoneField;
    }
    //this is the method that can be called from Flow or Process Builder
    @InvocableMethod(label='Update Phone Format' description='Format the phone number to start with +1')
    public static void updatePhoneFormat(PhoneParameter[] phoneParameters) {
        sObject[] phoneRecords = new sObject[]{};
        for(PhoneParameter parameters : phoneParameters){
            sObject phoneRecord = Schema.getGlobalDescribe().get(parameters.objectName).newSObject();
            phoneRecord.Id=parameters.recordId;
            phoneRecord.put(parameters.phoneField,formatPhone(parameters.phoneValue));
            phoneRecords.add(phoneRecord);
        }
        if(!phoneRecords.isEmpty()) update phoneRecords;
    }
    public static String formatPhone(String phone){
        //remove hyphens
        phone = phone.replaceAll('[^0-9]', '');
        //put '+1' at the begining of the phone number
        if(phone.startswith('1')&&phone.length()==11) phone = '+' + phone;
        else phone = '+1'+phone;
        return phone;
    }
}