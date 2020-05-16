//
//  HSZFocusUpdateView.m
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2019/2/14.
//  Copyright © 2019 何松泽. All rights reserved.
//

#import "HSZFocusUpdateView.h"
#import "HSZUpdateModel.h"

@interface HSZFocusUpdateView()

@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *updateBtn;

@end

@implementation HSZFocusUpdateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self addSubview:self.bgView];
    [self addSubview:self.imageIcon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.updateBtn];
}

- (void)updateViewByModel:(HSZUpdateModel *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"升级到%@版本",model.version];
    
    NSMutableAttributedString *contentAttributedString = [[NSMutableAttributedString alloc] initWithString:model.updateContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8.f];
    [contentAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.updateContent.length)];
    self.contentLabel.attributedText = contentAttributedString;
}

#pragma mark - Click Event
- (void)clickUpdate
{
    if (_delegate && [_delegate respondsToSelector:@selector(HSZFocusUpdateToAPPStore)]) {
        [_delegate HSZFocusUpdateToAPPStore];
    }
}

#pragma mark - Getter
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, self.bounds.size.width, self.bounds.size.height - 65)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UIImageView *)imageIcon
{
    if (!_imageIcon) {
        _imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, self.bounds.size.width - 50*2, (self.bounds.size.width - 50*2)*0.78)];
        [_imageIcon setImage:[UIImage imageNamed:@"focus_update_img"]];
    }
    return _imageIcon;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageIcon.frame) + 5, self.bounds.size.width, 20)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.titleLabel.frame) + 10, self.bounds.size.width - 50*2, 80)];
        _contentLabel.font = [UIFont systemFontOfSize:11];
        _contentLabel.numberOfLines = 4;
        _contentLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

- (UIButton *)updateBtn
{
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.contentLabel.frame) + 25, self.bounds.size.width - 20*2, 40)];
        [_updateBtn setTitle:@"现在升级" forState:UIControlStateNormal];
        [_updateBtn addTarget:self action:@selector(clickUpdate) forControlEvents:UIControlEventTouchUpInside];
        // 渐变色
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,self.bounds.size.width - 20*2,40);
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:75/255.0 green:162/255.0 blue:241/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:77/255.0 green:190/255.0 blue:242/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0.0),@(1.0)];
        
        [_updateBtn.layer addSublayer:gl];
        _updateBtn.layer.cornerRadius = 2;
    }
    return _updateBtn;
}

@end
