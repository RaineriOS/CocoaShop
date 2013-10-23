//
//  RKMVenue+mapping.m
//  CocoaShop
//
//  Created by user on 17.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "RKMVenue+mapping.h"
#import "RKMLocation+mapping.h"

@implementation RKMVenue (mapping)

+ (RKEntityMapping*)entityMapping
{
    RKManagedObjectStore *managedObjectStore=RKObjectManager.sharedManager.managedObjectStore;
    RKEntityMapping* entityMapping = [RKEntityMapping
                                      mappingForEntityForName:NSStringFromClass(self.class)
                                      inManagedObjectStore:managedObjectStore];
    
    entityMapping.identificationAttributes = @[@"ident"] ;
    [entityMapping addAttributeMappingsFromDictionary:self.class.mappingDictionary];
    
    //relationship property mapping
    RKRelationshipMapping *locationMapping =[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:RKMLocation.entityMapping];
    [entityMapping addPropertyMapping:locationMapping];
    
    return entityMapping;
}




+(NSDictionary*)mappingDictionary
{
    NSDictionary *mappingDictionary=@{
                                      @"id":                                    @"ident",
                                      @"name":                                  @"name",
                                      
                                      //here implemented subobject 'stats' in 'Venue' object
                                      //only for study purposes
                                      //in real project try to reproduce server objects relationsships
                                      @"stats.checkinsCount":                   @"checkinsCount",
                                      @"stats.usersCount":                      @"usersCount",
                                      
                                      //here implemented one of metadata params of RestKit
                                      @"@metadata.mapping.collectionIndex":     @"order",
                                      };
    
    return mappingDictionary;
}

@end
