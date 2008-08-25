#import "DiskSessionTest.h"
#import <DotMacKit/DotMacKit.h>

@implementation DiskSessionTest

- (void) testCreate {  
    
    DMMemberAccount *memberAccount = 
        [DMMemberAccount accountWithName:@"account_name"
                         password:@"account_password"
                         applicationID:@"----"];
    
    if ([memberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
    DMiDiskSession *iDiskSession = [DMiDiskSession iDiskSessionWithAccount:memberAccount];
    [iDiskSession setIsSynchronous:YES]; 
     
    DMTransaction *txn = [iDiskSession quotaAttributes];
    if ([txn isSuccessful]) { 
        NSDictionary *attributes = [txn result];
        NSNumber *quota = [attributes objectForKey:kDMiDiskQuotaInBytes];
        UKTrue([quota intValue] > 1000000);
    } else { 
        UKFail();
    }
} 

@end
