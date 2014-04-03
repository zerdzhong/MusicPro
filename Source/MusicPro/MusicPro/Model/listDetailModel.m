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
          andSuperList:(listDetailModel *)superList
              andArray:(NSArray *)songNameList
{
    if (self = [super init]) {
        //
        self.superList = superList;
        if (superList == nil) {
            self.level = 0;
        }else{
            self.level = 1;
        }
        self.name = name;
        self.listNameArray = [NSMutableArray arrayWithArray:songNameList];
        self.isListShow = NO;
    }
    return self;
}

@end
