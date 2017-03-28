#import <Foundation/Foundation.h>

@interface NeverCrashManager : NSObject
+ (instancetype)shared;
- (void)enable;
- (void)disEnable;
@end
