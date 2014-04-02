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
    
    self.rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwiped:)];
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipeGesture];
    
    self.listTableView = [[UITableView alloc]init];
    self.listTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
//    self.listTableView.editing = YES;
    [self.view addSubview:self.listTableView];
    
    self.arrayForTable = [[NSMutableArray alloc]init];
    listDetailModel *list1 = [[listDetailModel alloc]initWithListName:@"ALL"
                                                             andLevel:@"0"
                                                             andArray:@[@"1",@"2",@"3"]];
    listDetailModel *list2 = [[listDetailModel alloc]initWithListName:@"FAVURITE"
                                                             andLevel:@"0"
                                                             andArray:@[@"a",@"b",@"c"]];

    listDetailModel *list3 = [[listDetailModel alloc]initWithListName:@"ROCK"
                                                             andLevel:@"0"
                                                             andArray:@[@"A",@"B",@"C"]];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	listDetailModel *list = (listDetailModel *)[self.arrayForTable objectAtIndex:indexPath.row];
	cell.textLabel.text=list.name;
	[cell setIndentationLevel:[list.level integerValue]];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	listDetailModel *detail=[self.arrayForTable objectAtIndex:indexPath.row];
	if(detail.listNameArray != nil) {
		
		bool isAlreadyInserted = detail.isListShow;
		
		if(isAlreadyInserted) {
            detail.isListShow = NO;
			[self miniMizeThisRows:detail];
		} else {
			NSUInteger count = indexPath.row + 1;
			NSMutableArray *arCells=[NSMutableArray array];
			for(NSString *songName in detail.listNameArray ) {
				[arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                listDetailModel *insertList = [[listDetailModel alloc]initWithListName:songName
                                                                             andLevel:@"1"
                                                                             andArray:nil];
				[self.arrayForTable insertObject:insertList atIndex:count++];
			}
			[tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
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
        [self.listTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]]withRowAnimation:UITableViewRowAnimationRight];
    }
    
}


@end
