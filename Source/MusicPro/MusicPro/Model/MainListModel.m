//
//  MainListModel.m
//  MusicPro
//
//  Created by apple  on 14-4-2.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import "MainListModel.h"

@implementation MainListModel

- (id)initWithListDetailArray:(NSMutableArray *)array
{
    if (self = [super init]) {
        //
        self.listArray = array;
    }
    return self;
}

@end
