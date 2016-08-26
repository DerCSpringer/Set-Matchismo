//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Daniel Springer on 2/17/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of cards
@property (nonatomic, strong) NSMutableArray *pickedCards;
@property (nonatomic, readwrite) NSMutableString *cardsInResultsString;
@property (nonatomic, readwrite) int lastScore;
@property (strong, nonatomic, readwrite) NSMutableArray *lastCards;
@property (strong, nonatomic) NSMutableArray *removalArray;
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)removalArray
{
    if (!_removalArray) _removalArray = [[NSMutableArray alloc] init];
    return _removalArray;
}



- (NSMutableArray *)pickedCards
{
    if (!_pickedCards) _pickedCards = [[NSMutableArray alloc] init];
    return _pickedCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; //Super's designated initializer
    _deck = deck;
    
    if (self)
    {
        //draws the number of cards for the count passed
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card) {
            [self.cards addObject:card];
        
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)lastCard
{
    return [self.cards lastObject];
}

- (void)drawNewCard
{
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
        }
}

- (NSUInteger)numberOfDealtCards {
    return [self.cards count];
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;






- (void)chooseCardAtIndex:(NSUInteger)index

//********************Select 2 unselect 2 then select on in set game gives mutation error
{
    int cardsMatched = 3;
    self.lastScore = 0;
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched)
    {
        if (card.isChosen) { //switches card over if it is chosen
            card.chosen = NO;
            [self cleanUp];
        } else {
            card.chosen = YES;
            // Match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched && ![self.pickedCards containsObject:otherCard]) { //besides teh obvious makes sure that picked cards doesnt't already contain the card you've chosen
                    [self.pickedCards addObject:otherCard];
                    // add cards to picked cards. delete after 3 cards
                    //if ([self.pickedCards count] == (2 + self.matchType)) {
                    //Above statement is for 2 or 3 card matching in CardMatchingGame
                      if ([self.pickedCards count] == (cardsMatched)) {
                        int matchScore = [card match:self.pickedCards];
                          // if you have 2 + matchType number of cards you've chosen then it sees if they have matched
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            /* Old and wrong. violated MVC.  Moved to controller
                            self.cardsInResultsString = [NSMutableString stringWithFormat:@"Matched "];
                            for (PlayingCard *possibleMatch in self.pickedCards) {
                                if (possibleMatch.isMatched) {
                                    [self.cardsInResultsString appendString:[NSString stringWithFormat:@"%@", possibleMatch.contents]];
                                }
                             
                            
                            }
                             */
 
                            self.lastCards = self.pickedCards;
                            self.lastScore = matchScore * MATCH_BONUS;
                            [self unChooseCards];//removes cards from the array pickedcards
                        } else {
                            //self.lastScore = matchScore;
                            self.lastCards = self.pickedCards;
                            //self.cardsInResultsString = nil;
                            /* Old and Wrong.  violated MVC moved to controller
                            for (PlayingCard *possibleMatch in self.pickedCards) {
                            [self.cardsInResultsString appendString:[NSString stringWithFormat:@"%@", possibleMatch.contents]];
                            }
                            [self.cardsInResultsString appendString:[NSString stringWithFormat:@" don't match! %d point penalty!", MISMATCH_PENALTY]];
                             */
 
                            self.score -= MISMATCH_PENALTY;
                            self.lastScore -= MISMATCH_PENALTY;
                            [self unChooseCards];
                        }
                    //break;
                    }
                }


        }
        self.score -= COST_TO_CHOOSE;
    }
    }

}
 


- (void)cleanUp
{
    
    for (Card *otherCard in self.pickedCards) {
        if (!otherCard.isChosen || otherCard.isMatched) {
            [self.pickedCards removeObject:otherCard];
        }
    }
     
}

- (void)unChooseCards
{
    for (Card *otherCard in self.pickedCards) {
        if (!otherCard.isMatched) {
            otherCard.chosen = NO;
        }

    }
    self.pickedCards = nil;
}
 



@end
