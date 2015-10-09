//
//  CCExerciseItem.h
//  CardComm
//
//  Created by palance on 15/10/1.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCExerciseItem : NSObject
@property (nonatomic, strong) NSString *fileid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSArray *terms;
@property (nonatomic, strong) NSArray *verbs;
@property (nonatomic, strong) NSArray *commendatories;
@property (nonatomic, strong) NSArray *derogratories;

-(instancetype)initWithJSONFilePath:(NSString*)jsonFilePath;
-(NSArray *)randomWords;
-(void)Log;
@end
