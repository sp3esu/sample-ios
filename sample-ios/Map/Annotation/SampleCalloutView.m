//
// Created by gregor on 04.12.14.
// Copyright (c) 2014 gregor. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "SampleCalloutView.h"

@interface SampleCalloutView()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation SampleCalloutView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.anchorPoint = CGPointMake(0.5, 1.0);
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.borderColor = [UIColor colorWithRed:0.890 green:0.875 blue:0.843 alpha:1.000].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;

        self.titleLabel = ({
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont systemFontOfSize:15.0];
            titleLabel.adjustsFontSizeToFitWidth = YES;
            titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            titleLabel;
        });
        [self addSubview:self.titleLabel];

        self.imageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView;
        });
        [self addSubview:self.imageView];


        NSDictionary *metrics = @{
                @"margin": @(5)
        };

        NSDictionary *views = @{
                @"titleLabel": self.titleLabel,
                @"imageView": self.imageView
        };

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[imageView]-[titleLabel(20)]-margin-|"
                                                                     options:(NSLayoutFormatOptions) 0
                                                                     metrics:metrics
                                                                       views:views
        ]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[imageView]-margin-|"
                                                                     options:(NSLayoutFormatOptions) 0
                                                                     metrics:metrics
                                                                       views:views
        ]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[titleLabel]-margin-|"
                                                                     options:(NSLayoutFormatOptions) 0
                                                                     metrics:metrics
                                                                       views:views
        ]];
    }

    return self;
}

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    [self.imageView setImageWithURL:self.imageURL];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = self.title;
}

@end
