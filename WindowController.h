#import <Cocoa/Cocoa.h>
#import "KeyTableDataSource.h"
#import "KeyWindowController.h"
#import <GPGME/GPGME.h>

@interface WindowController : NSObject 
{
    IBOutlet NSTableView *keyTableView;
    IBOutlet NSWindow *keyWindow;
	IBOutlet KeyWindowController *kwc;
	IBOutlet NSToolbar *toolbar;
	NSMutableArray *keyArr;
	GPGContext *gpg;
	KeyTableDataSource *keyTableDS;
	NSStatusItem *statusItem;
}

- (void)doubleClickInTable:(id)sender;
- (void)reloadKeys;

/* Toolbar delegates */

@end
