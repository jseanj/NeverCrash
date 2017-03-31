#import "NSMutableDictionary+Crash.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableDictionary (Crash)
+ (void)nc_enableCrashGuard {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict nc_instanceSwizzleSelector:@selector(nc_objectForKey:) originalSelector:@selector(objectForKey:)];
    [dict nc_instanceSwizzleSelector:@selector(nc_setObject:forKey:) originalSelector:@selector(setObject:forKey:)];
    [dict nc_instanceSwizzleSelector:@selector(nc_removeObjectForKey:) originalSelector:@selector(removeObjectForKey:)];
}
- (id)nc_objectForKey:(id)aKey {
    if (aKey){
        return [self nc_objectForKey:aKey];
    }
    return nil;
}
- (void)nc_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self nc_setObject:anObject forKey:aKey];
    } else {
        NSLog(@"NSMutableDictionary setObject:forKey: args nil");
    }
}
- (void)nc_removeObjectForKey:(id)aKey {
    if (aKey) {
        [self nc_removeObjectForKey:aKey];
    } else {
        NSLog(@"NSMutableDictionary removeObjectForKey: args nil");
    }
}
@end
