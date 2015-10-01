//
//  CCRootViewController.m
//  CardComm
//
//  Created by palance on 15/10/1.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "CCRootViewController.h"
#import "CCExerciseItemStore.h"

@implementation CCRootViewController
-(void)viewDidLoad
{
    CCExerciseItemStore *sharedStore = [CCExerciseItemStore sharedStore];
    [sharedStore loadExercises];
}
@end
