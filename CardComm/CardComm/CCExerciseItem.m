//
//  CCExerciseItem.m
//  CardComm
//
//  Created by palance on 15/10/1.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "CCExerciseItem.h"

@implementation CCExerciseItem
-(instancetype)initWithJSONFilePath:(NSString *)jsonFilePath
{
    self = [super init];
    if (self) {
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
        NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        _filePath = jsonFilePath;
        _fileid = jsonObj[@"id"];
        _createTime = jsonObj[@"createTime"];
        _title = jsonObj[@"title"];
        
        _commendatories = jsonObj[@"commendatories"];
        _derogratories = jsonObj[@"derogratories"];
        _terms = jsonObj[@"terms"];
        _verbs = jsonObj[@"verbs"];
    }
    return self;
}

-(NSArray *)randomWords
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSString *i in self.commendatories) {
        if ([i length] > 0) {
            [array addObject:i];
        }
    }
    for (NSString *i in self.derogratories) {
        if ([i length] > 0) {
            [array addObject:i];
        }
    }
    for (NSString *i in self.terms) {
        if ([i length] > 0) {
            [array addObject:i];
        }
    }
    for (NSString *i in self.verbs) {
        if ([i length] > 0) {
            [array addObject:i];
        }
    }
    for (int i=0; i<[array count]; i++) {
        int j = arc4random() % [array count];
        NSString *tmp = array[j];
        array[j] = array[i];
        array[i] = tmp;
    }
    return array;
}

-(void)Log
{
    NSLog(@"id:%@\t title:%@\t createTime:%@", self.fileid, self.fileid, self.createTime);
    NSLog(@"filepath: %@", self.filePath);
    
    NSDictionary *keyWords = @{@"褒义词" : self.commendatories,
                               @"贬义词" : self.derogratories,
                               @"名词" : self.terms,
                               @"动词" : self.verbs,
                               };
    
    for (id key in keyWords) {
        NSString *wordString = @"";
        NSArray *words = keyWords[key];
        for (NSString *word in words) {
            wordString = [wordString stringByAppendingString:@" "];
            wordString = [wordString stringByAppendingString:word];
        }
        NSLog(@"%@: %@", key, wordString);
    }
}
@end
