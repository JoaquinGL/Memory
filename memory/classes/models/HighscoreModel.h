//
//  HighscoreModel.h
//  memory
//
//  Created by JG on 25/10/14.
//
//

#import <Foundation/Foundation.h>

@interface HighscoreModel : NSObject

-(NSArray *) getHighscore;
-(void) saveScoreWithPoints: (NSInteger)points andName: (NSString *)name;
-(BOOL) didReachHighscore: (NSInteger)points;

@end
