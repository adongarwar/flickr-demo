//
//  FKCollectionViewController.h
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FKFlickrViewType) {
    FKFlickrViewTypeInterestingness = 0,
    FKFlickrViewTypeRecent,
};


@interface FKCollectionViewController : UICollectionViewController

@property (nonatomic, assign) FKFlickrViewType viewType;

@end
