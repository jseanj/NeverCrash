#import "NSString+Crash.h"
#import "NSObject+Swizzling.h"

@implementation NSString (Crash)
+ (void)nc_enableCrashGuard {
    [NSString nc_classSwizzleSelector:@selector(nc_stringWithUTF8String:) originalSelector:@selector(stringWithUTF8String:)];
    [NSString nc_classSwizzleSelector:@selector(nc_stringWithCString:encoding:) originalSelector:@selector(stringWithCString:encoding:)];
    
    [[NSString alloc] nc_instanceSwizzleSelector:@selector(nc_initWithCString:encoding:) originalSelector:@selector(initWithCString:encoding:)];

    NSString *string = [[NSString alloc] init];
    [string nc_instanceSwizzleSelector:@selector(nc_stringByAppendingString:) originalSelector:@selector(stringByAppendingString:)];
    [string nc_instanceSwizzleSelector:@selector(nc_substringFromIndex:) originalSelector:@selector(substringFromIndex:)];
    [string nc_instanceSwizzleSelector:@selector(nc_substringToIndex:) originalSelector:@selector(substringToIndex:)];
    [string nc_instanceSwizzleSelector:@selector(nc_substringWithRange:) originalSelector:@selector(substringWithRange:)];
}
+ (instancetype)nc_stringWithUTF8String:(const char *)nullTerminatedCString
{
    if (NULL != nullTerminatedCString) {
        return [self nc_stringWithUTF8String:nullTerminatedCString];
    }
    NSLog(@"NSString stringWithUTF8String args nil");
    return nil;
}
+ (instancetype)nc_stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc {
    if (NULL != cString){
        return [self nc_stringWithCString:cString encoding:enc];
    }
    NSLog(@"NSString stringWithCString:encoding: args nil");
    return nil;
}
- (instancetype)nc_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding {
    if (NULL != nullTerminatedCString){
        return [self nc_initWithCString:nullTerminatedCString encoding:encoding];
    }
    NSLog(@"NSString initWithCString:encoding: args nil");
    return nil;
}
- (NSString *)nc_stringByAppendingString:(NSString *)aString {
    if (aString){
        return [self nc_stringByAppendingString:aString];
    }
    NSLog(@"NSString stringByAppendingString args nil");
    return self;
}
- (NSString *)nc_substringFromIndex:(NSUInteger)from {
    if (from <= self.length) {
        return [self nc_substringFromIndex:from];
    }
    NSLog(@"NSString substringFromIndex args nil");
    return nil;
}
- (NSString *)nc_substringToIndex:(NSUInteger)to {
    if (to <= self.length) {
        return [self nc_substringToIndex:to];
    }
    NSLog(@"NSString substringToIndex args nil");
    return self;
}
- (NSString *)nc_substringWithRange:(NSRange)range {
    if (range.location + range.length <= self.length) {
        return [self nc_substringWithRange:range];
    }else if (range.location < self.length){
        return [self nc_substringWithRange:NSMakeRange(range.location, self.length-range.location)];
    }
    NSLog(@"NSString substringWithRange args nil");
    return nil;
}
@end
