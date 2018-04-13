@isTest
public class PhoneUtilityTest{
    @testSetup static void testSetup() {
        insert new Contact( RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Recipient').getRecordTypeId(),
                            LastName='TestLastName',
                            MobilePhone='5555555555');
    }
    @isTest private static void updatePhoneFormatTest(){
        Test.startTest();
            system.assertEquals('+1',[SELECT MobilePhone FROM Contact LIMIT 1].MobilePhone.left(2));
        Test.stopTest();
    }
}