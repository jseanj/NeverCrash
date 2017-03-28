#import "NeverCrashManager.h"
#import "NSObject+KVOCrash.h"
#import "NSObject+SelectorCrash.h"

@implementation NeverCrashManager
+ (void)enable {
    [NSObject nc_enableKVOGuard];
    [NSObject nc_enableSelectorGuard];
}

+ (void)disEnable {
    [NSObject nc_disEnableKVOGuard];
    [NSObject nc_disEnableSelectorGuard];
}
@end
