#import "KeyWindowController.h"

@implementation KeyWindowController
- (void) awakeFromNib
{
 /*   [CipherLabel setStringValue:@""];
    [CompressionLabel setStringValue:@""];
    [CreatedLabel setStringValue:@""];
    [EmailLabel setStringValue:@""];
    [EnabledLabel setStringValue:@""];
    [EncodingLabel setStringValue:@""];
    [ExpiresLabel setStringValue:@""];
    [GroupLabel setStringValue:@""];
    [HashLabel setStringValue:@""];
    [IDLabel setStringValue:@""];
    [NameLabel setStringValue:@""];
    [SizeLabel setStringValue:@""];
    [TrustLabel setStringValue:@""];
    [TypeLabel setStringValue:@""];
    [VerifiedLabel setStringValue:@""];*/
	
	NSImage *img = [[NSImage  alloc] initWithContentsOfFile:@"/Users/jewart/Desktop/Fingerprint1.jpg"];
	if ( img != nil ) 
	{
		NSLog(@"Succeeded in loading image data");
		
		[fingerprintImage setImage:img];
		[img release];
	} else { 
		NSLog(@"Problem loading image data");
	}
	
}

-(void) setKey:(GPGKey *)key
{
	NSLog(@"Setting key: %@", [key userID]);

	activeKey = key; 
	
	if(keyWindow == nil)
	{
		NSLog(@"Window is nil, not good");
	} else { 
	
		if (![keyWindow isVisible])
		{
			[keyWindow makeKeyAndOrderFront:nil];
		}
		
		[NameLabel setStringValue:[key name]];
		[EmailLabel setStringValue:[key email]];
		[TrustLabel setStringValue:[key ownerTrustDescription]];
		[TypeLabel setStringValue:[key algorithmDescription]];
		NSLog(@"Supported protocols: %@", [key supportedProtocolDescription]);
		[CipherLabel setStringValue:[key supportedProtocolDescription]];
		[SizeLabel setStringValue:[NSString stringWithFormat:@"%d", [key length]]];
		[IDLabel setStringValue:[NSString stringWithFormat:@"0x%@", [key shortKeyID]]];
		[VerifiedLabel setStringValue:[key validityDescription]];
		
		if([key isKeyDisabled]) { 
			[EnabledLabel setStringValue:@"No"];
		} else { 
			[EnabledLabel setStringValue:@"Yes"]; 
		}
		
		// Created / expires
		[CreatedLabel setStringValue:[[key creationDate] description]];
		if( [key expirationDate] != nil) {
			[ExpiresLabel setStringValue:[[key expirationDate] description]];
		} else { 
			[ExpiresLabel setStringValue:@"Never"];
		}
		
		// Set fingerprint text
		[fingerprintText setStringValue:[key formattedFingerprint]];
		
		if([key photoData] != nil) 
		{
			NSImage *img = [[NSImage alloc] initWithData:[key photoData]];
			//NSImage *img = [[NSImage  alloc] initWithContentsOfFile:@"/Users/jewart/Documents/Images/Avatars/RedC-Icon.jpg"];
			if ( img != nil ) 
			{
				NSLog(@"Succeeded in loading image data");

				[PictureWell setImage:img];
				[img release];
			} else { 
				NSLog(@"Problem loading image data");
			}

		}
		
		NSLog(@"Done setting key");
		[keyWindow update];
	}	
}

- (void)showWindow{
	
}

@end
