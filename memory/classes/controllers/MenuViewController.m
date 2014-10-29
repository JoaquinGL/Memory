//
//  MenuViewController.m
//  memory
//
//  Created by JG on 25/10/14.
//  
//

#import "MenuViewController.h"
#import "GameViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

    - ( void )viewDidLoad
    {
        [ super viewDidLoad ];
    }

    - ( void )viewDidAppear:( BOOL )animated
    {
        // Check if there exists saved game data
        NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
        self.continueButton.hidden = ([ defaults objectForKey:@"savedGame" ]) ? NO : YES;
    }

    - ( IBAction )startNewGame:( id )sender
    {
        [self startGameWithState: nil];
    }

    - ( IBAction )continueGame:( id )sender
    {
        [self startGameWithState:[[ NSUserDefaults standardUserDefaults ] objectForKey: @"savedGame" ]];
    }

    - ( void )startGameWithState:( NSDictionary* )gameStateData
    {
        GameViewController *gvc = [self.storyboard instantiateViewControllerWithIdentifier:@"gameViewController"];
        gvc.gameStateData = gameStateData;
        
        gvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [ self presentViewController: gvc
                            animated: YES
                          completion: nil ];
    }

@end
