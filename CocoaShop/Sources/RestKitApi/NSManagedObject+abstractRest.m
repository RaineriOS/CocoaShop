//
//  NSManagedObject+abstractRest.m
//  Scanradar
//
//  Created by user on 14.04.13.
//  Copyright (c) 2013 Scanradar. All rights reserved.
//

#import "NSManagedObject+abstractRest.h"
//#import "NSError+RKError.h"

@implementation NSObject (abstractRest)


+(void)getManagedObjectsAtResourcePath:(NSString*)resourcePath
                    finishBlock:(void (^)(id object, NSDictionary *response))finishBlock
                     errorBlock:(void(^)(NSError*))errorBlock
{
    [[self class] loadManagedObjectsAtResourcePath:resourcePath
                                            method:RKRequestMethodGET
                                            params:nil
                               responseDescriptors:RKObjectManager.sharedManager.responseDescriptors
                                       finishBlock:^(id object, NSDictionary *response)
    {
        finishBlock(object,response);
    }
                                        errorBlock:errorBlock];
}

+(void)getManagedObjectsAtResourcePath:(NSString*)resourcePath
                                params:(NSDictionary*)params
                           finishBlock:(void (^)(id))finishBlock
                            errorBlock:(void(^)(NSError*))errorBlock
{
    [[self class] loadManagedObjectsAtResourcePath:resourcePath method:RKRequestMethodGET params:params responseDescriptors:RKObjectManager.sharedManager.responseDescriptors finishBlock:^(id object, NSDictionary *response)
     {
         finishBlock(object);
     } errorBlock:errorBlock];
}


+(void)getManagedObjectsAtResourcePath:(NSString*)resourcePath
                                params:(NSDictionary*)params
                   responseDescriptors:(NSArray*)responseDescriptors
                           finishBlock:(void (^)(id object, NSDictionary *response))finishBlock
                            errorBlock:(void(^)(NSError*))errorBlock
{
    [[self class] loadManagedObjectsAtResourcePath:resourcePath
                                            method:RKRequestMethodGET
                                            params:params
                               responseDescriptors:responseDescriptors
                                       finishBlock:^(id object, NSDictionary *response)
     {
         finishBlock(object,response);
     }
                                        errorBlock:errorBlock];
}


#pragma mark - POST methods -

+(void)postManagedObjectsAtResourcePath:(NSString*)resourcePath
                     finishBlock:(void (^)(id))finishBlock
                      errorBlock:(void(^)(NSError*))errorBlock;
{
    [[self class] loadManagedObjectsAtResourcePath:resourcePath
                                            method:RKRequestMethodPOST
                                            params:nil
                               responseDescriptors:RKObjectManager.sharedManager.responseDescriptors
                                       finishBlock:^(id object, NSDictionary *response)
     {
         finishBlock(object);
     }
                                        errorBlock:errorBlock];
}

+(void)postManagedObjectsAtResourcePath:(NSString*)resourcePath
                          params:(NSDictionary*)params
                     finishBlock:(void (^)(id))finishBlock
                      errorBlock:(void(^)(NSError*))errorBlock
{
    [[self class] loadManagedObjectsAtResourcePath:resourcePath
                                            method:RKRequestMethodPOST
                                            params:params
                               responseDescriptors:RKObjectManager.sharedManager.responseDescriptors
                                       finishBlock:^(id object, NSDictionary *response)
     {
         finishBlock(object);
     }
                                        errorBlock:errorBlock];
}


#pragma mark - BASE method -

+(void)loadManagedObjectsAtResourcePath:(NSString*)resourcePath
                                 method:(RKRequestMethod)requestMethod
                                 params:(NSDictionary*)params
                    responseDescriptors:(NSArray *)responseDescriptors
                            finishBlock:(void (^)(id object,NSDictionary *response))finishBlock
                             errorBlock:(void(^)(NSError*))errorBlock
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSMutableURLRequest *request = [objectManager requestWithObject:nil
                                                       method:requestMethod
                                                         path:resourcePath
                                                   parameters:params];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;

    RKHTTPRequestOperation *requestOperation=[[RKHTTPRequestOperation alloc] initWithRequest:request];

    RKManagedObjectRequestOperation *managedObjectRequestOperation = [[RKManagedObjectRequestOperation alloc] initWithHTTPRequestOperation:requestOperation responseDescriptors:responseDescriptors];
    
    managedObjectRequestOperation.targetObject=nil;
    managedObjectRequestOperation.managedObjectContext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    managedObjectRequestOperation.managedObjectCache = [RKManagedObjectStore defaultStore].managedObjectCache;
    
    [managedObjectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation,RKMappingResult *mappingResult)
     {
         NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:operation.HTTPRequestOperation.responseData options:0 error:nil];

         //DLog(@"Loaded: %@ COUNT %d", mappingResult.array,mappingResult.array.count);
         if (finishBlock)
             finishBlock(mappingResult.array,responseDictionary);
     }
                                                  failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         //NSError *operationError=[error rkError] ? [[error rkError] standartError] : error;
         //DLog(@"Operation failed with error: %@", [error rkError] ? [error rkError] : error);
         if (errorBlock)
            errorBlock(error);
     }];
    
    [objectManager enqueueObjectRequestOperation:managedObjectRequestOperation];
}












@end
