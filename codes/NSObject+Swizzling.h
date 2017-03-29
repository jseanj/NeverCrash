#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
- (void)nc_instanceSwizzleSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector;
+ (void)nc_classSwizzleSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector;
@end
