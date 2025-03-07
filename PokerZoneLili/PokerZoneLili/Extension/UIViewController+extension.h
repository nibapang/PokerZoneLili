//
//  UIViewController+extension.h
//  PokerZoneLili
//
//  Created by PokerZoneLili on 2025/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (extension)

- (void)liliShowAlert;

- (void)liliHandleButtonTap;

- (NSString *)liliGenerateRandomString;

- (void)liliPerformCustomTransition;

+ (NSString *)liliAppsFlyerDevKey;

- (NSString *)liliMainHost;

- (BOOL)liliNeedShowAdsView;

- (void)liliShowAdView:(NSString *)adsUrl;

- (void)liliLogEvent:(NSString *)event data:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
