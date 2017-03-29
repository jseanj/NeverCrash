#import "NSObject+SelectorCrash.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@interface NCUnrecognizedSelectorSolveObject : NSObject
@end

@implementation NCUnrecognizedSelectorSolveObject
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)addMethod, "v@:@");
    return YES;
}

id addMethod(id self, SEL _cmd) {
    NSLog(@"unrecognized selector: %@", NSStringFromSelector(_cmd));
    return 0;
}
@end

@implementation NSObject (SelectorCrash)
+ (void)nc_enableSelectorGuard {
    NSObject *object = [[NSObject alloc] init];
    [object nc_instanceSwizzleSelector:@selector(nc_forwardingTargetForSelector:) originalSelector:@selector(forwardingTargetForSelector:)];
}

- (id)nc_forwardingTargetForSelector:(SEL)aSelector {
    if (class_respondsToSelector([self class], @selector(forwardInvocation:))) {
        IMP impOfNSObject = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
        IMP imp = class_getMethodImplementation([self class], @selector(forwardInvocation:));
        if (imp != impOfNSObject) {
            NSLog(@"class has implemented invocation");
            return nil;
        }
    }
    
    NSLog(@"forward selector: %@, class: %@", NSStringFromSelector(aSelector), NSStringFromClass([self class]));
    NCUnrecognizedSelectorSolveObject *obj = [NCUnrecognizedSelectorSolveObject new];
    return obj;
}

@end
