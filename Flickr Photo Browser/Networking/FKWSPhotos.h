//
//  FKWSPhotos.h
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

typedef NS_ENUM(NSInteger, FKFlickrApiType) {
    FKFlickrApiTypeInterestingness = 0,
    FKFlickrApiTypeRecent,
};

@interface FKWSPhotos : NSObject

+ (void) getFlickrPhotosForApi:(FKFlickrApiType)apiType
                    startIndex:(int)startIndex
            noOfObjectsPerPage:(int)perPageCount
                       success:(void (^)(NSArray *photos))successBlock
                       failure:(void (^)(NSError * inError))failureBlock;

@end
