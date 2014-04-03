//
//  MainViewController.m
//  MusicPro
//
//  Created by zerd on 14-3-21.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWTSideMenuViewController.h"
#import "MusicPlayerViewController.h"
#import "MainViewController.h"
#import "ViewUtils.h"
#import "listDetailModel.h"
#import "UIImageView+LBBlurredImage.h"

@interface MainViewController ()

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGesture;
@property (nonatomic, strong) NSMutableArray *arrayForTable;
@property (nonatomic, strong) UITableView *listTableView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MusicPro";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonSystemItemEdit target:self action:@selector(editList:)];
    
    self.rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwiped:)];
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipeGesture];
    
    UIImage *background = [UIImage imageNamed:@"background"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:background];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundImageView];
    
    UIImageView *blurredImageView = [[UIImageView alloc] init];
    blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    blurredImageView.alpha = 0;
    [blurredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    [self.view addSubview:blurredImageView];
    
    self.listTableView = [[UITableView alloc]init];
    self.listTableView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight);
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor clearColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.listTableView setTableFooterView:view];
    [self.view addSubview:self.listTableView];
    
    self.arrayForTable = [[NSMutableArray alloc]init];
    listDetailModel *list1 = [[listDetailModel alloc]initWithListName:@"本地音乐"
                                                             andSuperList:nil
                                                             andArray:@[@"Love",@"Knockin' in heaven's door",@"3"]];
    listDetailModel *list2 = [[listDetailModel alloc]initWithListName:@"FAVURITE"
                                                             andSuperList:nil
                                                             andArray:@[@"a",@"b",@"c"]];

    listDetailModel *list3 = [[listDetailModel alloc]initWithListName:@"ROCK"
                                                             andSuperList:nil
                                                             andArray:@[@"Beat It",@"If I Were a boy",@"C",@"D"]];
    [self.arrayForTable addObject:list1];
    [self.arrayForTable addObject:list2];
    [self.arrayForTable addObject:list3];
    
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
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

- (void)editList:(id)sender
{
    if (self.listTableView.editing) {
        [self.listTableView setEditing:NO animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
    }else{
        [self.listTableView setEditing:YES animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    }
    
}

#pragma mark- UITableViewDelegate
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.arrayForTable count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
	listDetailModel *list = (listDetailModel *)[self.arrayForTable objectAtIndex:indexPath.row];
	cell.textLabel.text=list.name;
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    if (list.level  == 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",list.listNameArray.count];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (list.superList) {
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
	[cell setIndentationLevel:list.level];
	
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return NO;
    }else{
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除cell
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //删除好友
        listDetailModel *deleteModel = [self.arrayForTable objectAtIndex:indexPath.row];
        if (deleteModel.level == 0) {
            if (deleteModel.isListShow) {
                [self miniMizeThisRows:deleteModel];
            }
            [self.arrayForTable removeObjectAtIndex:indexPath.row];
            [self.listTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath ] withRowAnimation:UITableViewRowAnimationNone];
//            [self.listTableView reloadData];
        }else{
            [self.arrayForTable removeObjectAtIndex:indexPath.row];
            for (NSString *deleteName in deleteModel.superList.listNameArray) {
                if ([deleteName isEqualToString:deleteModel.name]) {
                    [deleteModel.superList.listNameArray removeObject:deleteName];
                    break;
                }
            }
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            [self.listTableView reloadData];
        }
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	listDetailModel *detail=[self.arrayForTable objectAtIndex:indexPath.row];
	if(detail.listNameArray != nil) {
		
		bool isAlreadyInserted = detail.isListShow;
		
		if(isAlreadyInserted && detail.level == 0) {
            detail.isListShow = NO;
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			[self miniMizeThisRows:detail];
		} else if(detail.level == 0){
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
			NSUInteger count = indexPath.row + 1;
			NSMutableArray *arCells=[NSMutableArray array];
			for(NSString *songName in detail.listNameArray ) {
				[arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                listDetailModel *insertList = [[listDetailModel alloc]initWithListName:songName
                                                                             andSuperList:detail
                                                                             andArray:nil];
				[self.arrayForTable insertObject:insertList atIndex:count++];
			}
			[tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationNone];
            detail.isListShow = YES;
		}
	}
}

-(void)miniMizeThisRows:(listDetailModel *)list{
	
//	for(listDetailModel *list in self.arrayForTable) {
//		NSUInteger indexToRemove=[self.arrayForTable indexOfObjectIdenticalTo:list];
//        if ([array containsObject:list.name]) {
//            [self.arrayForTable removeObjectIdenticalTo:list];
    NSUInteger indexToRemove=[self.arrayForTable indexOfObjectIdenticalTo:list] + 1;
    for (int i = 0; i < list.listNameArray.count ; i++) {
        [self.arrayForTable removeObjectAtIndex:indexToRemove];
        [self.listTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]]withRowAnimation:UITableViewRowAnimationNone];
        
    }
    
}


@end
