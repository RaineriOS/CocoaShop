//
//  RPLRestManager+setupMappings.m
//  
//
//  Created by user on 16.05.13.
//  Copyright (c) 2013 Novarate. All rights reserved.
//

#import "RPLRestManager+setupMappings.h"
//#import "RKError.h"
//#import "RKMUser+mapping.h"
//#import "RKMUser+apiRequests.h"
//#import "RKMEvent+mapping.h"
//#import "RKMEvent+apiRequests.h"
//#import "RKMContact+mapping.h"
//#import "RKMContact+apiRequests.h"

@implementation RPLRestManager (setupMappings)





+(void)_setupMappings
{
    /*
    //RKObjectManager *objectManager = [RKObjectManager sharedManager];

    RKResponseDescriptor *errorResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKError mapping]
                                                                                            pathPattern:nil
                                                                                                keyPath:@"error"
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    [objectManager addResponseDescriptor:errorResponseDescriptor];
    */
    /*
    RKResponseDescriptor *userResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKUser mapping]
                                                                                                 method:RKRequestMethodGET
                                                                                            pathPattern:RESTAPI_PROFILE_PATH
                                                                                                keyPath:nil
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:userResponseDescriptor];
    */
    
/*
    RKResponseDescriptor *eventResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKEvent mapping]
                                                                                                 method:RKRequestMethodGET
                                                                                            pathPattern:nil
                                                                                                keyPath:@"belongs"
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    [objectManager addResponseDescriptor:eventResponseDescriptor];
*/
    
    
    /*
    RKResponseDescriptor *offerResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKOffer mapping]
                                                                                            pathPattern:nil
                                                                                                keyPath:@"offer"
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:offerResponseDescriptor];
    
    RKResponseDescriptor *taskResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKTask mapping]
                                                                                           pathPattern:nil
                                                                                               keyPath:@"task"
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:taskResponseDescriptor];
    
    
    RKResponseDescriptor *userResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKUser mapping]
                                                                                           pathPattern:nil
                                                                                               keyPath:@"user"
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:userResponseDescriptor];
    RKResponseDescriptor *usersResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKUser mapping]
                                                                                            pathPattern:nil
                                                                                                keyPath:@"users"
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:usersResponseDescriptor];
    
    
    RKResponseDescriptor *botsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKBot mapping]
                                                                                           pathPattern:nil
                                                                                               keyPath:@"bots"
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:botsResponseDescriptor];
    
    RKResponseDescriptor *cityResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKCity mapping]
                                                                                           pathPattern:nil
                                                                                               keyPath:@"cities"
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:cityResponseDescriptor];
    
    RKResponseDescriptor *executorRequestResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKExecutorRequest mapping]
                                                                                                      pathPattern:nil
                                                                                                          keyPath:@"executor_request"
                                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:executorRequestResponseDescriptor];
    
    RKResponseDescriptor *customerRequestResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKCustomerRequest mapping]
                                                                                                      pathPattern:nil
                                                                                                          keyPath:@"customer_request"
                                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:customerRequestResponseDescriptor];
    
    RKResponseDescriptor *commentRequestResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKComment mapping]
                                                                                                     pathPattern:nil
                                                                                                         keyPath:@"comment"
                                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:commentRequestResponseDescriptor];
    
    
    
    
    //serialization
    RKRequestDescriptor *userRequestDescriptor=[RKRequestDescriptor requestDescriptorWithMapping:[RKUser serializationMapping]
                                                                                     objectClass:[RKUser class]
                                                                                     rootKeyPath:@"user"];
    [objectManager addRequestDescriptor:userRequestDescriptor];
    
    RKRequestDescriptor *taskRequestDescriptor=[RKRequestDescriptor requestDescriptorWithMapping:[RKTask serializationMapping]
                                                                                     objectClass:[RKTask class]
                                                                                     rootKeyPath:@"task"];
    [objectManager addRequestDescriptor:taskRequestDescriptor];
    
    RKRequestDescriptor *offerRequestDescriptor=[RKRequestDescriptor requestDescriptorWithMapping:[RKOffer serializationMapping]
                                                                                      objectClass:[RKOffer class]
                                                                                      rootKeyPath:@"offer"];
    [objectManager addRequestDescriptor:offerRequestDescriptor];
    
    RKRequestDescriptor *executorRequestRequestDescriptor=[RKRequestDescriptor requestDescriptorWithMapping:[RKExecutorRequest serializationMapping]
                                                                                                objectClass:[RKExecutorRequest class]
                                                                                                rootKeyPath:@"executor_request"];
    [objectManager addRequestDescriptor:executorRequestRequestDescriptor];
    
    RKRequestDescriptor *offerOrderRequestDescriptor=[RKRequestDescriptor requestDescriptorWithMapping:[RKOfferOrder serializationMapping]
                                                                                           objectClass:[RKOfferOrder class]
                                                                                           rootKeyPath:@"order"];
    [objectManager addRequestDescriptor:offerOrderRequestDescriptor];
    
    RKRequestDescriptor *commentRequestDescriptor=[RKRequestDescriptor requestDescriptorWithMapping:[RKComment serializationMapping]
                                                                                        objectClass:[RKComment class]
                                                                                        rootKeyPath:@"comment"];
    [objectManager addRequestDescriptor:commentRequestDescriptor];
    */
    /*
     RKRequestDescriptor *authenticationRequestDescriptor=[RKRequestDescriptor requestDescriptorWithMapping:[RKAuthentication serializationMapping]
     objectClass:[RKAuthentication class]
     rootKeyPath:nil];
     [objectManager addRequestDescriptor:authenticationRequestDescriptor];
     */
    /*
    RKRequestDescriptor *userContainerRequestDescriptor=[RKRequestDescriptor requestDescriptorWithMapping:[RKUserContainer serializationMapping]
                                                                                              objectClass:[RKUserContainer class]
                                                                                              rootKeyPath:nil];
    [objectManager addRequestDescriptor:userContainerRequestDescriptor];
    */
}




