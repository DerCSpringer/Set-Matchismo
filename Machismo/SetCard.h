//
//  SetCard.h
//  Machismo
//
//  Created by Daniel Springer on 8/11/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *shade;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validNumbers;
+ (NSArray *)validShades;

@end
