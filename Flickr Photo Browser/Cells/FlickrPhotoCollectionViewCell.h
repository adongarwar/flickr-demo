//
//  FlickrPhotoCollectionViewCell.h
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/24/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKPhotoModel.h"

@interface FlickrPhotoCollectionViewCell : UICollectionViewCell

- (void) configureCellWithModel:(FKPhotoModel *)photoModel;

@end
