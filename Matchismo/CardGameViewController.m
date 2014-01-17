//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 15/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController

- (Deck *)deck {
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck {
    return self.deck = [[PlayingCardDeck alloc] init];
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    UIImage *cardImage;
    NSString *cardTitle;
    
    if ([sender.currentTitle length]) {
        cardImage = [UIImage imageNamed:@"cardback"];
        cardTitle = @"";
    } else {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            cardImage = [UIImage imageNamed:@"cardfront"];
            cardTitle = card.contents;
        } else {
            sender.enabled = NO;
        }
    }
    if (cardImage && cardTitle) {
        [sender setTitle:cardTitle forState:UIControlStateNormal];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        self.flipCount++;
    }
}

@end
