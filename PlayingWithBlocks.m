#import <Foundation/Foundation.h>
#import "MapReduce.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // insert code here...
 	IntBlock intMax = ^(int running, int num) { 
		int result = running > num ? running : num;
		NSLog(@"%i vs %i,  returning %i",num, running, result);
		return result;
		}; 

	StringBlock stringBlock = ^(NSString *input){ return input;};
	StringBlock addExclamationMark = ^(NSString *input){
		return [input stringByAppendingString:@"!"];
	};
	
	NumBlock findMax = ^(NSNumber *runningInput, NSNumber *input){
		if([input compare:runningInput] == NSOrderedAscending){
			return runningInput;
		}
		return input;
	};
	NSArray *nums = [NSArray arrayWithObjects:[NSNumber numberWithInt:8], [NSNumber numberWithInt:11], [NSNumber numberWithInt:2], nil];
	NSArray *strings = [NSArray arrayWithObjects:@"hi", @"ho", @"hi", @"ho", nil];
	
	int n = 3;
	int *array = malloc(sizeof(int)*n);
	array[0] = 1;
	array[1] = 2;
	array[2] = 4;
	
	int result = [MapReduce reduceInt:array withBlock:intMax];
	NSString *stringResult = [MapReduce reduceArray:strings withBlock:stringBlock];
	NSNumber *numResult = [MapReduce reduceNumArray:nums withBlock:findMax];
	NSArray *arrayResult = [MapReduce mapString:strings withBlock:addExclamationMark];
	NSLog(@"Should be done now...\n %i, %@, %@, %@", result, stringResult, numResult, arrayResult);
    [pool drain];
    return 0;
}
