#import <Foundation/Foundation.h>

@interface NSObject (BadAccessCrash)
+ (void)nc_enableBadAccessGuard;
@end
