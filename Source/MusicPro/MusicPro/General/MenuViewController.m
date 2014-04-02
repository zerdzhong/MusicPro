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
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *menuTitles;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImage *background = [UIImage imageNamed:@"background"];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
    
    NSDictionary *viewDictionary = @{ @"imageView" : self.backgroundImageView };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10.0f, 20.f, [UIScreen mainScreen].bounds.size.width - 20.0f, 44.0f)];
    
    self.searchBar.delegate = self;
    [self searchBarSelfSetting];
    [self.view addSubview:self.searchBar];
    
    /*
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(10.0f, 200.0f, 100.0f, 44.0f);
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
    */
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestured:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(lefSwiped:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UITableView *menuTableView = [[UITableView alloc]init];
    menuTableView.frame = CGRectMake(0, 100, 200, [UIScreen mainScreen].bounds.size.height);
    menuTableView.delegate = self;
    menuTableView.dataSource = self;
    menuTableView.backgroundColor = [UIColor clearColor];
    menuTableView.separatorColor = [UIColor clearColor];
    menuTableView.scrollEnabled = NO;
    self.menuTitles = @[@"home",@"lists",@"setting",@"about"];
    [self.view addSubview:menuTableView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)searchBarSelfSetting
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if ([self.searchBar respondsToSelector:@selector(barTintColor)]) {
        NSArray *searchBarSubView=[(UIView *)[self.searchBar.subviews objectAtIndex:0] subviews];
        
        for (UIView *subView in searchBarSubView) {
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subView removeFromSuperview];
            }else if([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]){
                ((UITextField *)subView).alpha = 0.4f;
                ((UITextField *)subView).borderStyle=UITextBorderStyleNone;
                ((UITextField *)subView).text=nil;
            }
        }
        if (version >= 7.1){
            //iOS7.1
            [[[[self.searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
            [self.searchBar setBackgroundColor:[UIColor clearColor]];
        }else{
            //iOS7.0
            [self.searchBar setBarTintColor:[UIColor clearColor]];
            [self.searchBar setBackgroundColor:[UIColor clearColor]];
        }
    }else{
        //iOS7.0以下
        [[self.searchBar.subviews objectAtIndex:0] removeFromSuperview];
        [self.searchBar setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)changeButtonPressed
{
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

- (void)closeButtonPressed
{
//    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    [self.sideMenuViewController closeMenuAnimated:YES completion:^(BOOL finished) {
        if (finished && [self.searchBar isFirstResponder]) {
            [self.searchBar resignFirstResponder];
        }
    }];
}


#pragma mark- 触摸事件响应
- (void)tapGestured:(id)sender
{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}

- (void)lefSwiped:(id)sender
{
    [self.sideMenuViewController closeMenuAnimated:YES completion:^(BOOL finished) {
        if (finished && [self.searchBar isFirstResponder]) {
            [self.searchBar resignFirstResponder];
        }
    }];
}

#pragma mark- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

#pragma mark- TWTSideMenuViewControllerDelegate
- (void)sideMenuViewControllerWillOpenMenu:(TWTSideMenuViewController *)sideMenuViewController
{

}
- (void)sideMenuViewControllerDidOpenMenu:(TWTSideMenuViewController *)sideMenuViewController
{

}
- (void)sideMenuViewControllerWillCloseMenu:(TWTSideMenuViewController *)sideMenuViewController
{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}
- (void)sideMenuViewControllerDidCloseMenu:(TWTSideMenuViewController *)sideMenuViewController
{

}

#pragma mark- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuTitles.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            //to-do
            break;
        case 1:
            //to-do
            break;
        case 2:
            //to-do
            break;
        default:
            break;
    }
}

@end
