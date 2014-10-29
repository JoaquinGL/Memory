//
//  GameOverViewController.m
//  memory
//
//  Created by JG on 25/10/14.
//
//

#import "GameOverViewController.h"
#import "HighscoreModel.h"

@interface GameOverViewController ()
{
    __weak IBOutlet UIButton *_endGameButton;
}

@property (nonatomic) HighscoreModel *hsModel;

@end

@implementation GameOverViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [_endGameButton setAlpha: 0];
    
	self.hsModel = [[HighscoreModel alloc] init];
    
    UILabel *winnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 150, 30)];
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 120, 320, 30)];
    
    winnerLabel.textAlignment =  NSTextAlignmentRight;
    winnerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    winnerLabel.textColor = [UIColor whiteColor];

    pointsLabel.textAlignment = NSTextAlignmentLeft;
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
    
    [winnerLabel setText: [NSString stringWithFormat:@"%@: ", self.winner]];
    [pointsLabel setText: [NSString stringWithFormat:@"%ld Points!", self.score]];
    
    [self.view addSubview:winnerLabel];
    [self.view addSubview:pointsLabel];
    
    if ([self.hsModel didReachHighscore: self.score]) {
        self.nameField.delegate = self;
        [self.nameField setText: self.winner];
        
        self.nameLabel.hidden = NO;
        self.nameField.hidden = NO;
    }
    
}

-(IBAction) goToMenu: (id)sender {
    [self.hsModel saveScoreWithPoints:self.score andName:self.nameField.text];
    
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

-(BOOL) textFieldShouldReturn: (UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL) textFieldShouldBeginEditing: (UITextField *)textField {
    [textField setText:@""];
    return YES;
}
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField{
    
    (textField.text.length == 0 )
        ? [_endGameButton setAlpha: 0]
        : [_endGameButton setAlpha: 1];

    return YES;
}

@end
