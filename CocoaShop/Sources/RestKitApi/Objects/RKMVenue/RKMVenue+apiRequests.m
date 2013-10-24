//
//  RKMVenue+apiRequests.m
//  CocoaShop
//
//  Created by user on 17.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "RKMVenue+apiRequests.h"
#import "NSManagedObject+abstractRest.h"
//#import "RKMVenue+mapping.h"

@implementation RKMVenue (apiRequests)

+(void)venuesWithQuery:(NSString*)queryString fromCoordinate:(CLLocationCoordinate2D)coordinate finishBlock:(void (^)(NSArray *objects))finishBlock errorBlock:(void(^)(NSError *error))errorBlock
{
    NSString *resourcePath=RESTAPI_VENUES_SEARCH_PATH;
    
    queryString=queryString ? queryString : @"";
    NSDictionary *params=@{@"client_id":        FOURSQUARE_CLIENT_ID,
                           @"client_secret":    FOURSQUARE_CLIENT_SECRET,
                           @"ll":               [NSString stringWithFormat:@"%f,%f",coordinate.latitude,coordinate.longitude],
                           @"query":            queryString,
                           @"v":                @"20130815",
                           };
    
    //you may setup your own responseDescriptor per request operation
    //
    /*
    RKResponseDescriptor *responseDescriptor=[RKResponseDescriptor responseDescriptorWithMapping:RKMVenue.entityMapping
                                                                                          method:RKRequestMethodGET
                                                                                     pathPattern:resourcePath
                                                                                         keyPath:@"response.venues"
                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    responseDescriptor.baseURL = RKObjectManager.sharedManager.baseURL;
    */
    
    [self.class getManagedObjectsAtResourcePath:resourcePath
                                         params:params
                            responseDescriptors:RKObjectManager.sharedManager.responseDescriptors //@[responseDescriptor]
                                    finishBlock:^(NSArray *objects, NSDictionary *response)
     {
         //you may perform any additional operations over response Dictionary here
         finishBlock(objects);
         
     } errorBlock:errorBlock];

}

@end
