#import "WindowController.h"

@implementation WindowController
-(void)dealloc
{
	[statusItem release];
	[super dealloc];
}

- (void) awakeFromNib
{
	keyArr = [[NSMutableArray alloc] init];
	
	keyTableDS = [[KeyTableDataSource alloc] init];
	[keyTableView setDataSource:keyTableDS];

	gpg = [[GPGContext alloc] init];
	
	[self reloadKeys];
		
	[keyTableView setTarget:self];
	[keyTableView setDoubleAction:@selector(doubleClickInTable:)];
	
	statusItem = [[[NSStatusBar systemStatusBar] 
				   statusItemWithLength:NSVariableStatusItemLength]
				  retain];
	[statusItem setHighlightMode:YES];
	[statusItem setTitle:[NSString 
						  stringWithString:@"0.0.0.0"]]; 
	[statusItem setEnabled:YES];
	[statusItem setToolTip:@"IPMenulet"];

	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *path = [bundle pathForResource:@"Lock2" ofType:@"png"];
	NSImage *menuIcon= [[NSImage alloc] initWithContentsOfFile:path];
	
	[statusItem setTitle:[NSString stringWithString:@""]]; 
	
	[statusItem setImage:menuIcon];
	//[statusItem setAction:@selector(updateIPAddress:)];
	//[statusItem setTarget:self];

	
}

- (void)reloadKeys 
{
	NSEnumerator *keys = [gpg keyEnumeratorForSearchPattern:nil secretKeysOnly:FALSE];
	
	GPGKey *key;
	
	while ((key = (GPGKey *)[keys nextObject])) {
		NSLog(@"Got key: %@ <%@> %@", [key name], [key email], [GPGKey formattedFingerprint:[key fingerprint]]);
		[keyArr addObject:key];
	}

	[keyTableDS setKeys:keyArr];
	NSLog(@"Reloading table");
	[keyTableView reloadData];
	
}

- (void)doubleClickInTable:(id)sender
{
	int rowIndex = [sender selectedRow]; 
	GPGKey *key = (GPGKey *)[keyArr objectAtIndex:rowIndex];
	
	if (kwc == nil) 
	{
		kwc = [[KeyWindowController alloc] init];
	} 
		
	[kwc setKey:key];
	[kwc showWindow];

}

@end
