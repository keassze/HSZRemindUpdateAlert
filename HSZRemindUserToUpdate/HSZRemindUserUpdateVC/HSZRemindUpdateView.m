//
//  HSZRemindUpdateView.m
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2019/2/14.
//  Copyright © 2019 何松泽. All rights reserved.
//

#import "HSZRemindUpdateView.h"
#import "HSZUpdateModel.h"

@interface HSZRemindUpdateView()

@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *updateBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *grayLine;
@property (nonatomic, strong) UIView *yellowLine;

@end

@implementation HSZRemindUpdateView

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
    [self addSubview:self.versionLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.updateBtn];
    [self addSubview:self.grayLine];
    [self addSubview:self.yellowLine];
}

- (void)updateViewByModel:(HSZUpdateModel *)model
{
    NSString *versionStr = [NSString stringWithFormat:@"V%@",model.version];
    self.versionLabel.text = versionStr;
    CGSize versionLabelSize = [versionStr sizeWithAttributes:@{
                                                               NSFontAttributeName : [UIFont boldSystemFontOfSize:10]
                                                               }];
    [self.versionLabel setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 2, CGRectGetMaxY(self.titleLabel.frame) - versionLabelSize.height - 2, versionLabelSize.width, versionLabelSize.height)];
    
    NSMutableAttributedString *contentAttributedString = [[NSMutableAttributedString alloc] initWithString:model.updateContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8.f];
    [contentAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.updateContent.length)];
    self.contentLabel.attributedText = contentAttributedString;
}

#pragma mark - Click Event
- (void)clickUpdate
{
    if (_delegate && [_delegate respondsToSelector:@selector(HSZRemindUpdateToAPPStore)]) {
        [_delegate HSZRemindUpdateToAPPStore];
    }
}

- (void)clickCancel
{
    if (_delegate && [_delegate respondsToSelector:@selector(HSZRemindUpdateCancel)]) {
        [_delegate HSZRemindUpdateCancel];
    }
}

#pragma mark - Getter
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UIImageView *)imageIcon
{
    if (!_imageIcon) {
        CGFloat margin = 50;
        CGFloat width = self.bounds.size.width - margin*2;
        _imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 25, width, width*0.7)];
        [_imageIcon setImage:[UIImage imageNamed:@"remind_update_img"]];
    }
    return _imageIcon;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        NSString *title = @"最新版本";
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.text = title;
        _titleLabel.textColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        CGSize textSize = [title sizeWithAttributes:@{
                                                      NSFontAttributeName : [UIFont boldSystemFontOfSize:15]
                                                      }];
        [_titleLabel setFrame:CGRectMake(self.bounds.size.width/2 - textSize.width/2 - 15, CGRectGetMaxY(self.imageIcon.frame) + 15, textSize.width, textSize.height)];
    }
    return _titleLabel;
}

- (UILabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 2, CGRectGetMaxY(self.titleLabel.frame) - 5, 0, 0)];
        _versionLabel.backgroundColor = [UIColor colorWithRed:35/255.0 green:153/255.0 blue:235/255.0 alpha:1.0];
        _versionLabel.textColor = [UIColor whiteColor];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.font = [UIFont systemFontOfSize:10];
        _versionLabel.layer.cornerRadius = 3.f;
        _versionLabel.layer.masksToBounds = YES;
    }
    return _versionLabel;
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

- (UIView *)grayLine
{
    if (!_grayLine) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30,CGRectGetMaxY(self.contentLabel.frame) + 15,self.bounds.size.width - 30*2,1)];
        view.backgroundColor = [UIColor colorWithRed:244/255.0 green:241/255.0 blue:244/255.0 alpha:1.0];
        _grayLine = view;
    }
    return _grayLine;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.grayLine.frame) + 20, (self.bounds.size.width - 10*3)/2, 40)];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:126/255.0 green:126/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)updateBtn
{
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc] initWithFrame:CGRectMake(10 + CGRectGetMaxX(self.cancelBtn.frame), CGRectGetMaxY(self.grayLine.frame) + 20, (self.bounds.size.width - 10*3)/2, 40)];
        [_updateBtn setTitleColor:[UIColor colorWithRed:35/255.0 green:153/255.0 blue:235/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        [_updateBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_updateBtn addTarget:self action:@selector(clickUpdate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateBtn;
}

- (UIView *)yellowLine
{
    if (!_yellowLine) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cancelBtn.frame) + 5, CGRectGetMaxY(self.grayLine.frame) + 20 + 10, 1, 20)];
        view.backgroundColor = [UIColor colorWithRed:237/255.0 green:192/255.0 blue:46/255.0 alpha:1.0];
        _yellowLine = view;
    }
    return _yellowLine;
}

@end
