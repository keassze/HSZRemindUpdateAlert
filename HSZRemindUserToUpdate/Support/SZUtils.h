//
//  SZUtils.h
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2018/3/6.
//  Copyright © 2018年 何松泽. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface SZUtils : NSObject

+ (instancetype)shareUtils;

/*
 ** 检查是否为最新的版本
 */
- (void)checkTheNewestVersion:(void(^)(BOOL isNewest))complete;

/*
 ** 手动杀死APP
 */
- (void)exitApplication;

/*
 ** 前往APP STORE更新
 */
- (void)goToAppStore;

@end
