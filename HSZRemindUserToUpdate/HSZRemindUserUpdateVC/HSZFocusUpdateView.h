//
//  HSZFocusUpdateView.h
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2019/2/14.
//  Copyright © 2019 何松泽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HSZFocusUpdateViewDelegate <NSObject>

- (void)HSZFocusUpdateToAPPStore;

@end

@class HSZUpdateModel;
@interface HSZFocusUpdateView : UIView

@property (nonatomic, weak) id<HSZFocusUpdateViewDelegate> delegate;

- (void)updateViewByModel:(HSZUpdateModel *)model;

@end

NS_ASSUME_NONNULL_END
