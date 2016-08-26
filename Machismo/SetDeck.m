//
//  SetDeck.m
//  Machismo
//
//  Created by Daniel Springer on 8/11/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck


//Sets up an array of card objects.  Each card has a shade, color, shape, and number
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *shape in [SetCard validShapes]) {
            for (NSString *color in [SetCard validColors]) {
                for (NSString *shade in [SetCard validShades]) {
                    for (NSNumber *number in [SetCard validNumbers]) {
                        
                        SetCard *card = [[SetCard alloc] init];
                        
                        card.shape = shape;
                        card.color = color;
                        card.shade = shade;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
        return self;
    
}
@end
