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
    [self.view addSubview:self.listTableView];
    
    self.arrayForTable = [[NSMutableArray alloc]init];
    NSDictionary *listDic1 = @{@"name": @"ALL",@"songName" : @[@"1",@"2",@"3"],@"level" : @"0"};
    NSDictionary *listDic2 = @{@"name": @"FAVURITE",@"songName" : @[@"a",@"b",@"c"],@"level" : @"0"};
    NSDictionary *listDic3 = @{@"name": @"ROCK",@"songName" : @[@"A",@"B",@"C"],@"level" : @"0"};
    [self.arrayForTable addObject:listDic1];
    [self.arrayForTable addObject:listDic2];
    [self.arrayForTable addObject:listDic3];
    
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
	
	cell.textLabel.text=[[self.arrayForTable objectAtIndex:indexPath.row] valueForKey:@"name"];
	[cell setIndentationLevel:[[[self.arrayForTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSDictionary *dic=[self.arrayForTable objectAtIndex:indexPath.row];
	if([dic valueForKey:@"songName"]) {
		NSArray *array=[dic valueForKey:@"songName"];
		
		BOOL isAlreadyInserted=NO;
		
		for(NSDictionary *songDic in array ){
			NSInteger index=[self.arrayForTable indexOfObjectIdenticalTo:songDic];
			isAlreadyInserted=(index>0 && index!=NSIntegerMax);
			if(isAlreadyInserted) break;
		}
		
		if(isAlreadyInserted) {
			[self miniMizeThisRows:self.arrayForTable];
		} else {
			NSUInteger count = indexPath.row + 1;
			NSMutableArray *arCells=[NSMutableArray array];
			for(NSString *songName in array ) {
				[arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
				[self.arrayForTable insertObject:@{@"name": songName,@"level" : @"1"} atIndex:count++];
			}
			[tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
		}
	}
}

-(void)miniMizeThisRows:(NSArray*)array{
	
	for(NSDictionary *dic in array ) {
		NSUInteger indexToRemove=[self.arrayForTable indexOfObjectIdenticalTo:dic];
		
		if([self.arrayForTable indexOfObjectIdenticalTo:dic]!= NSNotFound) {
			[self.arrayForTable removeObjectIdenticalTo:dic];
            
			[self.listTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]]withRowAnimation:UITableViewRowAnimationRight];
		}
	}
}


@end
