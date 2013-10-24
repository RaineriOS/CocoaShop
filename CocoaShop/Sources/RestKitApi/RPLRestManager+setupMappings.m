//
//  RPLRestManager+setupMappings.m
//  
//
//  Created by user on 16.05.13.
//  Copyright (c) 2013 Novarate. All rights reserved.
//

#import "RPLRestManager+setupMappings.h"
#import "RKMVenue+mapping.h"
#import "RKMVenue+apiRequests.h"

@implementation RPLRestManager (setupMappings)



+(void)_setupMappings
{
    //same as managed mapping
    //difference in internal object mapping
}



+ (void)_setupManagedMapping
{
    RKObjectManager *objectManager = RKObjectManager.sharedManager;
    
    RKResponseDescriptor *venueResponseDescriptor=[RKResponseDescriptor responseDescriptorWithMapping:RKMVenue.entityMapping
                                                                                               method:RKRequestMethodGET
                                                                                          pathPattern:RESTAPI_VENUES_SEARCH_PATH
                                                                                              keyPath:@"response.venues"
                                                                                          statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:venueResponseDescriptor];
}


@end
