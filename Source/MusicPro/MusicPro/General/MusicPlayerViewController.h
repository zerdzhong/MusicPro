//
//  MusicPlayerViewController.h
//  MusicPro
//
//  Created by apple  on 14-4-2.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayerViewController : UIViewController <UITableViewDataSource,UITableViewDataSource>

@property (strong, nonatomic) UILabel *songLabel,*singerLabel;
@property (strong, nonatomic) UISlider *songProgress,*volumeSlider;
@property (strong, nonatomic) UILabel *currentTimeLabel,*durationLabel;
@property (strong, nonatomic) UIButton *playButton,*pauseButton,*quiteButton;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) UITableView *lyricTableView;
@property (strong, nonatomic) NSMutableArray *timeArray,*tempArray;
@property (strong, nonatomic) NSMutableDictionary *lrcDictionary;

@end
