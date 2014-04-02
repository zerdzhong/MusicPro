//
//  MainListModel.h
//  MusicPro
//
//  Created by apple  on 14-4-2.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainListModel : NSObject

@property (strong, nonatomic)NSMutableArray *listArray;

- (id)initWithListDetailArray:(NSMutableArray *)array;

@end
