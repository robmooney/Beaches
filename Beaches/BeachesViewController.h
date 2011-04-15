//
//  BeachesViewController.h
//  Beaches
//
//  Created by Robert Mooney on 14/04/2011.
//  Copyright 2011 Robert Mooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Beach.h"

@interface BeachesViewController : UIViewController <NSXMLParserDelegate, MKMapViewDelegate> {
@private
    NSMutableArray *beaches;
    
    
    NSXMLParser *parser;
    
    Beach *currentBeach;
    
    NSMutableString *currentBeachName;
    NSMutableString *currentBeachLatitude;
    NSMutableString *currentBeachLongitude;
    
    
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

- (MKCoordinateRegion)regionForAnnotations:(NSArray *)annotations;

@end
