//
// Created by gregor on 03.12.14.
// Copyright (c) 2014 gregor. All rights reserved.
//

#import "SampleMapView.h"


@implementation SampleMapView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }

    return self;
}


- (void)setUp {
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.showsUserLocation = YES;

    [self addSubview:self.mapView];
}

@end
