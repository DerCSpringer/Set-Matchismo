//
//  Deck.h
//  Machismo
//
//  Created by Daniel Springer on 1/5/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;



@end
