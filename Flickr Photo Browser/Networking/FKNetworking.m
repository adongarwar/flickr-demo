//
//  FKNetworking.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKNetworking.h"

#define kTimeoutIntervalForRequest           60

@interface FKNetworking() <NSURLSessionDelegate>


@end

@implementation FKNetworking


+ (void)getDataWithRequest:(NSURLRequest *)request onQueue:(NSOperationQueue *)queue completionBlock:(completionBlock)completionBlock
{

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:(id<NSURLSessionDelegate>)self delegateQueue:queue];

    config.timeoutIntervalForRequest = kTimeoutIntervalForRequest;

    [[session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error) {

        if (error) {

            NSLog(@"Error: %@ %@", error, [error localizedDescription]);
            completionBlock(NO, nil, error);
        } else if (!response) {

            completionBlock(NO, nil, error);
        } else if (!data) {

            completionBlock(NO, nil, error);
        } else {

            NSError *jsonError = nil;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            completionBlock(YES, jsonDictionary, nil);
        }
    }] resume];
}



@end
