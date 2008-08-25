#import <Cocoa/Cocoa.h>
#import "AsyncExample.h"

int main(int argc, const char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    AsyncExample *e = [[AsyncExample alloc] init];
    int code = [e run];

    [e release];
    [pool release];
    return code;
}
