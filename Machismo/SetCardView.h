//
//  SetCardView.h
//  Machismo
//
//  Created by Daniel Springer on 1/6/16.
//  Copyright (c) 2016 Daniel Springer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSNumber *number;
@property (nonatomic) BOOL chosen;

@end
