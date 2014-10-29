//
//  BaseViewController.m
//  memory
//
//  Created by JG on 29/10/14.
//  Copyright (c) 2014 K. All rights reserved.
//

#import "BaseViewController.h"
#import "HighscoreViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

    - ( void )viewDidLoad
    {
        [super viewDidLoad];
    }

    - ( void )didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
    }

    - ( IBAction )displayHighscore: ( id )sender
    {
        HighscoreViewController *hvc = [self.storyboard instantiateViewControllerWithIdentifier:@"highscoreViewController"];
        [ self presentViewController: hvc
                            animated: YES
                          completion: nil];
    }

    - ( NSUInteger )supportedInterfaceOrientations
    {
        
        return UIInterfaceOrientationMaskPortrait;
    }

@end
