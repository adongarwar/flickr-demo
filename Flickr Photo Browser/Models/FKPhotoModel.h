//
//  PhotoModel.h
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FKPhotoType) {
    FKPhotoTypeThumbnail = 0,
    FKPhotoTypeOriginal,
};

@interface FKPhotoModel : NSObject

@property (readonly, nonatomic, assign) NSUInteger farm;
@property (readonly, nonatomic, copy) NSString *identifier;
@property (readonly, nonatomic, assign) BOOL isFamily;
@property (readonly, nonatomic, assign) BOOL isFriend;
@property (readonly, nonatomic, assign) BOOL isPublic;
@property (readonly, nonatomic, copy) NSString *owner;
@property (readonly, nonatomic, copy) NSString *secret;
@property (readonly, nonatomic, copy) NSString *server;
@property (readonly, nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *originalImage;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (FKPhotoModel *)imageResultWithAttributes:(NSDictionary *)attributes;
+ (NSArray *)imageResultsWithArray:(NSArray *)array;

- (void)getThumbnailPhotoWithCompletion:(void (^)(FKPhotoModel *photoModel))completion;
- (void)getOriginalPhotoWithCompletion:(void (^)(FKPhotoModel *photoModel))completion;

@end