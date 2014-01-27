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
@property (strong, nonatomic) NSMutableArray *flipResultHistory;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@property (weak, nonatomic) IBOutlet UILabel *flipResult;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [self updateFlipResult:@""];
    
    self.historySlider.enabled = NO;

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

- (Deck *)createDeck { //abstract
    return nil;
}

- (IBAction)changeMatchModeControl:(UISegmentedControl *)sender {
    self.game.numberOfMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
    NSLog(@"Number of matching cards selected: %d", self.game.numberOfMatchingCards);
}

- (IBAction)touchDealButton:(id)sender {
    
    self.game = nil;
    
    //Enable the match mode control - the game has not started yet
    self.matchModeControl.enabled = YES;

    self.flipResultHistory = nil; //Cleans the history
    [self updateFlipResult:@""]; //Cleans the result
    self.historySlider.maximumValue = 0;
    self.historySlider.enabled = NO;
    
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


- (IBAction)changeHistorySlider:(UISlider *)sender {

    int intValue = roundf(sender.value);
    [sender setValue:intValue animated:NO];
    
    if ([self.flipResultHistory count]) {
        self.flipResult.alpha = (intValue > 0) ? 0.7 : 1.0;
        self.flipResult.text = [self.flipResultHistory objectAtIndex:intValue];
    }
    
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
    [self updateFlipResult:lastResult];
}

- (void) updateFlipResult:(NSString *) result {
    
    if (![@"" isEqualToString:result]) { //Don't save empty strings in the history
        [self.flipResultHistory insertObject:result atIndex:0];
        
        self.historySlider.value = 0; //Bring back to default position
        self.historySlider.maximumValue = [self.flipResultHistory count] - 1;
        self.historySlider.enabled = (self.historySlider.maximumValue > 0) ? YES : NO;
        //NSLog(@"Slider max value: %f", self.historySlider.maximumValue);
    }
    self.flipResult.alpha = 1.0;
    self.flipResult.text = result;
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
    return [UIImage imageNamed:(card.chosen ? @"cardfront" : @"cardback-oil")];
}

@end
