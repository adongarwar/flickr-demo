//
//  FKPhotoDownloader.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/24/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKPhotoDownloader.h"
#import "FKServerInfo.h"
#import "FKOperationQueues.h"

@interface FKPhotoDownloader() <NSURLSessionDelegate>

@end

@implementation FKPhotoDownloader

+ (void)fetchImageForModel:(FKPhotoModel *)photoModel photoType:(FKPhotoType)photoType completion:(void (^)(UIImage *image))completion {


    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:(id<NSURLSessionDelegate>)self delegateQueue:[FKOperationQueues photoDownloadConnectionQueue]];

    NSString *url = [FKServerInfo constructUrlForModel:photoModel photoType:photoType];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];


    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSHTTPURLResponse *status = (NSHTTPURLResponse *)response;
            NSInteger statusCode = status.statusCode;
            if (statusCode >= 200 && statusCode < 300) {

                UIImage *image = [UIImage imageWithData:data];
                completion(image);

            } else {
                completion(nil);
            }
        } else {
            completion(nil);
        }
    }];
    [task resume];
}



@end
