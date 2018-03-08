//
//  RemindUpdateView.h
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2018/3/7.
//  Copyright © 2018年 何松泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemindUpdateViewDelegate<NSObject>

- (void)RemindUpdateViewToAPPStore;
- (void)RemindUpdateViewCancel;

@end

@interface RemindUpdateView : UIView

@property (weak, nonatomic) id<RemindUpdateViewDelegate> delegate;

@end
