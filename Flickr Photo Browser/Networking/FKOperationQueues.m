//
//  FKOperationQueues.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKOperationQueues.h"

NSString* const flickrPhotosConnectionQueue        = @"com.SampleCorp.flickrPhotosConnectionQueue";
NSString* const photoDownloadConnectionQueue       = @"com.SampleCorp.photoDownloadQueue";

@implementation FKOperationQueues

+ (NSOperationQueue *)flickrPhotosConnectionQueue {

    static dispatch_once_t once;
    static NSOperationQueue *connectionQueue;
    dispatch_once(&once, ^{
        
        connectionQueue = [[NSOperationQueue alloc] init];
        [connectionQueue setMaxConcurrentOperationCount:2];
        [connectionQueue setName:flickrPhotosConnectionQueue];
    });

    return connectionQueue;
}


+ (NSOperationQueue *)photoDownloadConnectionQueue {

    static dispatch_once_t once;
    static NSOperationQueue *connectionQueue;
    dispatch_once(&once, ^{

        connectionQueue = [[NSOperationQueue alloc] init];
        [connectionQueue setMaxConcurrentOperationCount:4];
        [connectionQueue setName:photoDownloadConnectionQueue];
    });

    return connectionQueue;
}

@end
