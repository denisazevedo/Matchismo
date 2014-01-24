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

@interface CardGameViewController : UIViewController

//protected
//for subclasses
- (Deck *)createDeck; //abstract

@end