+ (void)_setupManagedMapping
{
    /*
     RKManagedObjectMapping *offerManagedMapping = [RKMOffer mapping];
     offerManagedMapping.rootKeyPath=@"offers";
     [mappingProvider addObjectMapping:offerManagedMapping];
     [mappingProvider setObjectMapping:offerManagedMapping forResourcePathPattern:RESTAPI_OFFERS_PATH];
     [mappingProvider setObjectMapping:offerManagedMapping forResourcePathPattern:RESTAPI_FIRST_PAGE_OFFERS_PATH];
     [mappingProvider setObjectMapping:offerManagedMapping forResourcePathPattern:RESTAPI_OFFERS_BYID_PATH];
     [mappingProvider setObjectMapping:offerManagedMapping forResourcePathPattern:RESTAPI_OFFERS_SEARCH_PATH];
     */
    
    //RKObjectManager *objectManager = RKObjectManager.sharedManager;
  
    /*
    RKResponseDescriptor *userResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:RKMUser.entityMapping
                                                                                                method:RKRequestMethodGET
                                                                                           pathPattern:RESTAPI_PROFILE_PATH
                                                                                               keyPath:nil
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:userResponseDescriptor];
    */
/*
    RKResponseDescriptor *contactResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:RKMContact.entityMapping
                                                                                                 method:RKRequestMethodGET
                                                                                            pathPattern:RESTAPI_CONTACTS_PATH
                                                                                                keyPath:@"user"
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:contactResponseDescriptor];
*/
    /*
    RKResponseDescriptor *offersResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKMOffer entityMapping]
                                                                                             pathPattern:nil
                                                                                                 keyPath:@"offers"
                                                                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:offersResponseDescriptor];
    
    RKResponseDescriptor *tasksResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKMTask entityMapping]
                                                                                            pathPattern:nil
                                                                                                keyPath:@"tasks"
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:tasksResponseDescriptor];
    
    RKResponseDescriptor *categoriesResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[RKMCategory entityMapping]
                                                                                                 pathPattern:nil
                                                                                                     keyPath:@"categories"
                                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:categoriesResponseDescriptor];
    */
}


@end
