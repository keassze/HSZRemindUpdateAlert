//
//  RemindUpdateView.m
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2018/3/7.
//  Copyright © 2018年 何松泽. All rights reserved.
//

#import "RemindUpdateView.h"
#import "SZUtils.h"

@interface RemindUpdateView()

@property (nonatomic, strong)UIButton *goToStoreBtn;
@property (nonatomic, strong)UIButton *withoutUpdateBtn;

@end

static const float kHorizontalDistance  = 40.f;
static const float kVerticalDistance    = 120.f;
static const float kDefaultFont         = 16.f;
static const float kButtonHeight        = 25.f;

typedef enum : NSUInteger {
    RemindUpdateViewGotoStoreBtn = 1,
    RemindUpdateViewWithOutUpdateBtn,
} RemindUpdateViewBtn;

@implementation RemindUpdateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:0.8f];
        
        CGFloat bottomRectWidth  = SCREEN_WIDTH - kHorizontalDistance*2;
        CGFloat bottomRectHeight = SCREEN_HEIGHT - kVerticalDistance*2;
        CGRect bottomRect = CGRectZero;
        bottomRect.origin.x = kHorizontalDistance;
        bottomRect.origin.y = kVerticalDistance;
        bottomRect.size.width  = bottomRectWidth;
        bottomRect.size.height = bottomRectHeight;
        
        UIView *bottomView = [[UIView alloc] initWithFrame:bottomRect];
        [bottomView setBackgroundColor:[UIColor whiteColor]];
        [bottomView.layer setCornerRadius:6.f];
        [bottomView.layer setMasksToBounds:YES];
        [self addSubview:bottomView];
        
        bottomRect.size.height = kButtonHeight;
        self.goToStoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goToStoreBtn setFrame:bottomRect];
        [self.goToStoreBtn setCenter:CGPointMake(bottomRect.size.width/2, (bottomRectWidth - kButtonHeight)/2)];
        [self.goToStoreBtn setTitle:[NSString stringWithFormat:@"前往更新"] forState:UIControlStateNormal];
        [self.goToStoreBtn setTitleColor:[UIColor colorWithRed:63.0f/255.0f green:162.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [self.goToStoreBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:kDefaultFont]];
        [self.goToStoreBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.goToStoreBtn setTag: RemindUpdateViewGotoStoreBtn];
        [bottomView addSubview:_goToStoreBtn];
        
        self.withoutUpdateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.withoutUpdateBtn.backgroundColor = [UIColor redColor];
        [self.withoutUpdateBtn setFrame:bottomRect];
        [self.withoutUpdateBtn setCenter:CGPointMake(bottomRect.size.width/2, (bottomRectHeight + kButtonHeight)/2)];
        [self.withoutUpdateBtn setTitle:[NSString stringWithFormat:@"暂不更新"] forState:UIControlStateNormal];
        [self.withoutUpdateBtn setTitleColor:[UIColor colorWithRed:63.0f/255.0f green:162.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [self.withoutUpdateBtn.titleLabel setFont:[UIFont systemFontOfSize:kDefaultFont]];
        [self.withoutUpdateBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.withoutUpdateBtn setTag:RemindUpdateViewWithOutUpdateBtn];
        [bottomView addSubview:_withoutUpdateBtn];
    }
    return self;
}

- (void)clickEvent:(id)sender {
    UIButton *tempBtn = sender;
    switch (tempBtn.tag) {
        case RemindUpdateViewGotoStoreBtn:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(RemindUpdateViewToAPPStore)]) {
                [_delegate RemindUpdateViewToAPPStore];
            }
        }
            break;
        case RemindUpdateViewWithOutUpdateBtn:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(RemindUpdateViewCancel)]) {
                [_delegate RemindUpdateViewCancel];
            }
        }
            break;
    }
}

@end
