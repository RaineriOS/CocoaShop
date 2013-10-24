//
//  RKMVenue+apiRequests.h
//  CocoaShop
//
//  Created by user on 17.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "RKMVenue.h"

@interface RKMVenue (apiRequests)

#define RESTAPI_VENUES_SEARCH_PATH      @"venues/search"

+(void)venuesWithQuery:(NSString*)queryString fromCoordinate:(CLLocationCoordinate2D)coordinate finishBlock:(void (^)(NSArray *objects))finishBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end
