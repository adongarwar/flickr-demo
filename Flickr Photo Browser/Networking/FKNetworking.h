//
//  FKNetworking.h
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

typedef void (^completionBlock)(BOOL success, NSDictionary *responseDictionary, NSError *error);

@interface FKNetworking : NSObject

+ (void)getDataWithRequest:(NSURLRequest *)request onQueue:(NSOperationQueue *)queue completionBlock:(completionBlock)completionBlock;

@end
