#import <Foundation/Foundation.h>

@interface NSObject (KVOCrash)
+ (void)nc_enableKVOGuard;
+ (void)nc_disEnableKVOGuard;
@end
