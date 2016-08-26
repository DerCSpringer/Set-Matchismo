//
//  SetCard.m
//  Machismo
//
//  Created by Daniel Springer on 8/11/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize shape = _shape;
@synthesize color = _color;
@synthesize number = _number;
@synthesize shade = _shade;

- (int)match:(NSArray *)otherCards //checks to see if two match but the other card isn't one of the four attributes.  If it does it can't be a match.  If all cards are different or same in one catagory then that method returns one(a match).  If there is a two of a kind and one then it can't match.
{
    int score = 1;

    if (![self shadeCheck:otherCards])
    {
        NSLog(@"shade: %d", [self shadeCheck:otherCards]);
        return 0;
    }
    if (![self colorCheck:otherCards])
    {
        NSLog(@"color: %d", [self colorCheck:otherCards]);
        return 0;
    }
    if (![self numberCheck:otherCards])
    {
        NSLog(@"number: %d", [self numberCheck:otherCards]);
        return 0;
    }
    if (![self shapeCheck:otherCards])
    {
        NSLog(@"shape: %d", [self shapeCheck:otherCards]);
        return 0;
    }
    return score;
}
/*
- (NSString * )contents
{
    //return ["%@ %@ %@ %@", self.shadde, self.colodr, self.nudmber, self.sdape];
    //return (@"%@, %@, %@", self.shadde, self.codlor, self.shadde);
    NSString *this = [[NSString alloc] initWithString:(@"%@", self.shadde)];
    
    return this;
}
 */

//checks to see if all the shades are the same or all different.  Same for the other 3 methods below but they check their respective attributes.
- (int)shadeCheck:(NSArray *)otherCards
{
    SetCard *card1;
    SetCard *card2;
    
    if ([otherCards count]) {
        for (int i = 0; i < otherCards.count; i++) {
            for (int j = i + 1; j < otherCards.count; j++) {
                card1 = otherCards[i];
                card2 = otherCards[j];
                if ([card1 shade] == [card2 shade]) {
                    card1.matched = YES;
                    card2.matched = YES;
                }
            }
        }
        for (SetCard *otherCard in otherCards) {
            card1 = [otherCards firstObject];
            if (otherCard.matched != card1.matched) {[self unMatch:otherCards]; return 0;};
        }
    }
    [self unMatch:otherCards];
    return 1;
}

- (int)colorCheck:(NSArray *)otherCards
{
    SetCard *card1;
    SetCard *card2;
    
    if ([otherCards count]) {
        for (int i = 0; i < otherCards.count; i++) {
            for (int j = i + 1; j < otherCards.count; j++) {
                card1 = otherCards[i];
                card2 = otherCards[j];
                if ([card1 color] == [card2 color]) {
                    card1.matched = YES;
                    card2.matched = YES;
                }
            }
        }
        for (SetCard *otherCard in otherCards) {
            card1 = [otherCards firstObject];
            if (otherCard.matched != card1.matched) {[self unMatch:otherCards]; return 0;};
        }
    }
    [self unMatch:otherCards];
    return 1;
}

- (int)numberCheck:(NSArray *)otherCards
{
    SetCard *card1;
    SetCard *card2;
    
    if ([otherCards count]) {
        for (int i = 0; i < otherCards.count; i++) {
            for (int j = i + 1; j < otherCards.count; j++) {
                card1 = otherCards[i];
                card2 = otherCards[j];
                if ([card1 number] == [card2 number]) {
                    card1.matched = YES;
                    card2.matched = YES;
                }
            }
        }
        for (SetCard *otherCard in otherCards) {
            card1 = [otherCards firstObject];
            if (otherCard.matched != card1.matched) {[self unMatch:otherCards]; return 0;};
        }
    }
    [self unMatch:otherCards];
    return 1;
}

-(void)unMatch:(NSArray *)otherCards
{
    for (SetCard *card in otherCards) {
        card.matched = NO;
    }
}

- (int)shapeCheck:(NSArray *)otherCards
{
    SetCard *card1;
    SetCard *card2;
    
    if ([otherCards count]) {
        for (int i = 0; i < otherCards.count; i++) {
            for (int j = i + 1; j < otherCards.count; j++) {
                card1 = otherCards[i];
                card2 = otherCards[j];
                if ([card1 shape] == [card2 shape]) {
                    card1.matched = YES;
                    card2.matched = YES;
                }
            }
        }
        for (SetCard *otherCard in otherCards) {
            card1 = [otherCards firstObject];
            if (otherCard.matched != card1.matched) return 0;
        }
    }
    for (SetCard *card in otherCards) {
        card.matched = YES;
    }
    return 1;
}

+ (NSArray *)validShapes
{
    return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)validColors
{
    return @[@"purple", @"red", @"green"];
}

+ (NSArray *)validNumbers
{
    return @[@1, @2, @3];
}

+ (NSArray *)validShades
{
    //The "" is just the default font which is solid.  It makes it easier for the dictionary
    return @[@"empty", @"shaded", @"solid"];
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setNumber:(NSNumber *)number
{

    if([[SetCard validNumbers] containsObject:number]) {
        _number = number;
    }
}

- (void)setShade:(NSString *)shade
{
    if([[SetCard validShades] containsObject:shade]) {
        _shade = shade;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (NSNumber *)number
{
    return _number ? _number : @-1;
}

- (NSString *)shade
{
    return _shade ? _shade : @"?";
}


@end
