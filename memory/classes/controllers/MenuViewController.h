//
//  MenuViewController.h
//  memory
//
//  Created by JG on 25/10/14.
//  
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MenuViewController : BaseViewController

    @property( strong, nonatomic )IBOutlet UIButton* onePlayerButton;
    @property( weak, nonatomic )IBOutlet UIButton* continueButton;

    - ( IBAction )startNewGame: ( id )sender;
    - ( IBAction )continueGame: ( id )sender;

@end
