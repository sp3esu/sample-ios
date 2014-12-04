//
// Created by gregor on 03.12.14.
// Copyright (c) 2014 gregor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface SampleAnnotation : NSObject <MKAnnotation>

@property(nonatomic, readonly) NSString *imageUrlString;

- (instancetype)initWithDictionary:(NSDictionary *)data;

@end
