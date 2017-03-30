#import "NSDictionary+Crash.h"
#import "NSObject+Swizzling.h"

@implementation NSDictionary (Crash)
+ (void)nc_enableCrashGuard {
    [NSDictionary nc_classSwizzleSelector:@selector(nc_dictionaryWithObject:forKey:) originalSelector:@selector(dictionaryWithObject:forKey:)];
    [NSDictionary nc_classSwizzleSelector:@selector(nc_dictionaryWithObjects:forKeys:count:) originalSelector:@selector(dictionaryWithObjects:forKeys:count:)];
}
+ (instancetype)nc_dictionaryWithObject:(id)object forKey:(id<NSCopying>)key {
    if (object&&key) {
        return [self nc_dictionaryWithObject:object forKey:key];
    }
    NSLog(@"NSDictionary dictionaryWithObject args nil");
    return nil;
}
+ (instancetype)nc_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    NSInteger index = 0;
    id ks[cnt];
    id objs[cnt];
    for (NSInteger i = 0; i < cnt ; ++i) {
        if (keys[i] && objects[i]) {
            ks[index] = keys[i];
            objs[index] = objects[i];
            ++index;
        } else {
            NSLog(@"NSDictionary dictionaryWithObjects args nil");
        }
    }
    return [self nc_dictionaryWithObjects:objs forKeys:ks count:index];
}
@end
