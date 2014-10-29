//
//  SimpleTableViewCell.m
//  memory
//
//  Created by Joaquin Giraldez on 28/10/14.
//  Copyright (c) 2014 K. All rights reserved.
//

#import "SimpleTableViewCell.h"

@implementation SimpleTableViewCell

@synthesize name = _name;
@synthesize position = _position;
@synthesize points = _points;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
