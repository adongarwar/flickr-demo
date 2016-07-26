//
//  FKOperationQueue.h
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

@interface FKOperationQueues : NSObject

+ (NSOperationQueue *)flickrPhotosConnectionQueue;
+ (NSOperationQueue *)photoDownloadConnectionQueue;

@end
