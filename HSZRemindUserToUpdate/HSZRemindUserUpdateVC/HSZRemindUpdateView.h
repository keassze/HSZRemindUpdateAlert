//
//  HSZRemindUpdateView.h
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2019/2/14.
//  Copyright © 2019 何松泽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HSZRemindUpdateDelegate <NSObject>

- (void)HSZRemindUpdateCancel;
- (void)HSZRemindUpdateToAPPStore;

@end

@class HSZUpdateModel;
@interface HSZRemindUpdateView : UIView

@property (nonatomic, weak) id<HSZRemindUpdateDelegate> delegate;

- (void)updateViewByModel:(HSZUpdateModel *)model;

@end

NS_ASSUME_NONNULL_END
