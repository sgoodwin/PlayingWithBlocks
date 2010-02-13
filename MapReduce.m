//
//  MapReduce.m
//  PlayingWithBlocks
//
//  Created by Samuel Goodwin on 2/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapReduce.h"
#import <dispatch/dispatch.h>


@implementation MapReduce

+ (int)doStuff{
	//dispatch_queue_t queue = dispatch_queue_create("mapreduce", NULL);
	dispatch_queue_t queue = dispatch_get_global_queue(0,0);
	//[queue retain];
	
	__block int count = 0;
	dispatch_sync(queue,^{
		count++;
		NSLog(@"First Block %i!", count);
		return;
		});
	dispatch_async(queue,^{ 
		count++;
		NSLog(@"Second Block! %i", count);
		return;
		});
	dispatch_sync(queue,^{ 
		count++;
		NSLog(@"Third Block! %i", count);
		return;
		});
	return 1;
}

+ (int)reduceInt:(int *)ints withBlock:(IntBlock)block{
	int result = 0;
	for(int i =0;i<3;i++){
		result = block(result, ints[i]);
	}
	return result;
}

+ (NSString *)reduceArray:(NSArray *)stuff withBlock:(StringBlock)block{
	NSString *result = [NSString string];
	for(NSString *aString in stuff){
		result = [result stringByAppendingString:block(aString)];
	}
	return result;
}

+ (NSNumber *)reduceNumArray:(NSArray *)stuff withBlock:(NumBlock)block{
	NSNumber *result = [NSNumber numberWithInt:0];
	for(NSNumber *aNum in stuff){
		result = block(result, aNum);
	}
	return result;
}

+ (NSArray *)mapString:(NSArray *)objects withBlock:(StringBlock)block{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:[objects count]];
	for(NSString *object in objects){
		[result addObject:block(object)];
	}
	return result;
}
@end
