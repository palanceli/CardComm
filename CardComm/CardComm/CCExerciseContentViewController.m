//
//  CCExerciseContentViewController.m
//  CardComm
//
//  Created by palance on 15/10/5.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "CCExerciseContentViewController.h"
#import "ReusableScrollView.h"
#import "CCExerciseContentView.h"

@interface CCExerciseContentViewController()<ReusableScrollViewDelegate>

@property (strong, nonatomic) IBOutlet ReusableScrollView *scrollView;
@property (strong, nonatomic) NSArray *words;
@end

@implementation CCExerciseContentViewController
-(void)viewDidLoad
{
    self.words = [self.item randomWords];
    self.scrollView.delegateForReuseableScrollView = self;
    [self.scrollView setupViews];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView adjustSize];
}

-(NSUInteger)numOfPages
{
    return [self.words count];
}

-(UIView*)setupView:(UIView *)view toPage:(NSUInteger)toPage
{
    if (view == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = (UIViewController*)[storyboard instantiateViewControllerWithIdentifier:@"CCExerciseContentViewController"];
        view = vc.view;
    }
    CCExerciseContentView *exerciseContentView = (CCExerciseContentView*)view;
    exerciseContentView.keyWordLabel.text = self.words[toPage];
    return view;
}
@end
