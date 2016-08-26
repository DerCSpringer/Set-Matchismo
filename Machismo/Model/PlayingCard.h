//
//  PlayingCard.h
//  Machismo
//
//  Created by Daniel Springer on 1/5/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
