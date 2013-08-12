//
//  LocationGetter.h
//  Created by Bob de Graaf on 01-10-10.
//  Copyright GraafICT 2010. All rights reserved.

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationGetterDelegate <NSObject>
-(void)locationFail;
-(void)locationGPSOff;
-(void)locationNotAllowed;
-(void)locationUpdated:(CLLocation *)location;
-(void)locationDidChangeAuthorizationStatus:(CLAuthorizationStatus)status;
@end

@interface LocationGetter : NSObject <CLLocationManagerDelegate>
{
    CLLocation *gpsLoc;
    CLLocationManager *locationManager;
}

-(void)updateLocation;

@property(nonatomic) float minHorizontalAccuracy;
@property(nonatomic) bool stopUpdatingImmediately;
@property(nonatomic,assign) id<LocationGetterDelegate> delegate;

@property(nonatomic,retain) CLLocation *gpsLoc;
@property(nonatomic,retain) CLLocationManager *locationManager;

+(LocationGetter *)sharedLocationGetter;

@end