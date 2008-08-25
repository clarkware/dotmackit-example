#import "ArticleTest.h"
#import <DotMacKit/DotMacKit.h>


@implementation ArticleTest

- (void) testCreateCheckAccount {
    
    DMMemberAccount *myMemberAccount = 
        [DMMemberAccount accountFromPreferencesWithApplicationID:@"----"];
    
    [myMemberAccount setApplicationName:@"My Killer App"];
      
    if ([myMemberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
    [myMemberAccount setIsSynchronous:YES];
    
    DMTransaction *daysLeftTransaction = [myMemberAccount daysLeftUntilExpiration];
    if ([daysLeftTransaction isSuccessful]) { 
        NSNumber *daysLeft = [daysLeftTransaction result]; 
        if ([daysLeft intValue] == 0) {
            UKFail();
        }
    } else { 
        UKFail();
    }
    
    DMTransaction *serviceTransaction = 
        [myMemberAccount servicesAvailableForAccount]; 
    
    if ([serviceTransaction isSuccessful]) { 
        NSArray *services = [serviceTransaction result]; 
        if ([services containsObject:kDMiDiskService] == NO) {
            UKFail();
        } 
    } else { 
        UKFail();
    }
    
    UKPass();
} 

- (void) testSignUp {
    
    DMMemberAccount *myMemberAccount = 
        [DMMemberAccount accountFromPreferencesWithApplicationID:@"----"];

    if ([myMemberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
    // [DMMemberAccount signUpNewMemberWithApplicationID:@"----"];
    // NSURL *url = [DMMemberAccount signUpURLWithApplicationID:@"----"];
} 

- (void) testUploadFile {
    
    DMMemberAccount *myMemberAccount = 
        [DMMemberAccount accountFromPreferencesWithApplicationID:@"----"];
    
    if ([myMemberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
	DMiDiskSession *mySession = [DMiDiskSession iDiskSessionWithAccount:myMemberAccount];
	
    NSString *filePath = @"/local/path/to/Example.plist";
    
    DMTransaction *uploadTransaction = 
        [mySession putLocalFileAtPath:filePath toPath:@"/Documents/Example.plist"];
	
	if (uploadTransaction != nil) {
        UKPass();
	} else {
        UKFail();
	}
} 

- (void) testUploadData {
    
    DMMemberAccount *myMemberAccount = 
        [DMMemberAccount accountFromPreferencesWithApplicationID:@"----"];
    
    if ([myMemberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
	DMiDiskSession *mySession = [DMiDiskSession iDiskSessionWithAccount:myMemberAccount];
	
    NSString *message = @"hello world";
    NSData *messageData = [message dataUsingEncoding:NSASCIIStringEncoding];
	
    DMTransaction *uploadTransaction = 
        [mySession putData:messageData toPath:@"/Documents/upload.txt"];
        
	if (uploadTransaction != nil) {
        UKPass();
	} else {
        UKFail();
	}
} 

- (void) testDownloadData {
    
    DMMemberAccount *myMemberAccount = 
        [DMMemberAccount accountFromPreferencesWithApplicationID:@"----"];
    
    if ([myMemberAccount validateCredentials] != kDMSuccess) {         
        UKFail();
	}
    
	DMiDiskSession *mySession = [DMiDiskSession iDiskSessionWithAccount:myMemberAccount];
	
    [mySession setDelegate:self];
	
	DMTransaction *downloadTransaction = [mySession getDataAtPath:@"/Documents/upload.txt"];	
    
	if (downloadTransaction != nil) {
        UKPass();
	} else {
        UKFail();
	}
    
    int transactionState = [downloadTransaction transactionState]; 
    SInt64 bytesMovedSoFar = [downloadTransaction bytesTransferred]; 
    SInt64 bytesToMove = [downloadTransaction contentLength];
} 

- (void)transactionSuccessful: (DMTransaction *)theTransaction {
    NSLog(@"A transaction was successful");
    NSString *result = [[NSString alloc]initWithData:[theTransaction result] encoding:NSASCIIStringEncoding];
}

- (void)transactionHadError: (DMTransaction *)theTransaction {
    NSLog(@"A transaction had an error");
    // asynchronous transaction failed
    int errorType = [theTransaction errorType];
}

- (void)transactionAborted: (DMTransaction *)theTransaction {
    NSLog(@"A transaction was aborted");
}

@end