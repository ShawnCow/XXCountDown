//
//  XXCountDownLabel.h
//  XXCountDownLabel
//
//  Created by Shawn on 2019/1/21.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXCountDown.h"

typedef NS_ENUM(NSInteger,XXCountDownLabelDateType)
{
    XXCountDownLabelSecound,
    XXCountDownLabelHourMinSecound,
};

@class XXCountDownLabel;

typedef void (^XXCountDownLabelCompletion)(XXCountDownLabel *countDownLabel);

@interface XXCountDownLabel : UILabel<XXCountDown>

@property (nonatomic)XXCountDownLabelDateType displayType;

@property (nonatomic, strong) NSDate *expiredDate;

@property (nonatomic,copy) XXCountDownLabelCompletion fireBlock;

@property (nonatomic,copy) XXCountDownLabelCompletion countDownloadCompletion;

@end
