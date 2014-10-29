//
//  HighscoreViewController.m
//  memory
//
//  Created by JG on 25/10/14.
//  
//

#import "HighscoreViewController.h"
#import "HighscoreModel.h"
#import "SimpleTableViewCell.h"

@implementation HighscoreViewController
    {
        __weak IBOutlet UITableView* _tableview;
        NSArray* _highScoreRows;
    }

typedef NSInteger Player;

    - ( void )viewDidLoad
    {
        [super viewDidLoad];
        
        _highScoreRows = [[[ HighscoreModel alloc ] init ] getHighscore ];
    }

    - ( IBAction )displayMenu: ( id )sender
    {
        [ self.presentingViewController dismissViewControllerAnimated: YES
                                                           completion: nil ];
    }

    #pragma mark - TableView Methods

    - ( NSInteger )numberOfSectionsInTableView:( UITableView* ) tableView
    {
        return 1;
    }

    - ( NSInteger )tableView: ( UITableView* )tableView numberOfRowsInSection: ( NSInteger )section
    {
        return [ _highScoreRows count ];
    }

    // Customize the appearance of table view cells.
    - ( UITableViewCell* )tableView: ( UITableView* )tableView
              cellForRowAtIndexPath: ( NSIndexPath* )indexPath
    {

        static NSString *CellIdentifier = @"Cell";
        
        SimpleTableViewCell *cell = ( SimpleTableViewCell* )[ tableView dequeueReusableCellWithIdentifier: CellIdentifier ];
        
        // Configure the cell...
        if ( cell == nil ) {
            cell = [[ SimpleTableViewCell alloc ] initWithStyle: UITableViewCellStyleDefault
                                                reuseIdentifier: CellIdentifier];
        }
        
        // Set the data for this cell:
        NSDictionary* scoreDict = @{};
        if ( [[ _highScoreRows objectAtIndex: indexPath.row] isKindOfClass: [ NSDictionary class ]])
        {
            scoreDict = [ _highScoreRows objectAtIndex: indexPath.row ];
        }
        
        cell.position.text = [ NSString stringWithFormat: @"%ld.", indexPath.row + 1 ];
        cell.name.text = [ scoreDict objectForKey: @"name" ];
        cell.points.text = [ NSString stringWithFormat: @"%@", [ scoreDict objectForKey: @"points" ]];
        
        return cell;
    }

@end
