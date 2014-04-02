//
//  listDetailModel.m
//  MusicPro
//
//  Created by apple  on 14-4-2.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import "listDetailModel.h"

@implementation listDetailModel

- (id)initWithListName:(NSString *)name
              andLevel:(NSString *)level
              andArray:(NSArray *)songNameList
{
    if (self = [super init]) {
        //
        self.level = level;
        self.name = name;
        self.listNameArray = [NSMutableArray arrayWithArray:songNameList];
        self.isListShow = NO;
    }
    return self;
}

@end
