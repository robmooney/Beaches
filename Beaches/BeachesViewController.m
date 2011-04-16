//
//  BeachesViewController.m
//  Beaches
//
//  Created by Robert Mooney on 14/04/2011.
//  Copyright 2011 Robert Mooney. All rights reserved.
//

#import "BeachesViewController.h"

@implementation BeachesViewController

@synthesize mapView;

- (void)dealloc
{
    [mapView release];
    [parser release];
    [currentBeach release];
    [currentBeachName release];
    [currentBeachLatitude release];
    [currentBeachLongitude release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    beaches = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSURL *beachesKMLFile = [[NSBundle mainBundle] URLForResource:@"Beaches" withExtension:@"kml"];
    
    parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfURL:beachesKMLFile]];
    
    [parser setDelegate:self];
    
    [parser parse];
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict {
    
    
    if ([elementName isEqualToString:@"Placemark"]) {
        
        currentBeach = [[Beach alloc] init];
    }
    
    
    if ([elementName isEqualToString:@"SimpleData"]) {
        NSString *name = [attributeDict objectForKey:@"name"];
        
        if ([name isEqualToString:@"NAME"]) {
            currentBeachName = [[NSMutableString alloc] initWithCapacity:0];
        }
        
        
        if ([name isEqualToString:@"LAT"]) {
            // longitude is stored as latitude in the KML file
            currentBeachLongitude = [[NSMutableString alloc] initWithCapacity:0];
        }
        
        
        if ([name isEqualToString:@"LONG"]) {
            // latitude is stored as longitude in the KML file
            currentBeachLatitude = [[NSMutableString alloc] initWithCapacity:0];
        }
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (currentBeachName) {
        [currentBeachName appendString:string];
    }
    
    if (currentBeachLatitude) {
        [currentBeachLatitude appendString:string];
    }
    
    if (currentBeachLongitude) {
        [currentBeachLongitude appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if (currentBeachName) {
        currentBeach.title = currentBeachName;
        
        [currentBeachName release];
        currentBeachName = nil;
    }
    
    if (currentBeachLatitude) {
        
        currentBeach.latitude = [currentBeachLatitude floatValue];
        
        [currentBeachLatitude release];
        currentBeachLatitude = nil;
    
    }
    
    if (currentBeachLongitude) {
        
        
        currentBeach.longitude = [currentBeachLongitude floatValue];
        
        [currentBeachLongitude release];
        currentBeachLongitude = nil;
    }
    
    if ([elementName isEqualToString:@"Placemark"]) {
        [beaches addObject:currentBeach];
        
        [currentBeach release];
        currentBeach = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"%@", beaches);
    
    [mapView setRegion:[self regionForAnnotations:beaches] animated:YES];
    
    [mapView addAnnotations:beaches];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *Identifier = @"Pin";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:Identifier];
    
    if (pin == nil) {
        pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:Identifier] autorelease];
        
        pin.canShowCallout = YES;
        pin.animatesDrop = YES;
    }
        
    return pin;    
}


- (MKCoordinateRegion)regionForAnnotations:(NSArray *)annotations {
    
    CLLocationDegrees minLat = 90.0;
    CLLocationDegrees maxLat = -90.0;
    CLLocationDegrees minLon = 180.0;
    CLLocationDegrees maxLon = -180.0;
    
    for (id <MKAnnotation> annotation in annotations) {
        if (annotation.coordinate.latitude < minLat) {
            minLat = annotation.coordinate.latitude;
        }		
        if (annotation.coordinate.longitude < minLon) {
            minLon = annotation.coordinate.longitude;
        }		
        if (annotation.coordinate.latitude > maxLat) {
            maxLat = annotation.coordinate.latitude;
        }		
        if (annotation.coordinate.longitude > maxLon) {
            maxLon = annotation.coordinate.longitude;
        }
    }
    
    
    MKCoordinateSpan span = MKCoordinateSpanMake(maxLat - minLat, maxLon - minLon);
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((maxLat - span.latitudeDelta / 2), maxLon - span.longitudeDelta / 2);
    
    return MKCoordinateRegionMake(center, span);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
