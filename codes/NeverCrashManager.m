#import "NeverCrashManager.h"
#import "NSObject+KVOCrash.h"
#import "NSObject+SelectorCrash.h"
#import "NSTimer+Crash.h"
#import "CALayer+Crash.h"

@implementation NeverCrashManager
+ (void)enable {
    [NSObject nc_enableKVOGuard];
    [NSObject nc_enableSelectorGuard];
    [NSTimer nc_enableCrashGuard];
    [CALayer nc_enableCrashGuard];
}
@end
