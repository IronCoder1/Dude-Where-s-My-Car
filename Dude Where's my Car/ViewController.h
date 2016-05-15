//
//  ViewController.h
//  Dude Where's my Car
//
//  Created by MBPinTheAir on 12/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Location.h"


@interface ViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@property (strong, nonatomic) Location  *myLocation;

@property (strong, nonatomic) Location *savedLocation;


@end

