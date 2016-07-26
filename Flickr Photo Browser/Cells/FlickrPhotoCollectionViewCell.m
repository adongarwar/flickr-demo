//
//  FlickrPhotoCollectionViewCell.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/24/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FlickrPhotoCollectionViewCell.h"


@interface FlickrPhotoCollectionViewCell()

@property (weak) IBOutlet UIActivityIndicatorView * activityIndicatorView;
@property (weak) IBOutlet UIImageView * imageView;
@property (strong, nonatomic) FKPhotoModel * photoModel;


@end

@implementation FlickrPhotoCollectionViewCell

- (void) configureCellWithModel:(FKPhotoModel *)photoModel {

    self.photoModel = photoModel;

    if (!self.photoModel.thumbnail) {

        self.imageView.image = nil;
        //self.activityIndicatorView.hidden = NO;
        [self.activityIndicatorView startAnimating];

        __weak typeof(self) weakSelf = self;

        [self.photoModel getThumbnailPhotoWithCompletion:^(FKPhotoModel *photoModel) {

            __typeof (self) __strong strongSelf = weakSelf;

            dispatch_async(dispatch_get_main_queue(), ^{

                if (strongSelf && strongSelf.photoModel && [strongSelf.photoModel.identifier isEqualToString:photoModel.identifier]) {
                    self.imageView.image = photoModel.thumbnail;
                    [self.activityIndicatorView stopAnimating];
                }
            });
        }];
    } else {
        self.imageView.image = self.photoModel.thumbnail;
    }
}

@end
