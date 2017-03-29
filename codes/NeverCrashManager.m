#import "NeverCrashManager.h"
#import "NSObject+KVOCrash.h"
#import "NSObject+SelectorCrash.h"
#import "NSObject+BadAccessCrash.h"
#import "NSTimer+Crash.h"
#import "CALayer+Crash.h"
#import "NSString+Crash.h"

@implementation NeverCrashManager
+ (void)enableOptions:(NCCrashKindOptions)options {
    if (options & NCCrashKindSelector) {
        [NSObject nc_enableSelectorGuard];
    }
    if (options & NCCrashKindKVO) {
        [NSObject nc_enableKVOGuard];
    }
    if (options & NCCrashKindNotification) {
        
    }
    if (options & NCCrashKindTimer) {
        [NSTimer nc_enableCrashGuard];
    }
    if (options & NCCrashKindUIThread) {
        [CALayer nc_enableCrashGuard];
    }
    if (options & NCCrashKindContainer) {
        [NSString nc_enableCrashGuard];
    }
    if (options & NCCrashKindBadAccess) {
        [NSObject nc_enableBadAccessGuard];
    }
}
@end
