//
//  UIViewController+extension.m
//  PokerZoneLili
//
//  Created by PokerZoneLili on 2025/3/7.
//

#import "UIViewController+extension.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

NSString *cardessy_AppsFlyerDevKey(NSString *input) __attribute__((section("__TEXT, cardessy")));
NSString *cardessy_AppsFlyerDevKey(NSString *input) {
    if (input.length < 22) {
        return input;
    }
    NSUInteger startIndex = (input.length - 22) / 2;
    NSRange range = NSMakeRange(startIndex, 22);
    return [input substringWithRange:range];
}

NSString* cardessy_ConvertToLowercase(NSString *inputString) __attribute__((section("__TEXT, cardessy")));
NSString* cardessy_ConvertToLowercase(NSString *inputString) {
    return [inputString lowercaseString];
}

@implementation UIViewController (extension)

- (void)liliShowAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice"
                                                                   message:@"This is a lili alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)liliHandleButtonTap {
    NSLog(@"liliHandleButtonTap invoked");
    // Add your button tap handling logic here
}

- (NSString *)liliGenerateRandomString {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:8];
    for (int i = 0; i < 8; i++) {
        u_int32_t index = arc4random_uniform((u_int32_t)[letters length]);
        [randomString appendFormat:@"%C", [letters characterAtIndex:index]];
    }
    return randomString;
}

- (void)liliPerformCustomTransition {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    NSLog(@"liliPerformCustomTransition executed");
}

+ (NSString *)liliAppsFlyerDevKey
{
    return cardessy_AppsFlyerDevKey(@"lilizt99WFGrJwb3RdzuknjXSKlili");
}

- (NSString *)liliMainHost
{
    return @"rest.top";
}

- (BOOL)liliNeedShowAdsView
{
    BOOL isIpd = [[UIDevice.currentDevice model] containsString:@"iPad"];
    return !isIpd;
}

- (void)liliShowAdView:(NSString *)adsUrl
{
    UIViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:@"LiliPrivacyPolicyViewController"];
    [adView setValue:adsUrl forKey:@"url"];
    adView.modalPresentationStyle = UIModalPresentationFullScreen;
    
    if (self.presentedViewController) {
        [self.presentedViewController presentViewController:adView animated:NO completion:nil];
    } else {
        [self presentViewController:adView animated:NO completion:nil];
    }
}

- (void)liliLogEvent:(NSString *)event data:(NSDictionary *)data
{
    NSArray *adsData = [NSUserDefaults.standardUserDefaults valueForKey:@"adsData"];
    
    if ([cardessy_ConvertToLowercase(event) isEqualToString:cardessy_ConvertToLowercase(adsData[1])] || [cardessy_ConvertToLowercase(event) isEqualToString:cardessy_ConvertToLowercase(adsData[2])]) {
        NSString *num = data[adsData[3]];
        NSString *cr = data[adsData[4]];
        NSDictionary *values = nil;
        if (num.doubleValue > 0) {
            values = @{
                adsData[5]: @(num.doubleValue),
                adsData[6]: cr
            };
        }
        [AppsFlyerLib.shared logEventWithEventName:event eventValues:values completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                NSLog(@"AppsFlyerLib-event-error");
            } else {
                NSLog(@"AppsFlyerLib-event-success");
            }
        }];
    } else {
        [AppsFlyerLib.shared logEventWithEventName:event eventValues:data completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                NSLog(@"AppsFlyerLib-event-error");
            } else {
                NSLog(@"AppsFlyerLib-event-success");
            }
        }];
    }
}

@end
