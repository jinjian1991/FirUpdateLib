//
//  FirUpdateLib.m
//  FirUpdateLib
//
//  Created by Jin Jian on 2018/3/15.
//  Copyright © 2018年 com.themoviebook.tmb. All rights reserved.
//

#import "FirUpdateLib.h"
#import "FirHttpTool.h"
#import <UIKit/UIKit.h>

@interface FirUpdateLib () <UIAlertViewDelegate>
@property (nonatomic, copy) NSString *updateUrl;
@end

@implementation FirUpdateLib

+ (FirUpdateLib *)shared {
    static FirUpdateLib *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[FirUpdateLib alloc] init];
    });
    
    return _sharedInstance;
}

- (void)newVersion {
    [self newVersionWithToken:FIR_TOKEN appid:FIR_APPID updateURL:FIR_UPDATEURL];
}

- (void)newVersionWithToken:(NSString *)token appid:(NSString *)appid updateURL:(NSString *)url {
    if (!appid || [appid isEqualToString:@""]) {
        NSLog(@"appid can't be nil");
        return;
    } else if (!token || [token isEqualToString:@""]) {
        NSLog(@"token can't be nil");
        return;
    } else if (!url || [url isEqualToString:@""]) {
        NSLog(@"url can't be nil");
        return;
    }
    
    self.updateUrl = url;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", FIR_SERVER, appid];
    
    NSDictionary *params = @{@"api_token": !token ? @"" : token,
                             @"type"     : @"ios"};
    
    [[FirHttpTool alloc] getRequestWithUrl:urlString paramaters:params successBlock:^(NSDictionary *response) {
        NSString *onlineBuildStr = !response[@"version"] ? @"" : response[@"version"];
        NSString *onlineVersionStr =   !response[@"versionShort"] ? @"" : response[@"versionShort"];
        
        NSString * localVersionStr = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
        NSString * lovalBuildStr = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
        
        NSInteger onlineVersion = [onlineVersionStr integerValue];
        NSInteger onlineBuild = [onlineBuildStr integerValue];

        NSInteger localVersion = [localVersionStr integerValue];
        NSInteger localBuild = [lovalBuildStr integerValue];
        
        NSLog(@"Fir_response = %@", response);
        NSLog(@"Fir_onlineVersionStr = %@", onlineVersionStr);
        NSLog(@"==================================================================================================");
        NSLog(@"Fir_onlineBuild = %ld", (long)onlineBuild);
        NSLog(@"Fir_localBuild = %ld", (long)localBuild);
        NSLog(@"==================================================================================================");


        if (localBuild < onlineBuild) {  // || localBuild   < onlineBuild
            [self updateJudgedFunction];
        }
    } FailBlock:^(NSError *error) {
        NSLog(@"FirUpdateLib error: %@", error);
    }];
}

- (void)updateJudgedFunction {
//    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
//    NSString *message = !dict[@"Fir update text"] ? @"监测到新版本，请更新!" : dict[@"Fir update text"];
    
    NSString *message = ALERT_MESSAGE;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
}

// alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self openScheme:self.updateUrl];
//    [self exitApplication];
}

// 打开 fir.im 更新链接
- (void)openScheme:(NSString *)scheme {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [application openURL:URL options:@{}
           completionHandler:^(BOOL success) {
               NSLog(@"Open %@: %d",scheme,success);
               [self exitApplication];
           }];
    } else {
        BOOL success = [application openURL:URL];
        [self exitApplication];
        NSLog(@"Open %@: %d",scheme,success);
    }
}

// 强制退出 App
- (void)exitApplication {
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    UIWindow *window = app.window;
//
//    [UIView animateWithDuration:1.0f animations:^{
//        window.alpha = 0;
//        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//    } completion:^(BOOL finished) {
//        exit(0);
//    }];

    exit(0);
}

@end
