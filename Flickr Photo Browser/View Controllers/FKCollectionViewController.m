//
//  FKCollectionViewController.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKCollectionViewController.h"
#import "FKWSPhotos.h"
#import "FlickrPhotoCollectionViewCell.h"
#import "FKPhotoViewController.h"


#define kMinimumLineSpacing         2.f
#define kPhotosPerPage              10

static NSString * const kCellReuseIdentifier = @"FlickrCell";

@interface FKCollectionViewController()

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, assign) NSUInteger perPageCount;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) int currentOffset;
@property (nonatomic, assign) FKFlickrApiType apiType;

@property (nonatomic, assign) FlickrPhotoCollectionViewCell *selectedCell;

@end

@implementation FKCollectionViewController

#pragma mark - View Creation Hierarchy

- (void)viewDidLoad {
    [super viewDidLoad];

    [self collectionViewSetUp];
    [self dataSetUp];

    [self refreshData];
}

#pragma mark - Setup Convinience

- (void) collectionViewSetUp {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0.f;
    flowLayout.minimumLineSpacing = kMinimumLineSpacing;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.alwaysBounceVertical = YES;
}

- (void) dataSetUp {

    switch (self.viewType)
    {
        case FKFlickrViewTypeInterestingness: {

            self.apiType = FKFlickrApiTypeInterestingness;
            break;
        }

        case  FKFlickrViewTypeRecent: {

            self.apiType = FKFlickrApiTypeRecent;
            break;
        }
    }
    
    self.currentOffset = 0;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];

    [cell configureCellWithModel:self.photos[indexPath.item]];

    if (indexPath.row == (self.photos.count - 2)) {

        [self refreshData];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.itemWidth, self.itemWidth);
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([sender class] == [FlickrPhotoCollectionViewCell class] && [segue.destinationViewController isKindOfClass:[FKPhotoViewController class]]) {

        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        FKPhotoModel *photoModel = self.photos[[(NSIndexPath *)indexPath row]];
        FKPhotoViewController *photoVC = (FKPhotoViewController *)segue.destinationViewController;
        [photoVC populatePhoto:photoModel];
    }
}


- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];

    // invalidate layout on rotation
    [self.collectionViewLayout invalidateLayout];
}

#pragma mark - Web Services

- (void) refreshData {

    __typeof (self) __weak weakSelf = self;

    [FKWSPhotos getFlickrPhotosForApi:self.apiType
                           startIndex:self.currentOffset
                   noOfObjectsPerPage:kPhotosPerPage
                              success:^(NSArray *photos) {

                                  __typeof (self) __strong strongSelf = weakSelf;
                                  [strongSelf.photos addObjectsFromArray:photos];

                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      [strongSelf.collectionView reloadData];
                                      strongSelf.currentOffset = strongSelf.currentOffset + kPhotosPerPage;
                                  });

                              } failure:^(NSError *inError) {
                                  [weakSelf showAlert];
                              }];
}


#pragma mark Getters - Setters - lazy initializers

- (NSMutableArray *)photos
{
    if (!_photos) {
            _photos = [NSMutableArray array];
    }

    return _photos;
}


- (CGFloat)itemWidth
{
    if (!_itemWidth) {
        CGFloat numberOfColumns = UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone ? 4.f : 3.f;
        CGFloat lineSpacingWidth = kMinimumLineSpacing * (numberOfColumns - 1);
        _itemWidth = (CGRectGetWidth(self.view.frame) - lineSpacingWidth) / numberOfColumns;
    }

    return _itemWidth;
}

#pragma mark Error Handlers

- (void)showAlert
{
    NSString *message = NSLocalizedString(@"Sorry. An error occured while accessing flickr.", nil);

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error!", nil)
                                                                             message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil) style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

@end
