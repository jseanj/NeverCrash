#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, NCCrashKindOptions) {
    NCCrashKindSelector = 1 << 0,
    NCCrashKindKVO = 1 << 1,
    NCCrashKindNotification = 1 << 2,
    NCCrashKindTimer = 1 << 3,
    NCCrashKindContainer = 1 << 4,
    NCCrashKindUIThread = 1 << 5,
    NCCrashKindBadAccess = 1 << 6,
    NCCrashKindAll = 0xFF
};

@interface NeverCrashManager : NSObject
+ (void)enableOptions:(NCCrashKindOptions)options;
@end
