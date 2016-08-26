//
//  CardGameViewController.m
//  Machismo
//
//  Created by Daniel Springer on 12/27/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "Grid.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (strong, nonatomic) NSMutableArray *usedCards;
@property (strong, nonatomic) NSMutableArray *cardViews;//array of all the views in UIView
@property (strong, nonatomic) NSMutableArray *cardsToRemove;
@property (strong, nonatomic) Grid *grid;
@property (strong, nonatomic) UIDynamicAnimator *cardPileAnimator;
@end

@implementation CardGameViewController


//I have an array of the views so I can just go through them check for matched and chosen and do that in model.  I'll add those cards to an array of matched cards so I can make them disappear or w/e.  I'll have an array there that I can make public.
//Make a method in here to animated removing the cards and adding the new cards from the deck in.
/*
 -(void)animateREmovingCards:(NSArray *)cardsToREmove
 {
    [UIView animatedWithDuration:1.0
                    animations:^{
                        for (UIView *card in cardsToREmove)
                        {
                            do animation
                        }
                    completion:^(BOOL finished) {
                        [cardsToRemove makeObjectsPerformSelector:@selector(removeFromtSuperview)]; 
                        maybe call a method which adds new cards
 }
 ]};
 
 
 }
 
*********How to animate cards***********
1. Set cards alpha to 0
2. How to move cards to new pos on board
 *We always should move cards so that bottom is empty. This way deal cards won't have a problem
    *How to detect cards and move them
    *We could make the cards at the bottom of the row move to the new locations which are blank.
 
 
 
 */
- (IBAction)moveCardsAround:(UIPanGestureRecognizer *)gesture {
    if (self.cardPileAnimator) {
        CGPoint gesturePoint = [gesture locationInView:self.gridView];
        if (gesture.state == UIGestureRecognizerStateBegan) {
            for (UIView *cardView in self.cardViews) {
                UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:cardView
                                                                             attachedToAnchor:gesturePoint];
                [self.cardPileAnimator addBehavior:attachment];
                //Adds an attachment to all cards in cardViews so they can all be moved together
            }
            for (UIDynamicBehavior *behavior in self.cardPileAnimator.behaviors) {
                if ([behavior isKindOfClass:[UISnapBehavior class]]) {
                    [self.cardPileAnimator removeBehavior:behavior];
                }
            }
        } else if (gesture.state == UIGestureRecognizerStateChanged) {
            for (UIDynamicBehavior *behavior in self.cardPileAnimator.behaviors) {
                if ([behavior isKindOfClass:[UIAttachmentBehavior class]]) {
                    ((UIAttachmentBehavior *)behavior).anchorPoint = gesturePoint;
                }
            }
        } else if (gesture.state == UIGestureRecognizerStateEnded) {
            for (UIDynamicBehavior *behavior in self.cardPileAnimator.behaviors) {
                if ([behavior isKindOfClass:[UIAttachmentBehavior class]]) {
                    [self.cardPileAnimator removeBehavior:behavior];
                }
            }
            for (UIView *cardView in self.cardViews) {
                UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:cardView snapToPoint:gesturePoint];
                [self.cardPileAnimator addBehavior:snap];
            }
        }
    }
}

#define SLOWDOWN_SPEED 90.0


- (IBAction)moveAllCardsToLocation:(UIPinchGestureRecognizer *)sender {
    
    if ((sender.state == UIGestureRecognizerStateChanged) ||
        (sender.state == UIGestureRecognizerStateEnded)) {
        if (!self.cardPileAnimator) { //Creates animator
            CGPoint center = [sender locationInView:self.gridView];
            //inits will all card views in the array on the grid view
            self.cardPileAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gridView];
            UIDynamicItemBehavior *cards = [[UIDynamicItemBehavior alloc] initWithItems:self.cardViews];
            //The pinch gesture seemed too fast so I had to slow it down a bit.
            cards.resistance = SLOWDOWN_SPEED;
            [self.cardPileAnimator addBehavior:cards];
            for (UIView *cardView in self.cardViews) {
                UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:cardView snapToPoint:center];
                [self.cardPileAnimator addBehavior:snap];
            }
        }
    }
    
}
- (IBAction)dealMore:(UIButton *)sender {
    for (int i = 0; i < 3; i++) {
        [self.game drawNewCard]; //Draws a card in the model
        Card *nextCard = [self.game lastCard];
        UIView *nextCardView = [self createViewForCard:nextCard];//Creates view for card from model
        nextCardView.tag = self.game.numberOfDealtCards - 1;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(touchCard:)];
        [nextCardView addGestureRecognizer:tap2];
        self.numberOfStartingCards += 1;
        [self.cardViews addObject:nextCardView];
        [self.gridView addSubview:nextCardView];
    }
    self.grid = nil;
    self.cardPileAnimator = nil;
    [self updateUI];


}

- (NSMutableArray *)cardsToRemove
{
    if (!_cardsToRemove) _cardsToRemove = [[NSMutableArray alloc] init];
    return _cardsToRemove;
}





- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [NSMutableArray arrayWithCapacity:self.numberOfStartingCards];
    return _cardViews;
}


- (NSMutableArray *) usedCards
{
    if (!_usedCards) _usedCards = [[NSMutableArray alloc] init];
    return _usedCards;
    
}


- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc] init];
        _grid.cellAspectRatio = self.maxCardSize.width / self.maxCardSize.height;
        _grid.minimumNumberOfCells = self.numberOfStartingCards;
        _grid.maxCellWidth = self.maxCardSize.width;
        _grid.maxCellHeight = self.maxCardSize.height;
        _grid.size = self.gridView.frame.size;
    }
    return _grid;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.numberOfStartingCards
                                                          usingDeck:[self createDeck]];

    return _game;
        
}

- (Deck *)createDeck //Abstract
{
    return nil;
}



- (IBAction)touchResetbutton:(UIButton *)sender
{
    for (UIView *cardView in self.cardViews) {
        [cardView removeFromSuperview];
    }
    self.cardViews = nil;
    self.game = nil;
    self.grid = nil;
    self.numberOfStartingCards = 12;
    self.cardPileAnimator = nil;
    [self updateUI];
    
}



#define CARDSPACINGINPERCENT 0.08


- (void)updateUI
{

    for (NSUInteger cardIndex = 0; cardIndex < self.game.numberOfDealtCards; cardIndex++) { //Goes through dealt cards
        //CardIndex is the index of the card in the array of the model
        Card *card = [self.game cardAtIndex:cardIndex]; //selects card at cardIndex
        if (card.isMatched && !card.isChosen) {
            continue;
        }
        NSUInteger viewIndex = [self.cardViews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                if (((UIView *)obj).tag == cardIndex) return YES;
            }
            return NO;
        }];
        UIView *cardView;
        if (viewIndex == NSNotFound) { //creates view for card if card is dealt in model but not in view
            cardView = [self createViewForCard:card];
            cardView.tag = cardIndex;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(touchCard:)];
            [cardView addGestureRecognizer:tap]; // add tap gesture to each card
            [self.cardViews addObject:cardView];  // cardView for a card is created and now added to cardViews array
            //Adding to cardView even if it's matched
            viewIndex = [self.cardViews indexOfObject:cardView];
            if (!card.isMatched) {
            [self.gridView addSubview:cardView];
            }//Add view to  grid on screen
        } else {
            cardView = self.cardViews[viewIndex];
            
            /* I can use the viewIndex as the index for the cards on the view.  The viewIndex is independent of the order of the objects in the array.  This needs to be changed so that that cards in the array have a different viewIndex
             */
            [self updateView:cardView forCard:card];
            
            if (card.isMatched && card.isChosen) {
                [self.cardsToRemove addObject:cardView];
            }
        }
        //Gets x and y positions for each card from the grid and sets the x and y positions.  It also sets the size of the cards based on bounds.
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = [self.grid frameOfCellAtRow:viewIndex / self.grid.columnCount
                                              inColumn:viewIndex % self.grid.columnCount];
            frame = CGRectInset(frame, frame.size.width * CARDSPACINGINPERCENT, frame.size.height * CARDSPACINGINPERCENT);
            cardView.frame = frame;
            
        } completion:nil];
        
    }
    //Detects if we need to remove cards if there are 3 matched cards.
    if ([self.cardsToRemove count]) {
        
        [self animateRemovingCards:self.cardsToRemove];
        [self.cardViews removeObjectsInArray:self.cardsToRemove];
        for (UIView *cardView in self.cardsToRemove) {
            NSUInteger index = cardView.tag;
            Card *card = [self.game cardAtIndex:index];
            card.chosen = NO;
        }
        self.numberOfStartingCards -= 3;

        self.cardsToRemove = nil;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %li", (long)self.game.score];

}



- (void)animateRemovingCards:(NSArray *)cardsToRemove
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         for (UIView *card in cardsToRemove) {
                             int x = (arc4random()%(int)(self.gridView.bounds.size.width*5)) - (int)self.gridView.bounds.size.width*2;
                             int y = self.gridView.bounds.size.height;
                             card.center = CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished) {
                         [cardsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                         [self updateUI];
                     }];
}


//test method
- (UIView *)createViewForCard:(Card *)card
{
    UIView *view = [[UIView alloc] init];
    [self updateView:view forCard:card];
    return view;
}
//test method
- (void)updateView:(UIView *)view forCard:(Card *)card
{
        view.backgroundColor = [UIColor blueColor];
    
}

-(void)viewWillLayoutSubviews
{
    self.grid = nil;
    [self updateUI];
}

- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (!self.cardPileAnimator) {
        if (gesture.state == UIGestureRecognizerStateEnded) {
            [self.game chooseCardAtIndex:gesture.view.tag];
        }
    }
    self.cardPileAnimator = nil;
    [self updateUI];

}


@end