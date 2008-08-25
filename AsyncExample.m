#import "AsyncExample.h"
#import <DotMacKit/DotMacKit.h>

@implementation AsyncExample

- (int) run {
    
    DMMemberAccount *memberAccount;
    memberAccount = [DMMemberAccount accountWithName:@"account_name"
                                            password:@"account_password"
                                       applicationID:@"----"];
    
    if ([memberAccount validateCredentials] != kDMSuccess) {         
        return 1;
	}
    
    [memberAccount setDelegate:self];
    
    DMTransaction *daysLeftTxn = [memberAccount daysLeftUntilExpiration];
    if (daysLeftTxn == nil) {
        return 1;    
    }
    
    [memberAccount autorelease];
    
    return 0;
} 

- (void)transactionSuccessful: (DMTransaction *)theTransaction
{       
    NSLog(@"******************************************************");
    NSLog(@"A transaction was successful");
    NSLog(@"******************************************************");
}

@end

