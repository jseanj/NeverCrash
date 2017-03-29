#import "NSObject+BadAccessCrash.h"
#import <objc/runtime.h>

static void nc_emptyIMP(id obj, SEL _cmd) {}
static NSMethodSignature *nc_zombieMethodSignatureForSelector(id obj, SEL _cmd, SEL selector) {
    Class class = object_getClass(obj);
    NSString *className = NSStringFromClass(class);
    className = [className substringFromIndex: [@"MAZombie_" length]];
    NSLog(@"Selector %@ sent to deallocated instance %p of class %@", NSStringFromSelector(selector), obj, className);
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

Class NCZombifyClass(Class class) {
    NSString *className = NSStringFromClass(class);
    NSString *zombieClassName = [@"NCZombie_" stringByAppendingString: className];
    Class zombieClass = NSClassFromString(zombieClassName);
    if(zombieClass) {
        return zombieClass;
    }
    zombieClass = objc_allocateClassPair(nil, [zombieClassName UTF8String], 0);
    class_addMethod(zombieClass, @selector(methodSignatureForSelector:), (IMP)nc_zombieMethodSignatureForSelector, "@@::");
    class_addMethod(object_getClass(zombieClass), @selector(initialize), (IMP)nc_emptyIMP, "v@:");
    objc_registerClassPair(zombieClass);
    
    return zombieClass;
}

static void nc_zombieDealloc(id obj, SEL _cmd) {
    Class klass = NCZombifyClass(object_getClass(obj));
    object_setClass(obj, klass);
}

@implementation NSObject (BadAccessCrash)
+ (void)nc_enableBadAccessGuard {
    Method method = class_getInstanceMethod([NSObject class], @selector(dealloc));
    method_setImplementation(method, (IMP)nc_zombieDealloc);
}
@end
