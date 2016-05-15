//
//  Location.m
//  Dude Where's my Car
//
//  Created by MBPinTheAir on 12/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "Location.h"

@interface Location()

@end

@implementation Location

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    CGPoint coords = CGPointMake(self.currentCoord.latitude, self.currentCoord.longitude);
    [aCoder encodeDouble:coords.x forKey:@"lat"];
    [aCoder encodeDouble:coords.y forKey:@"lon"];

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
       if (self = [super init]) {
           
           CLLocationCoordinate2D coordUnpacked;
           coordUnpacked.latitude = [aDecoder decodeDoubleForKey:@"lat"];// doubleValue];
           coordUnpacked.longitude = [aDecoder decodeDoubleForKey:@"lon"]; //doubleValue];
           self.savedParkingCoord = coordUnpacked;
           
       }
    
    return self;
}
@end
