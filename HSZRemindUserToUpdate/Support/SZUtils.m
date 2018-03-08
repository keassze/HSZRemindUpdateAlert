//
//  SZUtils.m
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2018/3/6.
//  Copyright © 2018年 何松泽. All rights reserved.
//

#import "SZUtils.h"
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>

#define APPID   @"998252357" //公司APPID

@implementation SZUtils

+ (instancetype)shareUtils {
    static SZUtils *utils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utils = [SZUtils new];
    });
    return utils;
}

#pragma mark - 检查当前APP是否为最新版本（与APP Store的版本对比）
- (void)checkTheNewestVersion:(void(^)(BOOL isNewest))complete {
    /*
     ** 不建议使用这种方法；最好是后台抓取信息再由我们请求接口；
     */
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APPID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject --- %@", responseObject);
        NSArray *tempArr = responseObject[@"result"];
        NSString *appStoreVersion = tempArr.firstObject[@"version"];
        if (complete) {
            complete([appStoreVersion isEqualToString:currentVersion]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 手动杀死当前APP
- (void)exitApplication {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    //增加收起动画，让杀死APP不显得过于突兀
    [UIView animateWithDuration:0.5f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

#pragma mark - 前往APP STORE更新
- (void)goToAppStore {
    NSURL *appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APPID]];
//    [[UIApplication sharedApplication] openURL:appUrl];
    /*
     ios11新版的App Store 用上面的链接跳有问题
     ios10以下用下面方法也找不到方法
     因此要自行写一个兼容方法
     */
//    [[UIApplication sharedApplication] openURL:appUrl];
//    [[UIApplication sharedApplication] openURL:appUrl options:nil completionHandler:^(BOOL success) {
//
//    }];
    [[SZUtils shareUtils] openScheme:appUrl options:@{} complete:^(BOOL success) {
        NSLog(@"%d",success);
    }];
}

#pragma mark - 兼容ios10以下无openURL新方法，顺便回调了
- (void)openScheme:(NSURL *)schemeURL options:(NSDictionary *)option complete:(void(^)(BOOL success))complete
{
    UIApplication *application = [UIApplication sharedApplication];
    if (@available(iOS 10.0, *)) {
        [application openURL:schemeURL options:option completionHandler:^(BOOL success) {
            if (complete) {
                complete(success);
            }
        }];
    } else {
        // Fallback on earlier versions
        [application openURL:schemeURL];
        BOOL success = [application canOpenURL:schemeURL];
        if (complete) {
            complete(success);
        }
    }
    
}

@end




