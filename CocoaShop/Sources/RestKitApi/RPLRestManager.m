//
//  SRRestManager.m
//  Scanradar
//
//  Created by Mihail Koltsov on 01.10.12.
//  Copyright (c) 2012 Scanradar. All rights reserved.
//

#import "RPLRestManager.h"
#import "RPLRestManagerDefines.h"
#import "RPLRestManager+setupMappings.h"

@interface RPLRestManager()
+(void)_setupDB;
+(void)_setupReachability;
+(void)_setupLogging;
@end

@implementation RPLRestManager


+(void)setupManager
{
    RKObjectManager *manager = RKObjectManager.sharedManager;
    
    if (!manager)
    {
        manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:RESTKIT_PROJECT_API_URL]];
        manager.requestSerializationMIMEType = RKMIMETypeJSON;
        [RKObjectManager setSharedManager:manager];
        AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    }
    
    //if coreData support needed
    {
        [RPLRestManager _setupDB];
        [RPLRestManager _setupManagedMapping];
    }

    [RPLRestManager _setupMappings];
    [RPLRestManager _setupReachability];
    [RPLRestManager _setupLogging];
}




#pragma mark - CD store -

+ (void)_setupDB
{
    // Configure RestKit's Core Data stack
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:RESTKIT_LOCALSTORAGE_NAME ofType:@"momd"]];
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:[RESTKIT_LOCALSTORAGE_NAME stringByAppendingString:@".sqlite"]];

    NSError *error = nil;
    RKObjectManager* objectManager = RKObjectManager.sharedManager;
    objectManager.managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    [objectManager.managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    // Create the managed object contexts
    [objectManager.managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    objectManager.managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:objectManager.managedObjectStore.persistentStoreManagedObjectContext];

    
    // Configure MagicalRecord to use RestKit's Core Data stack
    // if available
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    if ([NSPersistentStoreCoordinator.class respondsToSelector:@selector(MR_setDefaultStoreCoordinator:)])
    {
        [NSPersistentStoreCoordinator.class performSelector:@selector(MR_setDefaultStoreCoordinator:) withObject:objectManager.managedObjectStore.persistentStoreCoordinator];
    }
    
    if ([NSManagedObjectContext.class respondsToSelector:@selector(MR_setRootSavingContext:)])
    {
        [NSManagedObjectContext.class performSelector:@selector(MR_setRootSavingContext:) withObject:objectManager.managedObjectStore.persistentStoreManagedObjectContext];
    }

    if ([NSManagedObjectContext.class respondsToSelector:@selector(MR_setDefaultContext:)])
    {
        [NSManagedObjectContext.class performSelector:@selector(MR_setDefaultContext:) withObject:objectManager.managedObjectStore.mainQueueManagedObjectContext];
    }
#pragma clang diagnostic pop
}




#pragma mark -



+(void)_setupReachability
{
    //network reachability
    //RKObjectManager *manager = [RKObjectManager sharedManager];
    /*
     [manager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
     if (status == AFNetworkReachabilityStatusNotReachable) {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
     message:@"You must be connected to the internet to use this app."
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     }
     }];
     */
}


+(void)_setupLogging
{
    RKLogConfigureByName("RestKit/Network/CoreData", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/Network", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelWarning);
}



@end
