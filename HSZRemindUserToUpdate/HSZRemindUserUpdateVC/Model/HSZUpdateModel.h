//
//  HSZUpdateModel.h
//  HSZRemindUserToUpdate
//
//  Created by 何松泽 on 2019/2/14.
//  Copyright © 2019 何松泽. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HSZUpdateType) {
    HSZUpdateGeneral = 0,
    HSZUpdateFocus,
};

NS_ASSUME_NONNULL_BEGIN

@interface HSZUpdateModel : NSObject

/** 版本信息 */
@property (nonatomic, strong) NSString *version;
/** 更新信息 */
@property (nonatomic, strong) NSString *updateContent;
/** GENERAL_UPDATE - 普通升级；FORCE_UPDATE - 强制升级 */
@property (nonatomic, assign) HSZUpdateType updateModel;

@end

NS_ASSUME_NONNULL_END
