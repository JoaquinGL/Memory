//
//  GameViewController.h
//  memory
//
//  Created by JG on 25/10/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GameViewController : BaseViewController <UIScrollViewDelegate>

    @property ( strong, nonatomic )IBOutlet UIScrollView* scrollView;
    @property ( strong, nonatomic )IBOutlet UIView* boardView;
    @property ( strong, nonatomic )IBOutlet UILabel* player1ScoreLabel;
    @property ( strong, nonatomic )IBOutlet UILabel* player2ScoreLabel;
    @property ( weak, nonatomic)IBOutlet UILabel* turnLabel;
    @property ( nonatomic )NSInteger numberOfPlayers;
    @property ( nonatomic )NSDictionary* gameStateData;

    - ( IBAction )displayMenu: ( id )sender;

@end
