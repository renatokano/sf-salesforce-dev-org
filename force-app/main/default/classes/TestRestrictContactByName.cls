@isTest
private with sharing class TestRestrictContactByName {
    @isTest static void TestInsertAnInvalidContactName() {
        // create an invalid contact name
        Contact c = new Contact(LastName = 'INVALIDNAME');
        
        // perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(c, false);
        Test.stopTest();
        
        // test verification
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals(result.getErrors()[0].getMessage(), 'Test Last Name "'+ c.LastName +'" is not allowed for DML');
    }

    @isTest static void TestInsertAValidContactName(){
        // create a valid contact name
        Contact c = new Contact(LastName = 'Honda');

        // perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(c);
        Test.stopTest();

        // test verification
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
}
