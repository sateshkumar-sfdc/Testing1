@isTest
public class DealerSupportController_Test{
    @isTest static void UNITTest() { 
        Auth.UserData userData = new Auth.UserData('testId', 'testFirst', 'testLast',
        'testFirst testLast', 'no-reply@salesforce.com', null, 'testuserlong', 'en_US', 'facebook',
        null, new Map<String, String>{'language' => 'en_US'});
        ChatterAnswersAuthProviderRegistration reg = new ChatterAnswersAuthProviderRegistration();
        Profile[] p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User[] adminUser = [SELECT Id, Firstname, Lastname FROM User WHERE IsActive = true and ProfileId =: p[0].Id LIMIT 1];
        reg.setSiteAdminUserId(adminUser[0].Id);
        User newUser = reg.createUser(null, userData);
        
        Contact c = new Contact();
        c.AccountId = (newUser.Username.split('@'))[0];
        c.LastName = 'contactLast';
        insert(c);

        profile pf = [select Id,Name from Profile where name like 'Dealer - Corporate' limit 1];

        newuser.profileId  = pf.id;
        newUser.Alias = 'firstusr';
        newUser.TimeZoneSidKey = 'America/Los_Angeles';
        newUser.LocaleSidKey = 'en_US';
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.ContactId = c.Id;

        insert(newUser);
        System.runAs ( newUser ) {
        wDealerCase wobj = DealerSupportController.getNewCase();      
        DealerSupportController.saveNewCase(JSON.serialize(wobj)); 
        }     
    }
}