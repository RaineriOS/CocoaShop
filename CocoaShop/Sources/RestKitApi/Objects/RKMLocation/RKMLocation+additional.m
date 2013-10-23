//
//  RKMLocation+additional.m
//  CocoaShop
//
//  Created by user on 21.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "RKMLocation+additional.h"

@implementation RKMLocation (additional)

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake(self.lat.doubleValue, self.lng.doubleValue);
    return CLLocationCoordinate2DIsValid(coordinate) ? coordinate : CLLocationCoordinate2DMake(0.f, 0.f);
}

@end
