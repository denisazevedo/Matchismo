//
//  ScoresViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 17/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "ScoresViewController.h"
#import "GameResult.h"

@interface ScoresViewController ()

@property (weak, nonatomic) IBOutlet UITextView *scoresTextView;
@property (strong, nonatomic) NSArray *scores;

@end

@implementation ScoresViewController

- (void)updateUI {
    NSString *text = @"";
//    NSArray *sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareStartDate:)];
    for (GameResult *result in self.scores) {
        text = [text stringByAppendingString:[self stringFromResult:result]];
    }
    self.scoresTextView.text = text;
    NSArray *sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor redColor]];
    [self changeScore:[sortedScores lastObject] toColor:[UIColor greenColor]];
    sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor purpleColor]];
    [self changeScore:[sortedScores lastObject] toColor:[UIColor blueColor]];
}

- (void)changeScore:(GameResult *)result toColor:(UIColor *)color {
    NSRange range = [self.scoresTextView.text rangeOfString:[self stringFromResult:result]];
    [self.scoresTextView.textStorage addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (NSString *)stringFromResult:(GameResult *)result {
    NSString *tabs = ([result.gameType rangeOfString:@"Set"].location == NSNotFound) ? @"\t" : @"\t\t";
    return [NSString stringWithFormat:@"%@:%@%d, (%@, %gs)\n",
            result.gameType,
            tabs,
            result.score,
            [NSDateFormatter localizedStringFromDate:result.end
                                           dateStyle:NSDateFormatterShortStyle
                                           timeStyle:NSDateFormatterShortStyle],
            round(result.duration)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.scores = [GameResult allGameResults];
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

@end
