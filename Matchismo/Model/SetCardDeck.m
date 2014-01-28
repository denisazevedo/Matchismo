//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 27/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //Numbers
        for (NSUInteger number = [SetCard minNumber]; number <= [SetCard maxNumber]; number++) { //1 ~ 3
            //Symbols
            for (NSString *symbol in [SetCard validSymbols]) {
                //Shadings
                for (NSString *shading in [SetCard validShadings]) {
                    //Colors
                    for (NSString *color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
