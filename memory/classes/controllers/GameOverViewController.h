//
//  GameOverViewController.h
//  memory
//
//  Created by JG on 25/10/14.
//  
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GameOverViewController : BaseViewController < UITextFieldDelegate >

    @property ( nonatomic )NSInteger score;
    @property ( nonatomic )NSString* winner;
    @property ( weak, nonatomic )IBOutlet UITextField* nameField;
    @property ( weak, nonatomic )IBOutlet UILabel* nameLabel;

    - ( IBAction )goToMenu: ( id )sender;

@end
