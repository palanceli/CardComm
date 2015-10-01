//
//  CCExerciseItemStore.h
//  CardComm
//
//  Created by palance on 15/10/1.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCExerciseItemStore : NSObject
+(instancetype)sharedStore;

-(void)loadExercises;
@end
