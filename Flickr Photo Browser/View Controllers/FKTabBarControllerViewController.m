//
//  FKTabBarControllerViewController.m
//  Flickr Photos Browser
//
//  Created by Avinash Dongarwar on 7/24/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKTabBarControllerViewController.h"
#import "FKCollectionViewController.h"

@interface FKTabBarControllerViewController ()

@end

@implementation FKTabBarControllerViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.viewControllers.count < 2) return;

    UINavigationController *interestingNavigationViewController = (UINavigationController *)[self.viewControllers objectAtIndex:0];
    FKCollectionViewController *interestingVC = (FKCollectionViewController *)[[interestingNavigationViewController viewControllers] lastObject];
    [interestingVC setViewType:FKFlickrViewTypeInterestingness];

    UINavigationController *recentNavigationViewController = (UINavigationController *)[self.viewControllers objectAtIndex:1];
    FKCollectionViewController *recentsVC = (FKCollectionViewController *)[[recentNavigationViewController viewControllers] lastObject];
    [recentsVC setViewType:FKFlickrViewTypeRecent];
}

@end
