//
//  SideMuneViewController.h
//  MusicPro
//
//  Created by zerd on 14-3-25.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import "MenuViewController.h"
#import "MainViewController.h"
#import "TWTSideMenuViewController.h"

@interface MenuViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
    
    NSDictionary *viewDictionary = @{ @"imageView" : self.backgroundImageView };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    
    
     UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(0.0f, 0.0f, 100.0f, 44.0f);
    [closeButton setBackgroundColor:[UIColor clearColor]];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    changeButton.frame = CGRectMake(10.0f, 100.0f, 100.0f, 44.0f);
    [changeButton setTitle:@"Swap" forState:UIControlStateNormal];
    [changeButton setBackgroundColor:[UIColor clearColor]];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(changeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
}

- (void)changeButtonPressed
{
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

- (void)closeButtonPressed
{
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
