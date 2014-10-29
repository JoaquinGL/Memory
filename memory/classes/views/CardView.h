//
//  CardView.h
//  memory
//
//  Created by JG on 25/10/14.
//
//

#import <UIKit/UIKit.h>

@interface CardView : UIImageView

    @property ( nonatomic )NSInteger pos;
    @property ( nonatomic )NSInteger value;

    - ( id )initWithFrame: ( CGRect )frame
              andPosition: ( NSInteger )pos
                 andValue: ( NSInteger )value;
    - ( void )flip;

@end
