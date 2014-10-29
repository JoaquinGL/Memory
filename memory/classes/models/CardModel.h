//
//  CardModel.h
//  memory
//
//  Created by JG on 25/10/14.
//  
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject

@property (nonatomic) NSInteger value;
@property (nonatomic) BOOL outOfPlay;

-(id) initWithValue:(NSInteger)value;

@end
