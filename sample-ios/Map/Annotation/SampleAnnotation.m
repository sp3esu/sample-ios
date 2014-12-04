//
// Created by gregor on 03.12.14.
// Copyright (c) 2014 gregor. All rights reserved.
//

#import "SampleAnnotation.h"

@interface SampleAnnotation()

@property(nonatomic, strong) NSDictionary *pointData;

@end

@implementation SampleAnnotation {

}

- (NSString *)title {
    return self.pointData[@"text"];
}

- (NSString *)imageUrlString {
    return self.pointData[@"image"];
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(
            [self.pointData[@"location"][@"latitude"] doubleValue],
            [self.pointData[@"location"][@"longitude"] doubleValue]
    );
}

- (instancetype)initWithDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.pointData = data;
    }

    return self;
}

@end
