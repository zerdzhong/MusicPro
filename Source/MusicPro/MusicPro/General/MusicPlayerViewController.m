//
//  MusicPlayerViewController.m
//  MusicPro
//
//  Created by apple  on 14-4-2.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "ViewUtils.h"

@interface MusicPlayerViewController ()

@end

@implementation MusicPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //背景
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backgroundImageView.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:backgroundImageView];
    
    
    //创建按钮
    self.playButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 64 + 5, 50, 50)];
    self.playButton.tag = 1000;
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    
    //创建歌曲和歌手label
    self.songLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 64, 200, 30)];
    self.songLabel.backgroundColor = [UIColor clearColor];
    self.songLabel.text = @"Knocking on Heaven's Door";
    self.songLabel.font = [UIFont systemFontOfSize:15];
    self.songLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.songLabel];
    
    self.singerLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 64 + 15, 200, 50)];
    self.singerLabel.backgroundColor = [UIColor clearColor];
    self.singerLabel.text = @"Guns N' Roses";
    self.singerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.singerLabel];
    
    //创建进度条
    self.songProgress = [[UISlider alloc]initWithFrame:CGRectMake(10, 64 + 60, 300, 10)];
    self.songProgress.backgroundColor = [UIColor clearColor];
    [self.songProgress setMaximumTrackImage:[UIImage imageNamed:@"sliderBack.png"] forState:UIControlStateNormal];
    [self.songProgress setMinimumTrackImage:[UIImage imageNamed:@"sliderBack.png"] forState:UIControlStateNormal];
    [self.songProgress setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateNormal];
    [self.songProgress setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateHighlighted];
    [self.songProgress addTarget:self action:@selector(progressChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.songProgress];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTime:) userInfo:nil repeats:YES];
    
    //半透明背景
    UIImageView *playBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0,44, ScreenWidth, 100)];
    playBackground.image = [UIImage imageNamed:@"buttonBackground.png"];
    [self.view addSubview:playBackground];
    
    UIImageView *voiceBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0,ScreenHeight - 80, ScreenWidth, 80)];
    voiceBackground.image = [UIImage imageNamed:@"buttonBackground.png"];
    [self.view addSubview:voiceBackground];
    
    self.quiteButton = [[UIButton alloc]initWithFrame:CGRectMake(10, ScreenHeight - 50, 30, 30)];
    self.quiteButton.tag = 1001;
    [self.quiteButton setBackgroundImage:[UIImage imageNamed:@"quite.png"] forState:UIControlStateNormal];
    [self.quiteButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.quiteButton];
    
    //音量调节
    self.volumeSlider = [[UISlider alloc]initWithFrame:CGRectMake(60, ScreenHeight - 45, 200, 20)];
    self.volumeSlider.backgroundColor = [UIColor clearColor];
    self.volumeSlider.value = 0.5;
    [self.volumeSlider setMaximumTrackImage:[UIImage imageNamed:@"sliderBack.png"] forState:UIControlStateNormal];
    [self.volumeSlider setMinimumTrackImage:[UIImage imageNamed:@"sliderBack.png"] forState:UIControlStateNormal];
    [self.volumeSlider setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateNormal];
    [self.volumeSlider setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateHighlighted];
    [self.volumeSlider addTarget:self action:@selector(volumeChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.volumeSlider];
    
    /*
     //添加播放器
     NSString *path = [[NSBundle mainBundle]pathForResource:@"Knockin'_on_Heaven's_Door" ofType:@"mp3"];
     NSURL *url = [[NSURL alloc]initFileURLWithPath:path];
     self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
     self.player.volume = 0.5;
     [self.player prepareToPlay];
     
     //添加歌词显示
     self.lyricTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 260) style:UITableViewStylePlain];
     self.lyricTableView.backgroundColor = [UIColor clearColor];
     self.lyricTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.lyricTableView.center = CGPointMake(160, 250);
     self.lyricTableView.rowHeight = 30;
     self.lyricTableView.userInteractionEnabled = NO;
     self.lyricTableView.dataSource = self;
     self.lyricTableView.delegate = self;
     [self.view addSubview:self.lyricTableView];
     
     //进度条下时间显示
     self.durationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
     self.durationLabel.center = CGPointMake(300, 100);
     self.durationLabel.backgroundColor = [UIColor clearColor];
     int min = self.player.duration/60;
     int sec = (int)self.player.duration%60;
     self.durationLabel.text = [NSString stringWithFormat:@"%02d:%02d",min,sec];
     [self.view addSubview:self.durationLabel];
     
     self.currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
     self.currentTimeLabel.center = CGPointMake(35, 100);
     self.currentTimeLabel.backgroundColor = [UIColor clearColor];
     self.currentTimeLabel.text = @"00:00";
     [self.view addSubview:self.currentTimeLabel];
     
     //创建歌词
     NSString *lrcPath = [[NSBundle mainBundle]pathForResource:@"Knocking_On_Heaven's_Door" ofType:@"lrc"];
     NSString *lrcContext = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
     NSArray *lineArray = [lrcContext componentsSeparatedByString:@"\n"];
     for (NSString * str in lineArray){
     [self parseLrcLine:str];
     }
     //将得到的歌词，时间加到字典中
     NSLog(@"%@",self.tempArray);
     [self addToDic];
     NSLog(@"%@",self.lrcDictionary);
     */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 解析每一行，将每一行的[time]和内容分开 按顺序存储 时间 【时间】 歌词
-(void) parseLrcLine:(NSString *)sourceLineText
{
    if (!sourceLineText || sourceLineText.length <= 0){
        return;
    }
    NSRange range = [sourceLineText rangeOfString:@"]"];
    if (range.length > 0)
    {
        NSString * time = [sourceLineText substringToIndex:range.location + 1];
        NSString * other = [sourceLineText substringFromIndex:range.location + 1];
        if (time && time.length > 0 ){
            NSString *tmp = [time substringWithRange:NSMakeRange(4, 2)];
            if (([tmp isEqual:@"00"]) || ([tmp intValue]>0 && [tmp intValue]<=60)) {
                [self.tempArray addObject:[time substringWithRange:NSMakeRange(1, 5)]];
            }
        }
        if (other)
            [self parseLrcLine:other];
    }else
    {
        if (sourceLineText.length > 1) {
            [self.tempArray addObject:sourceLineText];
        }
    }
}

-(void)addToDic
{
    for (int i = 0 ; i < [self.tempArray count]; i++) {
        NSString *lrcStr = [self.tempArray objectAtIndex:i];
        if (![self isTimeStr:lrcStr]) {
            NSLog(@"%@",lrcStr);
            for (int j = i-1; j>=0; j--) {
                NSString *timeStr = [self.tempArray objectAtIndex:j];
                if ([self isTimeStr:timeStr]) {
                    NSLog(@"%@",timeStr);
                    [self.timeArray addObject:timeStr];
                    [self.lrcDictionary setObject:lrcStr forKey:timeStr];
                }else{
                    break;
                }
            }
        }
    }
}

//判断字符串是事件戳还是歌词
-(BOOL)isTimeStr:(NSString *) str
{
    NSString *tmp = [str substringWithRange:NSMakeRange(0, 2)];
    if (([tmp isEqual:@"00"]) || ([tmp intValue]>0 && [tmp intValue]<=60)) {
        return YES;
    }else{
        return NO;
    }
}

//按钮响应方法
-(void)onButton:(UIButton *)button
{
    
    
    switch (button.tag) {
        case 1000:
            if ([self.player isPlaying]) {
                [self.player pause];
                [self.playButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
            }else{
                [self.player play];
                [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            }
            break;
        case 1001:
            if (self.player.volume ==0) {
                self.player.volume = self.volumeSlider.value;
            }else{
                self.player.volume = 0;
            }
            break;
        default:
            break;
    }
}
//歌曲进度滑块响应方法
-(void)progressChange:(UISlider *)slider
{
    self.player.currentTime = slider.value * self.player.duration;
}
//timer回调方法同步播放进度，播放时间,同步歌词
-(void)onTime:(id)sender
{
    self.songProgress.value = self.player.currentTime/self.player.duration;
    int min = self.player.currentTime / 60;
    int sec = (int)self.player.currentTime % 60;
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",min,sec];
    //歌词显示
    if ([self.lrcDictionary objectForKey:self.currentTimeLabel.text] != nil) {
        NSLog(@"lrc = %@",[self.lrcDictionary objectForKey:self.currentTimeLabel.text]);
        NSIndexPath *path = [NSIndexPath indexPathForRow:[self.timeArray indexOfObject:self.currentTimeLabel.text] inSection:0];
        [self.lyricTableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    
}
//音量滑块响应方法
-(void)volumeChange:(UISlider *)slider
{
    self.player.volume = slider.value;
}

#pragma mark uitableViewDelegate回调
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lrcDictionary count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdeintify = @"lyricCell";
    UITableViewCell *cell = [self.lyricTableView dequeueReusableCellWithIdentifier:cellIdeintify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdeintify];
    }
    cell.textLabel.text = [self.lrcDictionary objectForKey:[self.timeArray objectAtIndex:indexPath.row]];
    cell.textLabel.font =[UIFont systemFontOfSize:13];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    //    [self.lyricTableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    return cell;
}



@end
