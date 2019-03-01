//
//  XXCountDownButton.h
//  XXCountDownLabel
//
//  Created by Shawn on 2019/2/13.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXCountDown.h"

@class XXCountDownButton;

typedef void (^XXCountDownButtonCompletion)(XXCountDownButton *button);

@interface XXCountDownButton : UIButton<XXCountDown>

@property (nonatomic, strong) NSDate *expiredDate;

@property (nonatomic,copy) XXCountDownButtonCompletion fireBlock;

@property (nonatomic, copy) XXCountDownButtonCompletion countDownCompletion;

@end
