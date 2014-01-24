//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 15/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck { //abstract
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {

    int choosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosenButtonIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        if (card.isMatched) cardButton.enabled = NO;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card {
    return card.chosen ? card.contents : @"";
}

- (UIImage *)backgroundForCard:(Card *)card {
    return [UIImage imageNamed:(card.chosen ? @"cardfront" : @"cardback")];
}

@end
