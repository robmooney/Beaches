//
//  Beach.h
//  Beaches
//
//  Created by Robert Mooney on 14/04/2011.
//  Copyright 2011 Robert Mooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Beach : NSObject <MKAnnotation> {
    
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;

@end
