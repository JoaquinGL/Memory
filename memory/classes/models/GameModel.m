//
//  GameModel.m
//  memory
//
//  Created by JG on 25/10/14.
//  
//

#import "GameModel.h"
#import "CardModel.h"
#import "gameSettings.h"

#define CORRECT_POINTS 2
#define INCORRECT_POINTS 1

@implementation GameModel

    - ( id )initWithPlayers: ( NSInteger )numberOfPlayers {
        self = [super init];
        
        if (self) {
            self.cards = [self createNewDeck];
            self.cards = [self shuffle:self.cards];
            
            self.turnedCards = [NSMutableArray array];
            
            self.isFirstPlayersTurn = YES;
        }
        
        return self;
    }

    - ( id )initWithSavedData: ( NSDictionary* )gameStateData {
        self = [super init];
        
        if (self) {
            self.turnedCards = [NSMutableArray array];
            self.cards = [self loadGameData];
        }
        
        return self;
    }


    - ( BOOL )canPickCard: (long)index {
        CardModel *pickedCard = (CardModel *)self.cards[index];
        
        if ([self.turnedCards count] < 2 && ![self.turnedCards containsObject: pickedCard] && !pickedCard.outOfPlay) {
            return YES;
        }
        
        return NO;
    }

    - ( BOOL )isPairFound {
        if ([self.turnedCards count] == 2) {
            CardModel *turnedCard1 = (CardModel *)self.turnedCards[0];
            CardModel *turnedCard2 = (CardModel *)self.turnedCards[1];
            
            if (turnedCard1.value == turnedCard2.value) {
                turnedCard1.outOfPlay = YES;
                turnedCard2.outOfPlay = YES;
                
                return YES;
            }
        }
        
        return NO;
    }

    - ( BOOL )isGameOver {
        for (CardModel *card in self.cards) {
            if (!card.outOfPlay) {
                return NO;
            }
        }
        
        return YES;
    }

    - ( void )pickCard: (long)index {
        if ([self canPickCard:index]) {
            CardModel *pickedCard = (CardModel *)self.cards[index];
            [self.turnedCards addObject:pickedCard];
        }
    }

    - ( void )answeredCorrect {
        ((CardModel *)self.turnedCards[0]).outOfPlay = YES;
        ((CardModel *)self.turnedCards[1]).outOfPlay = YES;
        
        [self.turnedCards removeAllObjects];
        [self addPoints: CORRECT_POINTS];
    }

    - ( void )answeredWrong {
        [self.turnedCards removeAllObjects];
        [self addPoints: - INCORRECT_POINTS];
    }

    - ( void )addPoints: (NSInteger)points {
        self.player1Score += points;
    }

    - ( NSMutableArray* )createNewDeck {
        NSMutableArray *cardDeck = [NSMutableArray array];
        
        for (int i = 0; i < NUMBER_OF_PAIRS; i++) {
            [cardDeck addObject:[[CardModel alloc] initWithValue:i]];
            [cardDeck addObject:[[CardModel alloc] initWithValue:i]];
        }

        return cardDeck;
    }

    - ( NSMutableArray* )shuffle: (NSMutableArray *)arr {

        NSUInteger count = [arr count];
        
        for (NSUInteger i = 0; i < count; ++i) {
            NSUInteger nElements = count - i;
            NSUInteger n = arc4random_uniform((uint32_t) nElements) + i;
            [arr exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
        
        return arr;
    }

    - ( void )saveGameData {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *cardsArray = [NSMutableArray array];
        NSMutableArray *turnedCardsArray = [NSMutableArray array];
        NSDictionary *cardDict;
        
        NSInteger index = 0;
        for (CardModel *card in self.cards) {
            cardDict = @{@"value" : @(card.value), @"outOfPlay": @(card.outOfPlay)};
            [cardsArray addObject: cardDict];
            
            if ([self.turnedCards containsObject: card]) {
                [turnedCardsArray addObject: @(index)];
            }
            
            ++index;
        }
       
        NSDictionary *gameState = @{ @"players" : [NSNumber numberWithInteger: 1],
                                     @"isFirstPlayersTurn" : [NSNumber numberWithBool:self.isFirstPlayersTurn],
                                     @"score" : @{ @"player1" : @(self.player1Score)},
                                     @"cards" : cardsArray,
                                     @"turnedCards" : turnedCardsArray
                                     };
        
        [defaults setObject:gameState forKey:@"savedGame"];
        
        [defaults synchronize];
    }

    - ( NSMutableArray* )loadGameData {
        NSMutableArray *cardDeck = [NSMutableArray array];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *savedData = [defaults objectForKey:@"savedGame"];
        NSArray *cardArray = ((NSArray *)[savedData objectForKey: @"cards"]);
        NSArray *turnedCardsArray = ((NSArray *)[savedData objectForKey: @"turnedCards"]);
        
        NSInteger index = 0;
        for (NSDictionary *cardData in cardArray) {
            CardModel *card = [[CardModel alloc] initWithValue: [[cardData objectForKey: @"value"] integerValue]];
            card.outOfPlay = [[cardData objectForKey: @"outOfPlay"] boolValue];
            [cardDeck addObject: card];
            
            for (NSNumber *i in turnedCardsArray) {
                if ([i integerValue] == index) {
                    [self.turnedCards addObject: card];
                }
            }
            
            ++index;
        }
        
        self.isFirstPlayersTurn = YES;

        self.player1Score = [[((NSDictionary *)[savedData objectForKey: @"score"]) objectForKey: @"player1"] integerValue];
        
        return cardDeck;
    }

    - ( void )clearGameData {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"savedGame"];
}

@end
