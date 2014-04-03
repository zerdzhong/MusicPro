//
//  listDetailModel.h
//  MusicPro
//
//  Created by apple  on 14-4-2.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listDetailModel : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)listDetailModel *superList;
@property (nonatomic, assign)int level;
@property (nonatomic, assign)bool isListShow;
@property (nonatomic, strong)NSMutableArray *listNameArray;

- (id)initWithListName:(NSString *)name
          andSuperList:(listDetailModel *)superList
              andArray:(NSArray *)songNameList;


@end