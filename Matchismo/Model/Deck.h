//
//  Deck.h
//  Matchismo
//
//  Created by Denis C de Azevedo on 16/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard: (Card *)card atTop: (BOOL)atTop;
- (void)addCard: (Card *)card;

- (Card *)drawRandomCard;

@end
