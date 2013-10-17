//
//  RKMVenue+apiRequests.m
//  CocoaShop
//
//  Created by user on 17.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "RKMVenue+apiRequests.h"
#import "NSManagedObject+abstractRest.h"
#import "RKMVenue+mapping.h"

@implementation RKMVenue (apiRequests)

#define RESTAPI_VENUES_SEARCH_PATH      @"venues/search"

+(void)venuesFromCoordinate:(CLLocationCoordinate2D)coordinate finishBlock:(void (^)(NSArray *objects,NSDictionary *responseDictionary))finishBlock errorBlock:(void(^)(NSError *error))errorBlock
{
    NSString *resourcePath=RESTAPI_VENUES_SEARCH_PATH;//[RESTAPI_USER_PROFILE_PATH stringByAppendingFormat:@"login-%@",self.login];
    
    NSDictionary *params=@{@"client_id":        FOURSQUARE_CLIENT_ID,
                           @"client_secret":    FOURSQUARE_CLIENT_SECRET,
                           @"ll":               [NSString stringWithFormat:@"%f,%f",coordinate.latitude,coordinate.longitude],
                           @"query":            @"суши",
                           @"v":                @"20130815",
                           };
    
    RKResponseDescriptor *responseDescriptor=[RKResponseDescriptor responseDescriptorWithMapping:RKMVenue.entityMapping
                                                                                          method:RKRequestMethodGET
                                                                                     pathPattern:resourcePath
                                                                                         keyPath:@"response.venues"
                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    responseDescriptor.baseURL = RKObjectManager.sharedManager.baseURL;
    
    [self.class getManagedObjectsAtResourcePath:resourcePath
                                         params:params
                            responseDescriptors:@[responseDescriptor]
                                    finishBlock:^(NSArray *objects, NSDictionary *response)
     {
         //RKMUser *user=objects.lastObject;
         NSLog(@"OBJECTS %d",objects.count);
         NSLog(@"");
         /*
          for (RKMScheduleItem *scheduleItem in event.schedule.allObjects)
          {
          //scheduleItem.ident=scheduleItem.scheduleIdent;
          DLog(@"ITEM %@",scheduleItem);
          DLog(@"DETAILS %@ CNT %d",scheduleItem.details.allObjects,scheduleItem.details.allObjects.count);
          DLog(@"");
          }
          
          [self.managedObjectContext MR_saveToPersistentStoreAndWait];
          */
         finishBlock(objects,response);
         
     } errorBlock:errorBlock];

}

@end
