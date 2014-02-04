//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 27/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.numberOfMatchingCards = 3;
    [self updateUI];
}

- (void)refreshFlipResult {
    
    int lastScore = self.game.lastScore;
    NSMutableAttributedString *lastCards = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *lastResult = [[NSMutableAttributedString alloc] initWithString:@""];
    
    if ([self.game.lastChosenCards count]) {
        for (Card *card in self.game.lastChosenCards) {
            [lastCards appendAttributedString:[self titleForCard:card]];
            [lastCards appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        
        if (lastScore > 0) {
            lastResult = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Matched for %d points.", lastScore]];
            [lastResult insertAttributedString:lastCards atIndex:8];
        } else if (lastScore < 0){
            lastResult = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"don't match! %d points penalty!", lastScore]];
            [lastResult insertAttributedString:lastCards atIndex:0];
        } else { //lastScore == 0
            lastResult = [lastCards mutableCopy];
        }
    }
    [self updateFlipResult:lastResult];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    
    NSString *symbol = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        
        //Symbol
        if ([setCard.symbol isEqualToString:@"diamond"]) symbol = @"■";
        else if ([setCard.symbol isEqualToString:@"squiggle"]) symbol = @"▲";
        else if ([setCard.symbol isEqualToString:@"oval"]) symbol = @"●";
        symbol = [symbol stringByPaddingToLength:setCard.number withString:symbol startingAtIndex:0];
        
        //Color
        if ([setCard.color isEqualToString:@"red"])
            [attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        else if ([setCard.color isEqualToString:@"green"])
            [attributes setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
        else if ([setCard.color isEqualToString:@"purple"])
            [attributes setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
        
        //Shading
        if ([setCard.shading isEqualToString:@"solid"])
            [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        else if ([setCard.shading isEqualToString:@"striped"])
            [attributes addEntriesFromDictionary:@{
                                                   NSStrokeWidthAttributeName : @-5,
                                                   NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
                                                   NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
                                                   }];
        else if ([setCard.shading isEqualToString:@"open"])
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        
    }
    return [[NSMutableAttributedString alloc] initWithString:symbol attributes:attributes];
}

- (UIImage *)backgroundForCard:(Card *)card {
    return [UIImage imageNamed:card.chosen ? @"cardfront-selected" : @"cardfront"];
}

@end
