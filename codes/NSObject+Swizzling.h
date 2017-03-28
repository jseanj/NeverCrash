#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
+ (void)nc_swizzSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector;
@end
