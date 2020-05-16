//
//  ViewController.m
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2018/3/6.
//  Copyright © 2018年 何松泽. All rights reserved.
//

#import "ViewController.h"
#import "SZUtils.h"
#import "RemindUpdateView.h"
#import "AppDelegate.h"
#import "HSZRemindUserUpdateVC/HSZRemindUserUpdateVC.h"

@interface ViewController ()<RemindUpdateViewDelegate>

//可以自定义提醒View，跟着需求走
@property (nonatomic, strong)RemindUpdateView *remindUpdateView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor redColor];
    /*
     ** 如果是强制更新，则需要点击后UIAlertController不消失
     ** 然而没在API里找到这种方法，为此有两种思路可以解决
     ** 1、重新生成一个AlertController
     ** 2、最好的方法是自定义一个View盖在Window上
     */
    [self createAlertController];                       //方法一
//    self.remindUpdateView.hidden = NO;                   //方法二
}

- (void)createAlertController {
    [[SZUtils shareUtils] checkTheNewestVersion:^(BOOL isNewest) {
        if (!isNewest) {
            HSZRemindUserUpdateVC *vc = [[HSZRemindUserUpdateVC alloc] init];
            UINavigationController *baseNav = [[UINavigationController alloc] initWithRootViewController:vc];
            [baseNav setDefinesPresentationContext:YES];
            [baseNav setModalPresentationStyle:UIModalPresentationCustom];
            [self presentViewController:baseNav animated:NO completion:nil];
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更新提醒" message:@"您的APP不是最新的版本~有可能导致您无法使用~请前往APP STORE更新" preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:alertController animated:YES completion:^{
//                NSLog(@"当前不是最新版本");
//            }];
//            UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                //不允许该弹窗消失
//                [self createAlertController];
//                //前往APP STORE更新
//                [[SZUtils shareUtils] goToAppStore];
//            }];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                //暂不更新(还要判断是否必须更新才允许用户继续使用)
//                //这里默认不允许继续使用
//                [[SZUtils shareUtils] exitApplication];
//            }];
//            [alertController addAction:updateAction];
//            [alertController addAction:cancelAction];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RemindUpdateViewDelegate
- (void)RemindUpdateViewCancel {
    /*
     ** 如果需要强行关闭，调用exitApplication 方法
     */
//    [[SZUtils shareUtils] exitApplication];
    /*
     ** 如果需要关闭显示
     */
    self.remindUpdateView.hidden = YES;
}

- (void)RemindUpdateViewToAPPStore {
    [[SZUtils shareUtils] goToAppStore];
}

#pragma mark - Lazy Load
- (RemindUpdateView *)remindUpdateView {
    if (!_remindUpdateView) {
        _remindUpdateView = [[RemindUpdateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _remindUpdateView.delegate = (id)self;
        //有用navigationbar和tabbar的需要加在window上
//        [[UIApplication sharedApplication].keyWindow addSubview:_remindUpdateView];
        [self.view addSubview:_remindUpdateView];
        NSLog(@"初始化");
    }
    return _remindUpdateView;
}

@end
