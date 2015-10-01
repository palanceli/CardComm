//
//  CCExerciseItemStore.m
//  CardComm
//
//  Created by palance on 15/10/1.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "CCExerciseItemStore.h"

@implementation CCExerciseItemStore
#pragma mark - 单体
+(instancetype)sharedStore
{
    static CCExerciseItemStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc]initPrivate];
    });
    return sharedStore;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use [CCExerciseItemStore init]" userInfo:nil];
    return nil;
}

-(void)loadExercises
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *jsonPath = [[bundle bundlePath]stringByAppendingPathComponent:@"defaultJSons"];
    NSLog(@"%@:%d %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, jsonPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:jsonPath error:&error];
    for (NSString *f in fileList) {
        NSLog(@"%@:%d %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, f);
    }
}
@end
