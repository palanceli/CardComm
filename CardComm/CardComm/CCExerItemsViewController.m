//
//  CCExerItemsViewController.m
//  CardComm
//
//  Created by palance on 15/10/4.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "CCExerItemsViewController.h"
#import "CCExerciseItem.h"
#import "CCExerciseItemStore.h"

@implementation CCExerItemsViewController
#pragma mark - UITableViewDataSource方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[CCExerciseItemStore sharedStore] allExercises].count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCExerciseItemCell" forIndexPath:indexPath];
    NSArray *allExercies = [[CCExerciseItemStore sharedStore]allExercises];
    CCExerciseItem *item = allExercies[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

@end
