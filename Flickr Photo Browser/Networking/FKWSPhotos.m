//
//  FKWSPhotos.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKWSPhotos.h"
#import "FKNetworking.h"
#import "FKOperationQueues.h"
#import "FKServerInfo.h"
#import "FKPhotoModel.h"

#define kTimeoutIntervalForRequest           60

@implementation FKWSPhotos


+ (void) getFlickrPhotosForApi:(FKFlickrApiType)apiType
              startIndex:(int)startIndex
               noOfObjectsPerPage:(int)perPageCount
                          success:(void (^)(NSArray *photos))successBlock
                          failure:(void (^)(NSError * inError))failureBlock {

    NSURL *url = nil;

    switch (apiType)
    {
        case FKFlickrApiTypeInterestingness: {

            url = [FKServerInfo interestingnessURL:startIndex noOfObjectsPerPage:perPageCount];
            break;
        }

        case  FKFlickrApiTypeRecent: {

            url = [FKServerInfo recentsURL:startIndex noOfObjectsPerPage:perPageCount];
            break;
        }
    }

    if (!url) failureBlock(nil);

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [FKNetworking  getDataWithRequest:request
                              onQueue:[FKOperationQueues flickrPhotosConnectionQueue]
                      completionBlock:^(BOOL success, NSDictionary *responseDictionary, NSError *error) {

                              if (error || !responseDictionary || !success) {
                                  failureBlock(error);
                              } else {
                                  successBlock([FKWSPhotos getPhotosFromDictionary:responseDictionary]);
                                  
                              }
                      }];
}

+ (NSArray *) getPhotosFromDictionary:(NSDictionary *)dictionary {

    if (![dictionary isKindOfClass:NSDictionary.class]) {
        return nil;
    }

    NSDictionary *payload = dictionary[@"query"];
    if (![payload isKindOfClass:NSDictionary.class]) {
        return nil;
    }

    NSDictionary *photosPayload = payload[@"results"];

    if (![photosPayload isKindOfClass:NSDictionary.class]) {
        return nil;
    }

    NSArray *photoItems = photosPayload[@"photo"];

    if (![photoItems isKindOfClass:NSArray.class]) {
        return nil;
    }

    return [FKPhotoModel imageResultsWithArray:photoItems];
}



@end
