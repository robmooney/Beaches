//
//  BeachesAppDelegate.h
//  Beaches
//
//  Created by Robert Mooney on 14/04/2011.
//  Copyright 2011 Robert Mooney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BeachesViewController;

@interface BeachesAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet BeachesViewController *viewController;

@end
