#import "NSObject+KVOCrash.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

static int const NCKVOCrashKey;

@implementation NSObject (KVOCrash)
+ (void)nc_enableKVOGuard {
    [self nc_swizzSelector:@selector(nc_addObserver:forKeyPath:options:context:) originalSelector:@selector(addObserver:forKeyPath:options:context:)];
    [self nc_swizzSelector:@selector(nc_removeObserver:forKeyPath:) originalSelector:@selector(removeObserver:forKeyPath:)];
}

+ (void)nc_disEnableKVOGuard {
    [self nc_swizzSelector:@selector(addObserver:forKeyPath:options:context:) originalSelector:@selector(nc_addObserver:forKeyPath:options:context:)];
    [self nc_swizzSelector:@selector(removeObserver:forKeyPath:) originalSelector:@selector(nc_removeObserver:forKeyPath:)];
}

- (NSMutableDictionary *)keyPathInfos {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &NCKVOCrashKey);
    if (!dict) {
        dict = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &NCKVOCrashKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (void)setKeyPathInfos:(NSMutableDictionary *)keyPathInfos {
    objc_setAssociatedObject(self, &NCKVOCrashKey, keyPathInfos, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)nc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    NSLog(@"swizzled addObserver");
    if (!observer || !keyPath) {
        return;
    }
    NSHashTable *observers = self.keyPathInfos[keyPath];
    if (observers && [observers containsObject:observer]) {
        NSLog(@"crash add observer: %@, keyPath: %@", observer, keyPath);
        return;
    }
    if (!observers) {
        observers = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality capacity:0];
    }
    [observers addObject:observer];
    [self.keyPathInfos setObject:observers forKey:keyPath];
    [self nc_addObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)nc_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSLog(@"swizzled removeObserver");
    if (!observer || !keyPath) {
        return;
    }
    NSHashTable *observers = self.keyPathInfos[keyPath];
    if (!observers) {
        NSLog(@"crash remove observer: %@, keyPath: %@", observer, keyPath);
        return;
    }
    if (![observers containsObject:observer]) {
        NSLog(@"crash remove observer: %@, keyPath: %@", observer, keyPath);
        return;
    }
    [observers removeObject:observer];
    [self.keyPathInfos setObject:observers forKey:keyPath];
    [self nc_removeObserver:observer forKeyPath:keyPath];
}

@end
