#import "MemberAccountTest.h"
#import <DotMacKit/DotMacKit.h>

@implementation MemberAccountTest

- (void) testCreate {  
    
    DMMemberAccount *memberAccount = 
        [DMMemberAccount accountWithName:@"account_name"
                         password:@"account_password"
                         applicationID:@"----"];
        
    if ([memberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}

    UKPass();
} 

- (void) testInformation {  
    
    DMMemberAccount *memberAccount = 
        [DMMemberAccount accountWithName:@"account_name"
                         password:@"account_password"
                         applicationID:@"----"];
    
    [memberAccount setApplicationName:@"My Killer App"];
    [memberAccount setIsSynchronous:YES];
    
    UKStringsEqual(@"account_name", [memberAccount name]);
    UKStringsEqual(@"My Killer App", [memberAccount applicationName]);
    UKStringsEqual(@"----", [memberAccount applicationID]);
    UKTrue([memberAccount isSynchronous]);
    
    if ([memberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
    UKPass();
} 

- (void) testExpiration {  
    
    DMMemberAccount *memberAccount = 
        [DMMemberAccount accountWithName:@"account_name"
                         password:@"account_password"
                         applicationID:@"----"];
    
    [memberAccount setIsSynchronous:YES];
    
    if ([memberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
    DMTransaction *expireTxn = [memberAccount daysLeftUntilExpiration]; 
    if ([expireTxn isSuccessful]) { 
        NSNumber *daysLeft = [expireTxn result]; 
        UKTrue([daysLeft intValue] > 0);
    } else { 
        UKFail();
    }
} 

- (void) testServices {  
    
    DMMemberAccount *memberAccount = 
        [DMMemberAccount accountWithName:@"account_name"
                         password:@"account_password"
                         applicationID:@"----"];
    
    [memberAccount setIsSynchronous:YES];
    
    if ([memberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
    DMTransaction *serviceTxn = [memberAccount servicesAvailableForAccount]; 
    if ([serviceTxn isSuccessful]) { 
        NSArray *services = [serviceTxn result]; 
        UKTrue([services containsObject:kDMiDiskService]);
        UKTrue([services containsObject:kDMEmailService]);
        UKTrue([services containsObject:kDMWebHostingService]);
        UKTrue([services containsObject:kDMiSyncService]);
    } else { 
        UKFail();
    }
} 

@end