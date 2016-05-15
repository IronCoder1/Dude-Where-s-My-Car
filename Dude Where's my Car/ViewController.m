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

- (IBAction)helpDrop:(id)sender;
- (IBAction)findCar:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myLocation = [[Location alloc]init];
}

-(void)viewDidAppear:(BOOL)animated{
    self.savedLocation = [[Location alloc]init];
    
   self.locMgr = [[CLLocationManager alloc]init];
    [self.locMgr requestAlwaysAuthorization];
    
    _mapView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//-(void)dropPin:(CLLocationCoordinate2D *)currentLocation{
//    MKPointAnnotation *pinPoint = [[MKPointAnnotation alloc]init];
//    
//    
//    [self.mapView addAnnotation:pinPoint];
//    
//   // pinPoint.coordinate = self.myLocation.currentCoord;
//    
//    
//}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation{
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D currentCoords = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    
    self.myLocation.currentCoord = currentCoords;
    
}

- (IBAction)helpDrop:(id)sender {
    
    MKPointAnnotation *pinPoint = [[MKPointAnnotation alloc]init];
    
    pinPoint.coordinate = self.myLocation.currentCoord;
    
    pinPoint.title = @"Park Car";

    
    [self.mapView addAnnotation:pinPoint];

    [self saveLoc];
}

- (IBAction)findCar:(id)sender {
    
    if (self.savedLocation != self.myLocation) {
    
    MKPointAnnotation *pinPoint = [[MKPointAnnotation alloc]init];
    
    pinPoint.coordinate = self.savedLocation.savedParkingCoord;
    
    pinPoint.title = @"Park Car";
    
    [self loadLoc];
    [self.mapView addAnnotation:pinPoint];
    } else{
        
       // [self helpDrop:nil];
    }
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
    self.savedLocation.savedParkingCoord =  self.savedLocation.currentCoord;
    
    
}

-(void)loadLoc{
    
    NSString *thePath = [[self applicationDocumentDirectory].path stringByAppendingPathComponent:@"savedLocation"];
    NSData *myData = [NSData dataWithContentsOfFile:thePath];
    
    
    _savedLocation = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    
}


@end
