//
//  Card.h
//  Machismo
//
//  Created by Daniel Springer on 1/5/15.
//  Copyright (c) 2015 Daniel Springer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
