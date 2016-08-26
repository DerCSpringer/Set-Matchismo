//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Daniel Springer on 2/17/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "PlayingCard.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)drawNewCard;
- (Card *)lastCard;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger matchType;
@property (nonatomic, readonly) int lastScore;
@property (strong, nonatomic, readonly) NSMutableArray *lastCards;
@property (nonatomic, readonly) NSUInteger numberOfDealtCards;
@property (nonatomic)NSUInteger maxMatchingCards;




@end
