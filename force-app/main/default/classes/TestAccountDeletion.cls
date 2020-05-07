@isTest
private with sharing class TestAccountDeletion {
    @isTest static void TestDeleteAccountWithOneOpportunity() {
        // test data setup
        // create an account w/ an opportunity and insert to db
        Account[] a = TestDataFactory.createAccountsWithOpps(1, 1);

        // perforn test
        // try to delete our account
        Test.startTest();
        Database.DeleteResult result = Database.delete(a[0], false);
        Test.stopTest();

        // verify the result
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.', 
            result.getErrors()[0].getMessage());
    }

    @isTest static void TestDeleteAccountWithNoOpportunities() {
        // test data setup
        // create an account w/o an opportunity and insert to db
        Account[] a = TestDataFactory.createAccountsWithOpps(1, 0);

        // perforn test
        // try to delete our account
        Test.startTest();
        Database.DeleteResult result = Database.delete(a[0], false);
        Test.stopTest();

        // verify the result
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }

    @isTest static void TestDeleteBulkAccountsWithOpportunities() {
        // test data setup
        // create 10 accounts w/ 10 opportunities
        Account[] accts = TestDataFactory.createAccountsWithOpps(10, 10);

        // perform test
        // try to delete all new accounts
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(accts,false);
        Test.stopTest();

        // verify the result
        for(Database.DeleteResult result : results){
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('Cannot delete account with related opportunities.', 
            result.getErrors()[0].getMessage());
        }
    }

    @isTest static void TestDeleteBulkAccountsWithNoOpportunities() {
        // test data setup
        // create 10 accounts w/o any opportunity
        Account[] accts = TestDataFactory.createAccountsWithOpps(10, 0);

        // perform test
        // try to delete all new accounts
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(accts,false);
        Test.stopTest();

        // verify the result
        for(Database.DeleteResult result : results){
            System.assert(result.isSuccess());
            System.assert(result.getErrors().size() == 0);
        }
    }
}
