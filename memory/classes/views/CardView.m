//
//  CardView.m
//  memory
//
//  Created by JG on 25/10/14.
//
//

#import "CardView.h"

#define IMAGE_CARD_NAME @"colour%ld.png"

@interface CardView()

    @property (nonatomic) UIImage *frontImage;
    @property (nonatomic) UIImage *backImage;

@end

@implementation CardView

    // instantiate custom view subclass programmatically
    - ( id ) initWithFrame: ( CGRect )frame
               andPosition: ( NSInteger )pos
                  andValue: ( NSInteger )value
    {
        self = [super initWithFrame: frame];
        if (self) {
            self.frontImage = [UIImage imageNamed:[NSString stringWithFormat: IMAGE_CARD_NAME, (long) (value+1)]];
            self.backImage = [UIImage imageNamed:@"card_bg.png"];
            
            self.contentMode = UIViewContentModeScaleAspectFit;
            self.clipsToBounds = YES;
            self.userInteractionEnabled = YES;
            self.image = self.backImage;
            self.value = value;
            self.pos = pos;
        }
        return self;
    }

    - ( void )flip {
        self.image = (self.image == self.frontImage) ? self.backImage : self.frontImage;
    }

@end
