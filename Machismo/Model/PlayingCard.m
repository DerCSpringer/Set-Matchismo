//
//  PlayingCard.m
//  Machismo
//
//  Created by Daniel Springer on 1/5/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    PlayingCard *card1;
    PlayingCard *card2;
    
    
    
    
    //***only works to match a single card
    
    if ([otherCards count]) {
        for (int i = 0; i < otherCards.count; i++) {
            for (int j = i + 1; j < otherCards.count; j++) {
                card1 = otherCards[i];
                card2 = otherCards[j];
                    if ([card1 rank] == [card2 rank]) {
                        card1.matched = YES;
                        card2.matched = YES;
                        score += 4;
                    }
                else if ([otherCards[i] suit] == [otherCards[j] suit]) {
                    card1.matched = YES;
                    card2.matched = YES;
                    score += 1;
                }
            }
        }
    }
    return score;
}



- (NSString * )contents
{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
             
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
         
+ (NSUInteger)maxRank {return [[self rankStrings] count] -1; }
         
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
         
@end
