//
//  ViewController.m
//  Test
//
//  Created by Shadow on 14-5-14.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "ViewController.h"
#import "HYSwitch.h"
@interface ViewController ()


@property (nonatomic, strong) UIView *aView;

@property (nonatomic, strong) HYSwitch *switch1;
@property (nonatomic, strong) HYSwitch *switch2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.switch1 = [[HYSwitch alloc]initWithFrame:CGRectMake(20, 20, 50, 30)];
    [self.view addSubview:self.switch1];
    self.switch1.action = ^(BOOL isOn) {
        NSLog(@"switch1.on = %d", isOn);
    };
    
    self.switch2 = [[HYSwitch alloc]initWithFrame:CGRectMake(20, 60, 100, 50)];
    self.switch2.offColor = [UIColor colorWithRed:0.278 green:0.063 blue:0.204 alpha:1.0];
    self.switch2.onColor = [UIColor colorWithRed:1.000 green:0.482 blue:0.271 alpha:1.0];
    self.switch2.buttonColor = [UIColor whiteColor];
    
    [self.view addSubview:self.switch2];
    self.switch2.action = ^(BOOL isOn) {
        NSLog(@"switch2.on = %d", isOn);
    };
    
    [self.switch1 setSwitchOn:YES animated:YES doAction:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
