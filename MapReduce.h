//
//  MapReduce.h
//  PlayingWithBlocks
//
//  Created by Samuel Goodwin on 2/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NSString *(^StringBlock)();
typedef NSNumber *(^NumBlock)();
typedef int(^IntBlock)();

@interface MapReduce : NSObject {

}
+ (int)doStuff;
+ (int)reduceInt:(int *)ints withBlock:(IntBlock)block;
+ (NSString *)reduceArray:(NSArray *)stuff withBlock:(StringBlock)block;
+ (NSNumber *)reduceNumArray:(NSArray *)stuff withBlock:(NumBlock)block;
+ (NSArray *)mapString:(NSArray *)objects withBlock:(StringBlock)block;
@end
