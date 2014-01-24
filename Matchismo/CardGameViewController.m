//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 15/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@property (weak, nonatomic) IBOutlet UILabel *flipResult;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    self.flipResult.text = @"";
    //The 2 lines below are a workaround to set all borders to use the tint color
    self.matchModeControl.selectedSegmentIndex = 1;
    self.matchModeControl.selectedSegmentIndex = 0;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        [self changeMatchModeControl:self.matchModeControl];
    }
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)changeMatchModeControl:(UISegmentedControl *)sender {
    self.game.numberOfMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
    NSLog(@"Number of matching cards selected: %d", self.game.numberOfMatchingCards);
}

- (IBAction)touchDealButton:(id)sender {
    self.game = nil;
    //Enable the match mode control - the game has not started yet
    self.matchModeControl.enabled = YES;

    self.flipResult.text = @"";
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {

    int choosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosenButtonIndex];
    
    //Disable the match mode control - the game has started
    self.matchModeControl.enabled = NO;
    
    [self refreshFlipResult];
    [self updateUI];
}

- (void)refreshFlipResult {
    
    int lastScore = self.game.lastScore;
    NSString *lastResult = @"";
    
    if ([self.game.lastChosenCards count]) {
        lastResult = [self.game.lastChosenCards componentsJoinedByString:@""];
        
        if (lastScore > 0) {
            lastResult = [NSString stringWithFormat:@"Matched %@ for %d points.", lastResult, lastScore];
        } else if (lastScore < 0){
            lastResult = [NSString stringWithFormat:@"%@ don't match! %d points penalty!", lastResult, lastScore];
        }
    }
    self.flipResult.text = lastResult;
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
    }
    [self refreshScore];
}

- (void)refreshScore {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card {
    return card.chosen ? card.contents : @"";
}

- (UIImage *)backgroundForCard:(Card *)card {
    return [UIImage imageNamed:(card.chosen ? @"cardfront" : @"cardback")];
}

@end
