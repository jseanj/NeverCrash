#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)
- (void)nc_instanceSwizzleSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector {
    Class klass = [self class];
    Method originalMethod = class_getInstanceMethod(klass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(klass, swizzledSelector);
    BOOL success = class_addMethod(klass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(klass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
+ (void)nc_classSwizzleSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector {
    Class klass = [self class];
    Method originalMethod = class_getClassMethod(klass, originalSelector);
    Method swizzledMethod = class_getClassMethod(klass, swizzledSelector);
    Class metaKlass = objc_getMetaClass(NSStringFromClass(klass).UTF8String);
    BOOL success = class_addMethod(metaKlass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(metaKlass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
