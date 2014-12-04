//
// Created by gregor on 03.12.14.
// Copyright (c) 2014 gregor. All rights reserved.
//

#import "SampleAnnotationView.h"
#import "SampleAnnotation.h"
#import "SampleCalloutView.h"

@interface SampleAnnotationView()

@property(nonatomic, strong) SampleCalloutView *calloutView;

@end

@implementation SampleAnnotationView {

}

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.pinColor = MKPinAnnotationColorRed;
        self.animatesDrop = YES;
        self.canShowCallout = NO;
    }

    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        SampleAnnotation *sampleAnnotation = (SampleAnnotation *)self.annotation;
        self.calloutView = [[SampleCalloutView alloc] initWithFrame:CGRectMake(0, 0, 160, 200)];
        self.calloutView.title = sampleAnnotation.title;
        self.calloutView.imageURL = [NSURL URLWithString:sampleAnnotation.imageUrlString];

        CGRect annotationViewBounds = self.bounds;
        CGRect calloutViewFrame = self.calloutView.frame;
        calloutViewFrame.origin.x = (CGFloat) (-(CGRectGetWidth(calloutViewFrame) - CGRectGetWidth(annotationViewBounds)) * 0.5);
        calloutViewFrame.origin.y = (CGFloat) (-CGRectGetHeight(calloutViewFrame) + 5.0);

        self.calloutView.frame = calloutViewFrame;
        [self addSubview:self.calloutView];
    }
    else {
        [self.calloutView removeFromSuperview];
        self.calloutView = nil;
    }
}

@end
