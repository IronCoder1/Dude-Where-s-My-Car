//
//  Location.h
//  Dude Where's my Car
//
//  Created by MBPinTheAir on 12/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface Location : NSObject<NSCoding>

@property (assign, nonatomic) CLLocationCoordinate2D savedParkingCoord;
@property (assign, nonatomic) CLLocationCoordinate2D currentCoord;

@end
