//
// Created by gregor on 03.12.14.
// Copyright (c) 2014 gregor. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "SampleMapViewController.h"
#import "SampleMapView.h"
#import "AFHTTPRequestOperationManager.h"
#import "SampleAnnotationView.h"
#import "SampleAnnotation.h"

@interface  SampleMapViewController() <MKMapViewDelegate>

@property(nonatomic, strong) SampleMapView *sampleMapView;
@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation SampleMapViewController {

}

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];

        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }

    return self;
}

#pragma mark -

- (void)loadView {
    self.sampleMapView = [[SampleMapView alloc] initWithFrame:CGRectZero];
    self.sampleMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.sampleMapView.mapView.delegate = self;
    self.view = self.sampleMapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    // Dropbox will return: "Content-Type" = "text/plain; charset=utf-8" for this JSON file
    // So we need to add "text/plain" as valid one
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];

    [manager GET:@"https://dl.dropboxusercontent.com/u/6556265/test.json" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *responseKeys = [responseObject allKeys];
        if ([responseKeys containsObject:@"location"] && [responseKeys containsObject:@"text"] && [responseKeys containsObject:@"image"]) {
            [self addPoint:responseObject];
        }
        else {
            [self displayError:@"API Error"];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self displayError:@"API request error."];
    }];

}

- (void)displayError:(NSString *)errorMessage {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)addPoint:(NSDictionary *)pointData {
    SampleAnnotation *point = [[SampleAnnotation alloc] initWithDictionary:pointData];
    [self.sampleMapView.mapView addAnnotation:point];
}

#pragma mark -

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion userRegion;
    userRegion.center = userLocation.coordinate;
    userRegion.span.latitudeDelta = 0.5;
    userRegion.span.longitudeDelta = 0.5;
    [mapView setRegion:userRegion animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[SampleAnnotation class]]) {
        SampleAnnotationView *pinAnnotationView = [[SampleAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([SampleAnnotationView class])];
        return pinAnnotationView;
    }

    return nil;
}

@end
