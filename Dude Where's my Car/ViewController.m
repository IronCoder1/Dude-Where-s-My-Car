//
//  ViewController.m
//  Dude Where's my Car
//
//  Created by MBPinTheAir on 12/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *locMgr;
@property (nonatomic, strong) MKPolylineView *lineView;
@property (nonatomic, strong) MKPolyline *polyline;
- (IBAction)helpDrop:(id)sender;
- (IBAction)findCar:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myLocation = [[Location alloc]init];
}


- (void)drawLineSubroutine {
    
    // remove polyline if one exists
    [self.mapView removeOverlay:self.polyline];
    
    // create an array of coordinates from allPins
//    CLLocationCoordinate2D coordinates[self.allPins.count];
//    int i = 0;
//    for (Pin *currentPin in self.allPins) {
//        coordinates[i] = currentPin.coordinate;
//        i++;
//    }
    
    // create a polyline with all cooridnates
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates: self.myLocation.currentCoord];
    [self.mapView addOverlay:polyline];
    self.polyline = polyline;
    
    // create an MKPolylineView and add it to the map view
    self.lineView = [[MKPolylineView alloc]initWithPolyline:self.polyline];
    self.lineView.strokeColor = [UIColor redColor];
    self.lineView.lineWidth = 5;
    
    // for a laugh: how many polylines are we drawing here?
    self.title = [[NSString alloc]initWithFormat:@"%lu", (unsigned long)self.mapView.overlays.count];
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    
    return self.lineView;
}


-(void)viewDidAppear:(BOOL)animated{
    
    self.locMgr = [[CLLocationManager alloc]init];
    [self.locMgr requestAlwaysAuthorization];
    _mapView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation{
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D currentCoords = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    
    self.myLocation.currentCoord = currentCoords;
    
}

- (IBAction)helpDrop:(id)sender {
    
    MKPointAnnotation *pinPoint = [[MKPointAnnotation alloc]init];
    
    pinPoint.coordinate = self.myLocation.currentCoord;
    
    pinPoint.title = @"Parked Here";

    [self.mapView addAnnotation:pinPoint];

    [self saveLoc];
}

- (IBAction)findCar:(id)sender {
    
    if (self.myLocation.currentCoord.latitude != self.myLocation.savedParkingCoord.latitude) {
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.myLocation.savedParkingCoord, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        [self loadLoc];
        
    } else{
        MKPointAnnotation *pinPoint = [[MKPointAnnotation alloc]init];
        
        pinPoint.coordinate = self.myLocation.currentCoord;
        
        pinPoint.title = @"Dude you are either sitting in your car or you happen to have beat the odds and parked your car on the same latitudinal line on the equator but find your longitude if you are not drrunk!!!!";
         
        [self.mapView addAnnotation:pinPoint];
    }
}

- (void)drawLine {
MKPolyline *polyline = [MKPolyline polylineWithCoordinates:self.myLocation.currentCoord count:2];
[self.mapView addOverlay:polyline];

// create an MKPolylineView and add it to the map view
self.lineView = [[MKPolylineView alloc]initWithPolyline:self.polyline];
self.lineView.strokeColor = [UIColor redColor];
self.lineView.lineWidth = 5;
    
}
-(NSURL*)applicationDocumentDirectory{
    
   //return
    NSArray *obj =  [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    return [obj lastObject];
    
}

-(void)saveLoc{
    
    NSString *thePath = [[self applicationDocumentDirectory].path stringByAppendingPathComponent:@"savedLocation"];
    
    NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:self.myLocation];
    [theData writeToFile:thePath atomically:YES];
    self.myLocation.savedParkingCoord =  self.myLocation.currentCoord;
    
    
}

-(void)loadLoc{
    
    NSString *thePath = [[self applicationDocumentDirectory].path stringByAppendingPathComponent:@"savedLocation"];
    NSData *myData = [NSData dataWithContentsOfFile:thePath];
    
    
    _myLocation = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    
}


@end
