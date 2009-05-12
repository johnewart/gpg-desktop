//
//  GenerationWindowController.h
//  GPG Desktop
//
//  Created by John Ewart on 10/27/08.
//  Copyright 2008 23solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GPGME/GPGME.h"

@interface GenerationWindowController : NSObject {
    IBOutlet NSTextField *nameTF;
    IBOutlet NSTextField *commentTF;
    IBOutlet NSTextField *emailTF;
    IBOutlet NSTextField *passphraseTF;
    IBOutlet NSTextField *passphraseConfirmTF;
	IBOutlet NSDatePicker *expirationDate; 
	IBOutlet NSPopUpButton *keyLength; 
	IBOutlet NSPopUpButton *keyType; 
	
	IBOutlet NSImageView *keyImage; 
	NSDictionary *algoForNameDict;
	NSArray *algoArray;
}

- (void) awakeFromNib;
- (IBAction)generateKey:(id)sender;
- (GPGPublicKeyAlgorithm) algorithmFromName:(NSString *)name;

@end
