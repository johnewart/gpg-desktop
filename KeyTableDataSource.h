//
//  KeyTableDataSource.h
//  GPG Desktop
//
//  Created by John Ewart on 10/24/08.
//  Copyright 2008 23solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <GPGME/GPGME.h>

@interface KeyTableDataSource : NSObject {
	NSMutableArray *keys;
	
}

- (void)setKeys:(NSMutableArray *)keyArray;
-(void)addKey:(GPGKey *)key; 
-(int)numberOfRowsInTableView:(NSTableView *)aTableView;
-(id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex;


@end
