//
//  KeyTableDataSource.m
//  GPG Desktop
//
//  Created by John Ewart on 10/24/08.
//  Copyright 2008 23solutions. All rights reserved.
//

#import "KeyTableDataSource.h"


@implementation KeyTableDataSource

-(void)addKey:(GPGKey *)key
{
	if (keys == nil) { 
		keys = [[NSMutableArray alloc] init];
	}
	
	[keys addObject:key];
}

- (void)setKeys:(NSMutableArray *)keyArray
{
	keys = keyArray;
}
	

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn	row:(int)rowIndex
{
    GPGKey *key;
	NSString *value;
	NSParameterAssert(rowIndex >= 0 && rowIndex < [keys count]);
	NSString *colName; 
	
	if ( aTableColumn != nil)
	{
		colName = [[aTableColumn headerCell] stringValue];
		key = [keys objectAtIndex:rowIndex];
		if([colName isEqualToString:@"Name"])
		{
			value = [key name];
		} else if ([colName isEqualToString:@"Email"]) {
			value = [key email];
		} else { 
			value = [GPGKey formattedFingerprint:[key fingerprint]];
		}

		return value;
	} else {
		return nil;
	}
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	NSLog(@"We have %d rows", [keys count]);
    return [keys count];
}

@end
