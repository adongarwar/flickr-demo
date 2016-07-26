//
//  NSString+URLEncode.m
//  Flickr Most Interesting
//
//  Created by Avinash Dongarwar on 7/23/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)

- (NSString *)pathURLEncode {

    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}

@end
