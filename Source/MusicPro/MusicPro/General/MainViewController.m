//
//  MainViewController.m
//  MusicPro
//
//  Created by zerd on 14-3-21.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import "MainViewController.h"
#import "TWTSideMenuViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGesture;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MusicPro";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
    
    self.rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwiped:)];
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipeGesture];
}

- (void)rightSwiped:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.sideMenuViewController openMenuAnimated:YES completion:nil];
    }
}

- (void)openButtonPressed
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

@end
