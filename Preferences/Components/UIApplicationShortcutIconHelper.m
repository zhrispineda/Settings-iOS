//
//  UIApplicationShortcutIconHelper.m
//  Preferences
//

#import <UIKit/UIKit.h>

#pragma mark - Classes

@interface SBSApplicationShortcutSystemPrivateIcon : NSObject
- (instancetype)initWithSystemImageName:(NSString *)systemImageName;
@end

@interface UIApplicationShortcutIcon (Private)
- (instancetype)initWithSBSApplicationShortcutIcon:(SBSApplicationShortcutSystemPrivateIcon *)icon;
@end

#pragma mark - Helpers
/// An implementation of the internal SBSApplicationShortcutSystemPrivateIcon object from SpringBoardServices for use with UIApplicationShortcutIcon, allowing for private symbol usage in Home Screen quick actions.
///
/// - Warning: Do not use this method for public apps. Usage is not recommended as it is not publicly supported.
@interface UIApplicationShortcutIconHelper : NSObject
+ (UIApplicationShortcutIcon *)iconWithSystemImageName:(NSString *)systemImageName;
@end

@implementation UIApplicationShortcutIconHelper

+ (UIApplicationShortcutIcon *)iconWithSystemImageName:(NSString *)name {
    Class cls = NSClassFromString(@"SBSApplicationShortcutSystemPrivateIcon");
    if (!cls) return nil;

    id systemIcon = [[cls alloc] initWithSystemImageName:name];
    if (!systemIcon) return nil;

    SEL sel = NSSelectorFromString(@"initWithSBSApplicationShortcutIcon:");
    if ([UIApplicationShortcutIcon instancesRespondToSelector:sel]) {
        typedef id (*InitFunc)(id, SEL, id);
        InitFunc func = (InitFunc)[UIApplicationShortcutIcon instanceMethodForSelector:sel];
        id icon = func([UIApplicationShortcutIcon alloc], sel, systemIcon);
        return icon;
    }
    return nil;
}

@end
