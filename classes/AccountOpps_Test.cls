@IsTest
public class AccountOpps_Test {
    @isTest static void setDefaultDescription(){
        Account acc = new Account(Name = 'My Test Account',Description='Default description');
        insert acc;
        acc = AccountOpps.setDefaultDescription(acc);
        System.assertEquals('Default description',acc.Description,'message');
    }
}