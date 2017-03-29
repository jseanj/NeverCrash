#import "NSTimer+Crash.h"
#import "NSObject+Swizzling.h"

@interface NCWeakTimerTarget : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation NCWeakTimerTarget
- (void)timerFire:(NSTimer *)timer {
    if(self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer.userInfo];
#pragma clang diagnostic pop
    } else {
        [self.timer invalidate];
    }
}
@end

@implementation NSTimer (Crash)
+ (void)nc_enableCrashGuard {
    [NSTimer nc_classSwizzleSelector:@selector(nc_timerWithTimeInterval:target:selector:userInfo:repeats:) originalSelector:@selector(timerWithTimeInterval:target:selector:userInfo:repeats:)];
}
+ (NSTimer *)nc_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    NCWeakTimerTarget *timerTarget = [NCWeakTimerTarget new];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = [NSTimer nc_timerWithTimeInterval:ti
                                                target:timerTarget
                                              selector:@selector(timerFire:)
                                              userInfo:userInfo
                                               repeats:yesOrNo];
    
    return timerTarget.timer;
}
@end
