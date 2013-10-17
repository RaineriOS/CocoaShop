//
//  NSManagedObject+abstractRest.h
//  Scanradar
//
//  Created by user on 14.04.13.
//  Copyright (c) 2013 Scanradar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPLRestManager.h"

@interface NSManagedObject (abstractRest)

+(void)getManagedObjectsAtResourcePath:(NSString*)resourcePath
                           finishBlock:(void (^)(id object, NSDictionary *response))finishBlock
                            errorBlock:(void(^)(NSError*))errorBlock;

+(void)getManagedObjectsAtResourcePath:(NSString*)resourcePath
                                params:(NSDictionary*)params
                           finishBlock:(void (^)(id))finishBlock
                            errorBlock:(void(^)(NSError*))errorBlock;

+(void)getManagedObjectsAtResourcePath:(NSString*)resourcePath
                                params:(NSDictionary*)params
                   responseDescriptors:(NSArray*)responseDescriptors
                           finishBlock:(void (^)(id object, NSDictionary *response))finishBlock
                            errorBlock:(void(^)(NSError*))errorBlock;

+(void)postManagedObjectsAtResourcePath:(NSString*)resourcePath finishBlock:(void (^)(id))finishBlock errorBlock:(void(^)(NSError*))errorBlock;

+(void)postManagedObjectsAtResourcePath:(NSString*)resourcePath
                          params:(NSDictionary*)params
                     finishBlock:(void (^)(id))finishBlock
                      errorBlock:(void(^)(NSError*))errorBlock;

+(void)loadManagedObjectsAtResourcePath:(NSString*)resourcePath
                                 method:(RKRequestMethod)requestMethod
                                 params:(NSDictionary*)params
                    responseDescriptors:(NSArray *)responseDescriptors
                            finishBlock:(void (^)(id,NSDictionary *response))finishBlock
                             errorBlock:(void(^)(NSError*))errorBlock;

@end
