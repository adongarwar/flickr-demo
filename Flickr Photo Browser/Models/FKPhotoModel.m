//
//  PhotoModel.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKPhotoModel.h"
#import "FKPhotoDownloader.h"

@implementation FKPhotoModel

#pragma mark - Init

- (instancetype)initWithAttributes:(NSDictionary *)attributes {

    self = [super init];
    if (!self) {
        return nil;
    }

    id componement;

    // farm
    componement = attributes[@"farm"];
    if ([componement respondsToSelector:@selector(integerValue)]) {
        _farm = [componement integerValue];
    } 

    // identifier
    componement = attributes[@"id"];
    if ([componement isKindOfClass:NSString.class] && [componement length] > 0) {
        _identifier = componement;
    } 

    // isfamily
    componement = attributes[@"isfamily"];
    if ([componement respondsToSelector:@selector(boolValue)]) {
        _isFamily = [componement boolValue];
    } 

    //isfriend
    componement = attributes[@"isfriend"];
    if ([componement respondsToSelector:@selector(boolValue)]) {
        _isFriend = [componement boolValue];
    } 

    //ispublic
    componement = attributes[@"ispublic"];
    if ([componement respondsToSelector:@selector(boolValue)]) {
        _isPublic = [componement boolValue];
    } 

    // owner
    componement = attributes[@"owner"];
    if ([componement isKindOfClass:NSString.class] && [componement length] > 0) {
        _owner = componement;
    } 

    // secret
    componement = attributes[@"secret"];
    if ([componement isKindOfClass:NSString.class] && [componement length] > 0) {
        _secret = componement;
    } 

    // server
    componement = attributes[@"server"];
    if ([componement isKindOfClass:NSString.class] && [componement length] > 0) {
        _server = componement;
    } 

    // Title
    componement = attributes[@"title"];
    if ([componement isKindOfClass:NSString.class] && [componement length] > 0) {
        _title = componement;
    } 

    return self;
}


#pragma mark - Factory

+ (FKPhotoModel *)imageResultWithAttributes:(NSDictionary *)attributes {
    return [[FKPhotoModel alloc] initWithAttributes:attributes];
}

+ (NSArray *)imageResultsWithArray:(NSArray *)array {

    NSMutableArray *photoModels = [NSMutableArray array];

    for (id photoModelDict in array) {
        if (![photoModelDict isKindOfClass:NSDictionary.class]) {
            continue;
        }

        FKPhotoModel *photoModel = [FKPhotoModel imageResultWithAttributes:photoModelDict];
        if (!photoModel) {
            continue;
        }

        [photoModels addObject:photoModel];
    }

    return photoModels;
}

- (void)getThumbnailPhotoWithCompletion:(void (^)(FKPhotoModel *photoModel))completion {

    __weak typeof(self) weakSelf = self;

    [FKPhotoDownloader fetchImageForModel:self photoType:FKPhotoTypeThumbnail completion:^(UIImage *image) {
        weakSelf.thumbnail = image;
        completion(self);
    }];
}

- (void)getOriginalPhotoWithCompletion:(void (^)(FKPhotoModel *photoModel))completion {

    __weak typeof(self) weakSelf = self;

    [FKPhotoDownloader fetchImageForModel:self photoType:FKPhotoTypeOriginal completion:^(UIImage *image) {
        weakSelf.originalImage = image;
        completion(self);
    }];
}

@end

