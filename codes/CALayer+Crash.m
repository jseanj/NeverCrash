#import "CALayer+Crash.h"
#import "NSObject+Swizzling.h"

@implementation CALayer (Crash)
+ (void)nc_enableCrashGuard {
    CALayer *layer =[[CALayer alloc] init];
    [layer nc_instanceSwizzleSelector:@selector(nc_display) originalSelector:@selector(display)];
    [layer nc_instanceSwizzleSelector:@selector(nc_layoutSublayers) originalSelector:@selector(layoutSublayers)];
}
- (void)nc_display {
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        [self nc_display];
    }else{
        NSLog(@"%s display not on main thread %@ ",__FUNCTION__, self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self nc_display];
        });
    }
}
- (void)nc_layoutSublayers {
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        [self nc_layoutSublayers];
    }else{
        NSLog(@"%s layoutSublayers not on main thread %@ ",__FUNCTION__, self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self nc_layoutSublayers];
        });
    }
}
@end
