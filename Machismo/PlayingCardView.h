//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Daniel Springer on 10/17/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
