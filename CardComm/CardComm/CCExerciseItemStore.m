//
//  CCExerciseItemStore.m
//  CardComm
//
//  Created by palance on 15/10/1.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "CCExerciseItemStore.h"
#import "CCExerciseItem.h"
@interface CCExerciseItemStore()
@property (nonatomic, strong) NSMutableArray *items;
@end

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
        _items = [[NSMutableArray alloc]init];
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
    // 拼接json目录
    NSString *jsonDir = [[bundle bundlePath]stringByAppendingPathComponent:@"defaultJSons"];
    NSLog(@"defaultJSon目录：%@",  jsonDir);
    // 遍历json目录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:jsonDir error:&error];
    NSLog(@"遍历json文件：");
    for (NSString *f in fileList) {
        NSLog(@"%@", f);
        NSString *jsonFilePath = [jsonDir stringByAppendingPathComponent:f];
        CCExerciseItem *item = [[CCExerciseItem alloc]initWithJSONFilePath:jsonFilePath];
        [self.items addObject:item];
        [item Log];
    }
}
@end
