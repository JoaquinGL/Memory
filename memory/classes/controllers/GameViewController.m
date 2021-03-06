//
//  GameViewController.m
//  memory
//
//  Created by JG on 25/10/14.
//
//

#import "GameViewController.h"
#import "CardView.h"
#import "GameModel.h"
#import "CardModel.h"
#import "HighscoreModel.h"
#import "GameOverViewController.h"
#import "gameSettings.h"

@interface GameViewController ()

@property ( nonatomic )GameModel* gameModel;
@property ( nonatomic )NSMutableArray* turnedCardViews;
@property ( nonatomic )HighscoreModel* hsModel;

@end

@implementation GameViewController

- ( void )viewDidLoad
{
    if (self.gameStateData != nil)
    {
        self.gameModel = [[GameModel alloc] initWithSavedData:self.gameStateData];
    } else {
        self.gameModel = [[GameModel alloc] initWithPlayers:self.numberOfPlayers];
    }
    
    self.hsModel = [[HighscoreModel alloc] init];
    self.turnedCardViews = [NSMutableArray array];
    
    [self generateCardViews];
    [self updateScoreLabel:self.player1ScoreLabel withScore:(long)self.gameModel.player1Score];
        
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.boardView addGestureRecognizer:tapGesture];
}

- ( void )viewDidAppear: (BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Adjustments - need to be set when view has appeared
    self.scrollView.contentSize = self.boardView.frame.size;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = MIN_ZOOM;
    self.scrollView.maximumZoomScale = MAX_ZOOM;
}

- ( void )generateCardViews
{
    int positionsLeftInRow = CARDS_PER_ROW;
    int j = 0;
    
    for (int i = 0; i < [self.gameModel.cards count]; i++) {
        NSInteger value = ((CardModel *)self.gameModel.cards[i]).value;
        CardView *cv = [[CardView alloc]
                        initWithFrame:
                            CGRectMake((i % CARDS_PER_ROW) * 64 + (i % CARDS_PER_ROW) * 15 + 5
                                       , j * 95 + j * 5 + 8
                                       , 75
                                       , 95)
                        andPosition:i
                        andValue:value];
        
        if (!((CardModel *)self.gameModel.cards[i]).outOfPlay) {
            [self.boardView addSubview:cv];
            
            if ([self.gameModel.turnedCards containsObject: self.gameModel.cards[i]]) {
                [self.turnedCardViews addObject: cv];
                [cv flip];
            }
        }
        
        if (--positionsLeftInRow == 0) {
            j++;
            positionsLeftInRow = CARDS_PER_ROW;
        }
    }
}

- ( void )handleTap: (UITapGestureRecognizer *)recognizer
{
    UIView *view = recognizer.view;
    CGPoint location = [recognizer locationInView:view];
    UIView *subview = [view hitTest:location withEvent:nil];

    if ([self.turnedCardViews count] < 2) {
        if([subview isKindOfClass:[CardView class]]) {
            CardView *cv = (CardView *)subview;
            if (![self.turnedCardViews containsObject: cv]) {
                [self.gameModel pickCard:(long)cv.pos];
                
                [self.turnedCardViews addObject:cv];
                [self flipCard:cv];
            }
        }
    } else {
        [self flipBackCards];
        [self.turnedCardViews removeAllObjects];
        [self.gameModel saveGameData];
    }
}

- ( void )flipCard: (CardView *)cv
{
    self.boardView.userInteractionEnabled = NO;
    [UIView transitionWithView:cv duration:.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [cv flip];
                    }
                    completion:^(BOOL finished){
                        self.boardView.userInteractionEnabled = YES;
                        [self checkState];
                    }];
}

- ( void )flipBackCards
{
    self.boardView.userInteractionEnabled = NO;
    CardView *cv1 = (CardView *) self.turnedCardViews[0];
    CardView *cv2 = (CardView *) self.turnedCardViews[1];
    
    
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            self.boardView.userInteractionEnabled = YES;
        }];
        [UIView transitionWithView:cv1
                          duration:.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{ [cv1 flip]; }
                        completion:nil];
        
        [UIView transitionWithView:cv2
                          duration:.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{ [cv2 flip]; }
                        completion:nil];
    } [CATransaction commit];
}

- ( void )fadeOutTurnedCards
{
    if ([self.turnedCardViews count] == 2) {
        self.boardView.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:.5
                         animations:^{
                             ((CardView *) self.turnedCardViews[0]).alpha = 0;
                             ((CardView *) self.turnedCardViews[1]).alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [self.turnedCardViews removeAllObjects];
                             [self checkGameFinished];
                             self.boardView.userInteractionEnabled = YES;
                         }];
    }
}

/*
 * checkState checks if pair was found or not and updates the scoreboard.
 */
- ( void )checkState
{
    if ([self.turnedCardViews count] == 2) {
        CardView *cv1 = (CardView *) self.turnedCardViews[0];
        CardView *cv2 = (CardView *) self.turnedCardViews[1];

        if (cv1.value == cv2.value) {
            [self.gameModel answeredCorrect];
            [self fadeOutTurnedCards];
        } else {
            [self.gameModel answeredWrong];
        }
        
        [self updateScoreLabel:self.player1ScoreLabel withScore:(long) self.gameModel.player1Score];
        
    }
    
    [self.gameModel saveGameData];
}

- ( void )checkGameFinished
{
    if ([self.gameModel isGameOver]) {
        GameOverViewController *govc = [self.storyboard instantiateViewControllerWithIdentifier:@"gameOverViewController"];
        
        govc.score = self.gameModel.player1Score;
        govc.winner = @"Player 1";
        
        [self presentViewController:govc animated:NO completion:^(){
            [self.gameModel clearGameData];
        }];
    }
}


- ( void )updateScoreLabel: ( UILabel* )scoreLabel
                 withScore: ( long )score
{
    scoreLabel.text = [NSString stringWithFormat:@"%ld", score];
}

- ( void )updateTurnLabel
{
    NSString *player = self.gameModel.isFirstPlayersTurn ? @"Player 1" : @"Player 2";
    self.turnLabel.text = [NSString stringWithFormat:@"%@, your turn!", player];
}

- ( IBAction )displayMenu: ( id )sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- ( UIView* )viewForZoomingInScrollView: ( UIScrollView* )scrollView
{
    return self.boardView;
}

@end
