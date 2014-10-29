//
//  GameModel.h
//  memory
//
//  Created by JG on 25/10/14.
//  
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

    @property ( nonatomic )NSMutableArray* cards;
    @property ( nonatomic )NSMutableArray* turnedCards;
    @property ( nonatomic )BOOL isFirstPlayersTurn;
    @property ( nonatomic )NSInteger player1Score;

    - ( id )initWithPlayers: ( NSInteger )numberOfPlayers;
    - ( id )initWithSavedData: ( NSDictionary* )gameStateData;
    - ( BOOL )canPickCard: ( long )index;
    - ( BOOL )isPairFound;
    - ( BOOL )isGameOver;
    - ( void )pickCard: ( long )index;
    - ( void )answeredCorrect;
    - ( void )answeredWrong;
    - ( void )saveGameData;
    - ( void )clearGameData;

@end
