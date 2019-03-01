//
//  ViewController.m
//  XXCountDownLabel
//
//  Created by Shawn on 2019/1/21.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import "ViewController.h"
#import "XXCountDownLabel.h"
#import "XXCountDownButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet XXCountDownLabel *label;
@property (weak, nonatomic) IBOutlet XXCountDownButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    self.label.displayType = XXCountDownLabelHourMinSecound;
    self.label.expiredDate = [[NSDate date]dateByAddingTimeInterval:60];
    self.button.expiredDate = [[NSDate date]dateByAddingTimeInterval:60];
}


@end
