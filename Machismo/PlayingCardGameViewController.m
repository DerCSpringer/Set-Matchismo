//
//  PlayingCardGameViewController.m
//  Machismo
//
//  Created by Daniel Springer on 7/8/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"
@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController


- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (UIView *)createViewForCard:(Card *)card
{
    PlayingCardView *view = [[PlayingCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    
    //Uses my previous implementation to make a regular card into a cardview
    if (![card isKindOfClass:[PlayingCard class]]) return;
    if (![view isKindOfClass:[PlayingCardView class]]) return;
    
    PlayingCard *playingCard = (PlayingCard *)card;
    PlayingCardView *playingCardView = (PlayingCardView *)view;
    playingCardView.suit = playingCard.suit;
    playingCardView.rank = playingCard.rank;
    
    if (playingCardView.faceUp != playingCard.chosen) {
        [UIView transitionWithView:view
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:nil
                        completion:nil];
    

    }
    playingCardView.faceUp = playingCard.chosen;

}

- (void)updateUI
{
    [super updateUI];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberOfStartingCards = 12;
    self.maxCardSize = CGSizeMake(80.0, 120.0);
    [self updateUI];
}




@end
