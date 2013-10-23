//
//  RKMLocation+mapping.m
//  CocoaShop
//
//  Created by user on 20.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "RKMLocation+mapping.h"

@implementation RKMLocation (mapping)

+ (RKEntityMapping*)entityMapping
{
    RKManagedObjectStore *managedObjectStore=RKObjectManager.sharedManager.managedObjectStore;
    RKEntityMapping* entityMapping = [RKEntityMapping
                                      mappingForEntityForName:NSStringFromClass(self.class)
                                      inManagedObjectStore:managedObjectStore];
    
    [entityMapping addAttributeMappingsFromDictionary:self.class.mappingDictionary];
    return entityMapping;
}




+(NSDictionary*)mappingDictionary
{
    NSDictionary *mappingDictionary=@{
                                      @"address":       @"address",
                                      @"cc":            @"cc",
                                      @"city":          @"city",
                                      @"country":       @"country",
                                      @"distance":      @"distance",
                                      @"lat":           @"lat",
                                      @"lng":           @"lng",
                                      @"postalCode":    @"postalCode",
                                      @"state":         @"state",
                                      };
    
    return mappingDictionary;
}

@end
