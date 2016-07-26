//
//  FKPhotoViewController.m
//  Flickr Photo Browser
//
//  Created by Avinash Dongarwar on 7/24/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKPhotoViewController.h"

@interface FKPhotoViewController ()

@property (weak) IBOutlet UIScrollView * scrollView;
@property (weak) IBOutlet UIImageView * imageView;
@property (strong, nonatomic) FKPhotoModel * photoModel;
@property (weak) IBOutlet UIActivityIndicatorView * activityIndicatorView;

@end

@implementation FKPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.scrollView flashScrollIndicators];
    [self renderPhoto];
}


- (void) populatePhoto:(FKPhotoModel *)photoModel {

    self.photoModel = photoModel;
}


- (void) renderPhoto {

    if (!self.photoModel.originalImage) {

        [self.activityIndicatorView startAnimating];

        [self.photoModel getOriginalPhotoWithCompletion:^(FKPhotoModel *photoModel) {

            dispatch_async(dispatch_get_main_queue(), ^{
                if (photoModel.originalImage)
                    self.imageView.image = photoModel.originalImage;
                [self.activityIndicatorView stopAnimating];
            });
        }];
    } else {
        self.imageView.image = self.photoModel.originalImage;
    }

    self.title = self.photoModel.title;
}

@end
