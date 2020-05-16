//
//  HSZRemindUserUpdateVC.m
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2019/2/14.
//  Copyright © 2019 何松泽. All rights reserved.
//

#import "HSZRemindUserUpdateVC.h"
#import "HSZFocusUpdateView.h"
#import "HSZRemindUpdateView.h"
#import "HSZUpdateModel.h"
#import "SZUtils.h"

static const CGFloat leftRightMargin    = 50.f;
static const CGFloat widthRatiosHeigth  = 1.27f;

@interface HSZRemindUserUpdateVC ()<HSZFocusUpdateViewDelegate,HSZRemindUpdateDelegate>

@property (nonatomic, strong) HSZFocusUpdateView *focusUpdateView;
@property (nonatomic, strong) HSZRemindUpdateView *remindUpdateView;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation HSZRemindUserUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgView];
//    [self.view addSubview:self.focusUpdateView];
    [self.view addSubview:self.remindUpdateView];
    HSZUpdateModel *model = [HSZUpdateModel new];
    model.version = @"2.1.4";
    model.updateContent = @"1.界面全新升级，更好的视觉优化;\n2.内容更加完善，新增ui设计;\n3.修复若干bug\n...";
//    [self.focusUpdateView updateViewByModel:model];
    [self.remindUpdateView updateViewByModel:model];
}

#pragma mark - HSZFocusUpdateViewDelegate
- (void)HSZFocusUpdateToAPPStore
{
    [[SZUtils shareUtils] goToAppStore];
}

#pragma mark - HSZRemindUpdateDelegate
- (void)HSZRemindUpdateToAPPStore
{
    [[SZUtils shareUtils] goToAppStore];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)HSZRemindUpdateCancel
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Getter
- (HSZFocusUpdateView *)focusUpdateView
{
    if (!_focusUpdateView) {
        CGFloat width  = self.view.bounds.size.width - leftRightMargin*2;
        CGFloat height = width *widthRatiosHeigth;
        _focusUpdateView = [[HSZFocusUpdateView alloc] initWithFrame:CGRectMake(leftRightMargin, (self.view.bounds.size.height-height)/2.0, width, height)];
        _focusUpdateView.delegate = self;
    }
    return _focusUpdateView;
}

- (HSZRemindUpdateView *)remindUpdateView
{
    if (!_remindUpdateView) {
        CGFloat width  = self.view.bounds.size.width - leftRightMargin*2;
        CGFloat height = width *widthRatiosHeigth;
        _remindUpdateView = [[HSZRemindUpdateView alloc] initWithFrame:CGRectMake(leftRightMargin, (self.view.bounds.size.height - height)/2.0, width, height)];
        _remindUpdateView.delegate = self;
    }
    return _remindUpdateView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _bgView.backgroundColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.3f];
    }
    return _bgView;
}

@end
