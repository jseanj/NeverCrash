#import <Foundation/Foundation.h>

@interface NSObject (SelectorCrash)
+ (void)nc_enableSelectorGuard;
+ (void)nc_disEnableSelectorGuard;
@end
