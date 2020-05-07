@isTest
private with sharing class TestAccountDeletion {
    @isTest static void TestDeleteAccountWithOneOpportunity() {
        // test data setup
        // create an account and insert to db
        Account a = new Account(Name = 'Test Account');
        insert a;

        // create an opportunity and link to our account and insert to db
        Opportunity o = new Opportunity(AccountId = a.Id,
            Name = a.Name + ' Opportunity',
            StageName = 'Prospecting',
            CloseDate = System.today().addMonths(1)    
        );
        insert o;

        // perforn test
        // try to delete our account
        Test.startTest();
        Database.DeleteResult result = Database.delete(a, false);
        Test.stopTest();

        // verify the result
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.', 
            result.getErrors()[0].getMessage());
    }
}
