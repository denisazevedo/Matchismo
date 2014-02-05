//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 15/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
//@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *flipResultHistory; //Of NSMutableAttributedString
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResult;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [self updateFlipResult:[[NSAttributedString alloc] initWithString:@""]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *controller = (HistoryViewController *)segue.destinationViewController;
            controller.history = self.flipResultHistory;
        }
    }
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (NSMutableArray *)flipResultHistory {
    if (!_flipResultHistory) _flipResultHistory = [NSMutableArray array];
    return _flipResultHistory;
}

- (Deck *)createDeck { //abstract
    return nil;
}

- (IBAction)touchDealButton:(id)sender {
    
    NSUInteger numberOfMatchingCards = self.game.numberOfMatchingCards; //keep current number of matching cards
    self.game = nil;
    self.game.numberOfMatchingCards = numberOfMatchingCards; //restore number of matching cards
    
    self.flipResultHistory = nil; //Cleans the history
    [self updateFlipResult:[[NSAttributedString alloc] initWithString:@""]]; //Cleans the result
    
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {

    int choosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosenButtonIndex];
    
    [self refreshFlipResult];
    [self updateUI];
}

- (void)refreshFlipResult { //abstract
}

- (void) updateFlipResult:(NSAttributedString *) result {
    
    if (![@"" isEqualToString:[result string]]) { //Don't save empty strings in the history

        [self.flipResultHistory insertObject:result atIndex:0];
        //NSLog(@"Slider max value: %f", self.historySlider.maximumValue);
    }
    self.flipResult.alpha = 1.0;
    self.flipResult.attributedText = result;
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
    }
    [self refreshScore];
}

- (void)refreshScore {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    return [[NSAttributedString alloc] initWithString:(card.chosen ? card.contents : @"")
                                           attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (UIImage *)backgroundForCard:(Card *)card {
    return [UIImage imageNamed:(card.chosen ? @"cardfront" : @"cardback-oil")];
}

@end
