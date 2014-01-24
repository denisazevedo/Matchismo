//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 24/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
