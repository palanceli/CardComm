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
#import "CCExerciseContentViewController.h"

@interface CCExerItemsViewController()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation CCExerItemsViewController
#pragma mark - UITableViewDataSource方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[CCExerciseItemStore sharedStore] allExercises].count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCExerciseItemCell" forIndexPath:indexPath];
    NSArray *allExercises = [[CCExerciseItemStore sharedStore]allExercises];
    CCExerciseItem *item = allExercises[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue.id=%@, from %@ to %@", segue.identifier, segue.sourceViewController, segue.destinationViewController);
    NSIndexPath *ip = [self.tableView indexPathForCell:sender];
    NSArray *allExercises = [[CCExerciseItemStore sharedStore]allExercises];
    CCExerciseItem *item = allExercises[ip.row];
    CCExerciseContentViewController *ecvc = (CCExerciseContentViewController*)segue.destinationViewController;
    ecvc.item = item;
}


@end
