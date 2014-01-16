//
//  Card.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 16/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
