#import "AsyncTest.h"
#import <DotMacKit/DotMacKit.h>

@implementation AsyncTest

- (void) testAsyncTransaction {  
        
    DMMemberAccount *memberAccount = 
        [DMMemberAccount accountWithName:@"account_name"
                                password:@"account_password"
                           applicationID:@"----"];
    
    if ([memberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
    [memberAccount setDelegate:self];
    
    DMTransaction *daysLeftTxn = [memberAccount daysLeftUntilExpiration];
    if (daysLeftTxn == nil) {
        UKFail();
    }
    
    sleep(10);
    
    UKTrue([daysLeftTxn isSuccessful]);
} 

- (void)transactionSuccessful: (DMTransaction *)theTransaction
{       
    NSLog(@"******************************************************");
    NSLog(@"A transaction was successful");
    NSLog(@"******************************************************");
}

@end
