//
//  Beach.m
//  Beaches
//
//  Created by Robert Mooney on 14/04/2011.
//  Copyright 2011 Robert Mooney. All rights reserved.
//

#import "Beach.h"

@implementation Beach 

@synthesize title;
@synthesize coordinate;
@synthesize latitude;
@synthesize longitude;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %f %f", title, latitude, longitude];
}

- (void)dealloc {
    [title release];
    [super dealloc];
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(latitude, longitude);
}

@end
