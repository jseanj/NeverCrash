#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)
+ (void)nc_swizzSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector {
    Method originalMethod = class_getInstanceMethod([NSObject class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([NSObject class], swizzledSelector);
    BOOL success = class_addMethod([NSObject class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod([NSObject class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
