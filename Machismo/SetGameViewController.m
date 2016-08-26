//
//  SetGameViewController.m
//  Machismo
//
//  Created by Daniel Springer on 8/4/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetDeck.h"
#import "SetCard.h"
#import "SetCardView.h"
#import "CardMatchingGame.h"


@interface SetGameViewController ()

@end

@implementation SetGameViewController



- (Deck *)createDeck
{
    return [[SetDeck alloc] init];
}

- (UIView *)createViewForCard:(Card *)card
{
    SetCardView *view = [[SetCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    if (!card.matched) {
        
    
    if (![card isKindOfClass:[SetCard class]]) return;
    if (![view isKindOfClass:[SetCardView class]]) return;
    
    SetCard *setCard = (SetCard *)card;
    SetCardView *setCardView = (SetCardView *)view;
    setCardView.color = setCard.color;
    setCardView.symbol = setCard.shape;
    setCardView.shading = setCard.shade;
    setCardView.number = setCard.number;
    setCardView.chosen = setCard.chosen;
    }
    
    
}

/*
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"setCardSelected" : @"cardfront"];
}
*/

- (void)updateUI
{
    [super updateUI];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberOfStartingCards = 12;
    self.maxCardSize = CGSizeMake(120.0, 120.0);
    [self updateUI];
}


@end
