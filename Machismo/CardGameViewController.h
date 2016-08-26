//
//  CardGameViewController.h
//  Machismo
//
//  Created by Daniel Springer on 12/27/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//
//Abstract class must implement methods as stated below
//YESsss

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface CardGameViewController : UIViewController
//Protected

@property (nonatomic) NSUInteger numberOfStartingCards;
@property (nonatomic) CGSize maxCardSize;



- (Deck *)createDeck; //Abstract
- (void)updateUI;

//test methods
- (UIView *)createViewForCard:(Card *)card;
- (void)updateView:(UIView *)view forCard:(Card *)card;
- (void)touchCard:(UITapGestureRecognizer *)gesture;



@end
