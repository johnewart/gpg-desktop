//
//  GenerationWindowController.m
//  GPG Desktop
//
//  Created by John Ewart on 10/27/08.
//  Copyright 2008 23solutions. All rights reserved.
//

#import "GenerationWindowController.h"
#import "WindowController.h"

@implementation GenerationWindowController

- (void) awakeFromNib
{
	
	algoArray = [[NSArray alloc] initWithObjects:
					@"RSA", @"RSA-S", @"RSA-E", @"ELG-E", 
					@"DSA", @"DSS/DH", @"Elliptic", @"ECDSA", 
					@"ELG", @"DH", nil
				 ];
		
	for(int i = 0; i < [algoArray count]; i++) 
	{
		[keyType addItemWithTitle:(NSString *)[algoArray objectAtIndex:i]];
	}
	
}

- (IBAction)generateKey:(id)sender {
	
	NSLog(@"Generating GPG key...");
	
	NSString *name, *email, *comment, *passphrase, *confirmpass; 
	GPGContext *ctx = [[GPGContext alloc] init];
	
	name = [nameTF stringValue];
	email = [emailTF stringValue];
	comment = [commentTF stringValue];
	passphrase = [passphraseTF stringValue];
	confirmpass = [passphraseConfirmTF stringValue];
	
	NSNumber *keylen = [NSNumber numberWithInt:[[[keyLength selectedItem] title] intValue]];

	NSLog(@"Name: %@ Email: %@ Comment: %@ P: %@, CP: %@ Length: %@", name, email, comment, passphrase, confirmpass, keylen);
	
	NSNumber *algonum = [NSNumber numberWithInt:[self algorithmFromName:[[keyType selectedItem] title]]];
	
	if ([passphrase isEqualTo:confirmpass])
	{
		
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: 
								name, @"name", email, @"email", 
								comment, @"comment", passphrase, @"passphrase", 
								keylen, @"length", algonum, @"type", nil
								];
		
		NSLog(@"Generating key with params: %@", [params description]);
		
		NSDictionary *result = nil;
		result = [ctx generateKeyFromDictionary:params secretKey:nil publicKey:nil];
		
		if (result != nil) {
			NSLog(@"Generated key: %@", result);
		}
		
	} else {
		NSLog(@"Unable to create key, passphrases do not match!");
	}
	

}



- (GPGPublicKeyAlgorithm) algorithmFromName:(NSString *)name
{
	algoForNameDict = nil;
    NSNumber            *aNumber;
	
    if(algoForNameDict == nil)
        algoForNameDict = [[NSDictionary alloc] initWithObjectsAndKeys:
						   [NSNumber numberWithInt:GPG_RSAAlgorithm], @"RSA", // OK
						   [NSNumber numberWithInt:GPG_RSAEncryptOnlyAlgorithm], @"RSA-S",
						   [NSNumber numberWithInt:GPG_RSASignOnlyAlgorithm], @"RSA-E",
						   [NSNumber numberWithInt:GPG_ElgamalEncryptOnlyAlgorithm], @"ELG-E", // OK
						   [NSNumber numberWithInt:GPG_DSAAlgorithm], @"DSA", // OK
						   [NSNumber numberWithInt:GPG_DSAAlgorithm], @"DSS/DH", // OK; there are 2 names, but it's very complicated; google ("DSS/DH" DSA) to learn more
						   [NSNumber numberWithInt:GPG_EllipticCurveAlgorithm], @"Elliptic",
						   [NSNumber numberWithInt:GPG_ECDSAAlgorithm], @"ECDSA",
						   [NSNumber numberWithInt:GPG_ElgamalAlgorithm], @"ELG",
						   [NSNumber numberWithInt:GPG_DiffieHellmanAlgorithm], @"DH", nil];
	
    aNumber = [algoForNameDict objectForKey:name];
    if(aNumber == nil)
        return -1;
    else
        return [aNumber intValue];
}


@end
