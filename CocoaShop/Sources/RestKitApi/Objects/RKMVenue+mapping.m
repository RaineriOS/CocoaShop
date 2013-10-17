//
//  RKMVenue+mapping.m
//  CocoaShop
//
//  Created by user on 17.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "RKMVenue+mapping.h"

@implementation RKMVenue (mapping)

+ (RKEntityMapping*)entityMapping
{
    RKManagedObjectStore *managedObjectStore=RKObjectManager.sharedManager.managedObjectStore;
    RKEntityMapping* entityMapping = [RKEntityMapping
                                      mappingForEntityForName:NSStringFromClass(self.class)
                                      inManagedObjectStore:managedObjectStore];
    
    entityMapping.identificationAttributes = @[@"ident"] ;
    [entityMapping addAttributeMappingsFromDictionary:self.class.mappingDictionary];
    
    //RKRelationshipMapping *eventMapping =[RKRelationshipMapping relationshipMappingFromKeyPath:@"belongs" toKeyPath:@"events" withMapping:[RKMEvent entityMapping]];
    //[entityMapping addPropertyMapping:eventMapping];
    
    return entityMapping;
}




+(NSDictionary*)mappingDictionary
{
    NSDictionary *mappingDictionary=@{
                                      @"id":                @"ident",
                                      @"name":              @"name",
                                      };
    
    return mappingDictionary;
}

@end
