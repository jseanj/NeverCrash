#import "NeverCrashManager.h"
#import "NSObject+KVOCrash.h"
#import "NSObject+SelectorCrash.h"

@implementation NeverCrashManager
+ (void)enable {
    [NSObject nc_enableKVOGuard];
    [NSObject nc_enableSelectorGuard];
}
@end
