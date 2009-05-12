#import <Cocoa/Cocoa.h>
#import <GPGME/GPGME.h>

@interface KeyWindowController : NSObject {
    IBOutlet NSTextField *CipherLabel;
    IBOutlet NSTextField *CompressionLabel;
    IBOutlet NSTextField *CreatedLabel;
    IBOutlet NSTextField *EmailLabel;
    IBOutlet NSTextField *EnabledLabel;
    IBOutlet NSTextField *EncodingLabel;
    IBOutlet NSTextField *ExpiresLabel;
    IBOutlet NSTextField *GroupLabel;
    IBOutlet NSTextField *HashLabel;
    IBOutlet NSTextField *IDLabel;
    IBOutlet NSTextField *NameLabel;
    IBOutlet NSImageView *PictureWell;
    IBOutlet NSTextField *SizeLabel;
    IBOutlet NSTextField *TrustLabel;
    IBOutlet NSTextField *TypeLabel;
    IBOutlet NSTextField *VerifiedLabel;
	IBOutlet NSWindow *keyWindow; 
	IBOutlet NSImageView *fingerprintImage; 
	IBOutlet NSTextField *fingerprintText;
	GPGKey *activeKey; 

}

- (void) setKey:(GPGKey *)key;
- (void) awakeFromNib;
- (void) showWindow;

@end
