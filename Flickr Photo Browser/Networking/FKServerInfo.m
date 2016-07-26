//
//  FKServerInfo.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKServerInfo.h"
#import "NSString+URLEncode.h"

static NSString *const kInterestingnessPhotosSubDomainName			= @"interestingness";
static NSString *const kRecentPhotosSubDomainName                   = @"recent";
static NSString *const kApiKey                                      = @"d5c7df3552b89d13fe311eb42715b510";

@implementation FKServerInfo


+ (NSString *) serverAddress
{

    return @"https://query.yahooapis.com/v1/public/yql";
}

+ (NSString *) flickrDomain
{

    return @"flickr.photos";
}

+ (NSString *) interestingnessSubDomain
{

    return [NSString stringWithFormat:@"%@.%@", [FKServerInfo flickrDomain], kInterestingnessPhotosSubDomainName];
}


+ (NSString *) recentSubDomain
{

    return [NSString stringWithFormat:@"%@.%@", [FKServerInfo flickrDomain], kRecentPhotosSubDomainName];
}

+ (NSString *) photosQuery:(NSString *)domainInfoString from:(int)startIndex noOfObjectsPerPage:(int)perPageCount
{

    return [NSString stringWithFormat:@"select * from %@ (%i,%i)where api_key='%@'&diagnostics=true&format=json", domainInfoString, startIndex, perPageCount, kApiKey];
}

+ (NSURL*) interestingnessURL:(int)startIndex noOfObjectsPerPage:(int)perPageCount
{
    NSString *encodedQuery = [[FKServerInfo photosQuery:[FKServerInfo interestingnessSubDomain]
                                                   from:startIndex
                                     noOfObjectsPerPage:perPageCount] pathURLEncode];

    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@", [FKServerInfo serverAddress], encodedQuery]];
}

+ (NSURL*) recentsURL:(int)startIndex noOfObjectsPerPage:(int)perPageCount
{
    NSString *encodedQuery = [[FKServerInfo photosQuery:[FKServerInfo recentSubDomain]
                                                   from:startIndex
                                     noOfObjectsPerPage:perPageCount] pathURLEncode];

    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@", [FKServerInfo serverAddress], encodedQuery]];
}


+ (NSString*) constructUrlForModel:(FKPhotoModel *)photoModel photoType:(FKPhotoType)photoType {

    switch (photoType)
    {
        case FKPhotoTypeThumbnail: {

            return [NSString stringWithFormat:@"http://farm%lu.staticflickr.com/%@/%@_%@_t_d.jpg",
                                (unsigned long)photoModel.farm, photoModel.server,
                                                        photoModel.identifier, photoModel.secret];
        break;
        }

        case  FKPhotoTypeOriginal: {

            return [NSString stringWithFormat:@"http://farm%lu.staticflickr.com/%@/%@_%@.jpg",
                                (unsigned long)photoModel.farm, photoModel.server,
                                                    photoModel.identifier, photoModel.secret];

        break;
        }
    }
}

@end
