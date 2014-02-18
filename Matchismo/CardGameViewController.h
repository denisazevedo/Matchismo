//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Denis C de Azevedo on 15/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//
// Abstract class, must implement methods as described bellow.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;

//protected
//for subclasses
- (Deck *)createDeck; //abstract

//protected
//for subclasses
- (void)refreshFlipResult; //abstract

@property (strong, nonatomic) NSString *gameType;

- (void)updateUI;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundForCard:(Card *)card;
- (void) updateFlipResult:(NSAttributedString *) result;

@end
