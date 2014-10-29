//
//  CardModel.m
//  memory
//
//  Created by JG on 25/10/14.
//  
//

#import "CardModel.h"

@implementation CardModel

    - ( id )initWithValue: ( NSInteger )value {
        self = [super init];
        
        if ( self ) {
            self.value = value;
            self.outOfPlay = NO;
        }
        
        return self;
    }

@end
