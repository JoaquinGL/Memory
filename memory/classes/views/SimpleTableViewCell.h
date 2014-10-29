//
//  SimpleTableViewCell.h
//  memory
//
//  Created by JG on 28/10/14.
//

#import <UIKit/UIKit.h>

@interface SimpleTableViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *position;
@property (nonatomic, weak) IBOutlet UILabel *points;

@end
