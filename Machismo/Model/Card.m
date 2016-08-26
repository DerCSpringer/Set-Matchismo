//
//  Card.m
//  Machismo
//
//  Created by Daniel Springer on 1/5/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
            //Change score = 1 to something else for multiple cards
        }
    }
    return score;
}
@end
