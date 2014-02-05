//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 04/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation HistoryViewController

#pragma mark - Properties

- (void)setHistory:(NSArray *)history {
    _history = history;
    if (self.view.window) [self updateUI];
}

#pragma mark - LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Drawing

- (void)updateUI {
    
    NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc] init];
    int i = 1;

    for (NSAttributedString *line in self.history) {
        [historyText appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:[NSString stringWithFormat:@"%2d: ", i++]]];
        [historyText appendAttributedString:line];
        [historyText appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:@"\n\n" ]];
    }
    self.historyTextView.attributedText = historyText;
}

@end
