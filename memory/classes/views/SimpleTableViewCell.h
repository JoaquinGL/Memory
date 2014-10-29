//
//  SimpleTableViewCell.h
//  memory
//
//  Created by Joaquin Giraldez on 28/10/14.
//  Copyright (c) 2014 K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *position;
@property (nonatomic, weak) IBOutlet UILabel *points;

@end
