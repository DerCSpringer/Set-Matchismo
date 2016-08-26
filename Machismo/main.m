//
//  main.m
//  Machismo
//
//  Created by Daniel Springer on 12/27/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardGameAppDelegate.h"

int main(int argc, char* argv[])
{
    @autoreleasepool
    {
        int returnValue;
        @try
        {
            returnValue = UIApplicationMain(argc, argv, nil,
                                            NSStringFromClass([CardGameAppDelegate  class]));
        }
        @catch (NSException* exception)
        {
            NSLog(@"Uncaught exception: %@, %@", [exception description],
                     [exception callStackSymbols]);
            @throw exception;
        }
        return returnValue;
    }
}
