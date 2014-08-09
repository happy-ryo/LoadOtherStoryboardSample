//
//  ViewController.m
//  LoadOtherStoryboard
//
//  Created by happy_ryo on 2014/08/09.
//  Copyright (c) 2014年 happy_ryo. All rights reserved.
//

#import "ViewController.h"
#import "OtherViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)openOtherStoryboard {
    [OtherViewController show];
}

@end
