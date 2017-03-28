#import "NeverCrashManager.h"
#import "NSObject+KVOCrash.h"

@implementation NeverCrashManager
+ (instancetype)shared {
    static NeverCrashManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NeverCrashManager alloc] init];
    });
    return manager;
}

- (void)enable {
    [NSObject nc_enableKVOGuard];
}

- (void)disEnable {
    [NSObject nc_disEnableKVOGuard];
}
@end
