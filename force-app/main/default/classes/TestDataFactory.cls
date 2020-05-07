@isTest
public with sharing class TestDataFactory {
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct){
        // create an empty account list
        List<Account> accts = new List<Account>();
        // create numAccts new accounts and insert all into our account list
        for(Integer i=0; i<numAccts; i++){
            // create a new account
            Account a = new Account(Name = 'TestAccount' + i);
            // insert to account list
            accts.add(a);
        }
        // insert the account list to db (DML instruction)
        insert accts;

        // create an empty opportunity list
        List<Opportunity> opps = new List<Opportunity>();
        
        for(Integer i=0; i<numAccts; i++){
            // retrieve each account created in the last block
            Account a = accts[i];
            // for each account, we'll add numOppsPerAcct new opportunities
            for (Integer j=0; j<numOppsPerAcct; j++){
                Opportunity o = new Opportunity(
                    Name = a.Name + ' Opportunity ' + j,
                    StageName = 'Prospecting',
                    CloseDate = System.today().addMonths(1),
                    AccountId = a.Id    
                );
                opps.add(o);
            }
        }
        // insert the opportunities for all accounts (DML instruction)
        insert opps;

        // return all accounts created and yours opportunities
        return accts;
    }
}
