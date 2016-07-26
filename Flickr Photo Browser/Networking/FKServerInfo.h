//
//  FKServerInfo.h
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "FKPhotoModel.h"

@interface FKServerInfo : NSObject

+ (NSURL*) interestingnessURL:(int)startIndex noOfObjectsPerPage:(int)perPageCount;
+ (NSURL*) recentsURL:(int)startIndex noOfObjectsPerPage:(int)perPageCount;
+ (NSString*) constructUrlForModel:(FKPhotoModel *)photoModel photoType:(FKPhotoType)photoType;

@end
