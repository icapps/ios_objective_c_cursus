# Lesson 3: Protocols and Bridging
> Previous: [Lesson 2: How Apple teaches Objective-C](bear://x-callback-url/open-note?id=E347B683-AFB4-480D-86C7-48FEC8A1E120-46707-000020F9D8F4893C)  
1. Protocols: Why use Introspection
2. Casting
3. Common patterns that are discouraged in Swift but used in Objective-C
4. Bridging between objective-C And Swift
5. How imports work and how are they different for Swift.
	1. Difference from Swift
	2. Header import
	3. Framework Header import
	4. (New) Modular import

#Programming/objective-c #Programmig/objective-c/Protocols #Programmig/objective-c/Introspection
#Programming/Objective-C/Modules

This lesson was deducted while building open-source app [LottyDropper](https://github.com/icapps/ios_lotty_dropper)

> Side node: *@runtime* means the time when the user is pressing buttons. *@compiletime* means the time the compiler is working (pressing buttons) and the user cannot do anything yet.  

- - - -

## Protocols: Why use Introspection
You can put them in separate header files:
```objective-c
@protocol DropboxLoginable <NSObject>

@end
```

Be sure to import them when using

```objective-c
#import <UIKit/UIKit.h>
#import "DropboxLoginable.h"

@interface ViewController : UIViewController <DropboxLoginable>

@end
```

### Introspection
See if an object implements a protocol, or a method in a protocol.

```objective-c
if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
				UINavigationController * nav = (UINavigationController *) self.window.rootViewController;
				if ([[nav.topViewController class] conformsToProtocol:@protocol(DropboxLoginable)]) {
					[nav.topViewController performSelector:@selector(proceed)];
				}
			}
```

`[nav.topViewController performSelector:@selector(proceed)];` the performSelector is something common in objective-c. This is done actually to *trick* the compiler. You can put in any selector and *@runtime* the special Objective-C runtime will try to look for **compiled code** to execute on the **target**. In the example above the target is `nav.topViewController`
#### Target: What is that?
A `target` is the object receiving messages. You know it from `@IBAction`. If you want to know more and understand the *magic* behind all of this [NSRunloop Apple docs](https://developer.apple.com/reference/foundation/nsrunloop?language=objc). But the main usefull points are:
1. [performSelector:target:argument:order:modes: - NSRunLoop | Apple Developer Documentation](https://developer.apple.com/reference/foundation/nsrunloop/1409310-performselector?language=objc)
```objective-c
if ([target canPerfromSelector:@selector(proceed)]) {
	// Do something
}
```
2. Use it to *bind* buttons to code
3. Use it on an array to perform a selector on any object in the array
```objective-c
NSArray *newArray = [[NSArray alloc] initWithArray:oldArray copyItems:YES];
[newArray makeObjectsPerformSelector:@selector(doSomethingToObject)];
```
4. [performSelector:withObject:afterDelay:inModes: - NSObject | Apple Developer Documentation](https://developer.apple.com/reference/objectivec/nsobject/1415652-performselector) Use it for delayed actions
```objective-c
[self performSelector:@selector(doSomethingToObject) 
           withObject:foo  
           afterDelay:15.0];
```
- - - -

## Casting
Casting is more implicit then it is in Swift. Why?
1. You have something like `id` that can be casted to anything, without the need to explicitly cast
```objective-c
id someObject = [NSMutableArray new]; // you don't need to cast id explicitly
```
2. Casting from an `int` to a `float` will work but you loose precision
```objective-c
int i = (int)19.5f; // (precision is lost)
```

## Common patterns that are discouraged in Swift but used in Objective-C
### Perform selector
It is very common to use this. Evan if it is dangerous because if the `target` does not implement the selector your app will crash. You use it mainly to see if an optional method from a protocol is implemented
### Casting from Array elements
GIVEN: You have an array of stuff could have all kinds of types
THEN: You loop trough the array
EXPECTED: You inspect every element if it is a kind of type. If it is the type you expect you perform an action 
```objective-c

for (object in objectArray) {
	if ([object isKindOfClass: [Foo class]) {
		// Do specific action for Foo
	} else  if ([object isKindOfClass: [Bar class]]){
		// Do something with a Bar.
	}
}
```
## Side node understand MVC Better.
I noticed in projects we do that MVC is used but not understand. In Dutch some notes and tips are given [Side note: MVC](bear://x-callback-url/open-note?id=E8982FEC-1725-4478-A6D4-661813D8BD26-6928-0000133C018EA631)
## Bridging between objective-C And Swift
### Why should we bridge?
Bridging add’s an extra layer of complexity over a project. But you can have good reason to do so. Here are a few of my favourites:

1. Use a TOP Swift only library/Framework/Pod/… 
2. Be more future prove.

### Example: Using the keychain
Using the keychain has always been a hassle.  @iCapps we build a handle Swift framework [Stella](https://github.com/icapps/ios-stella) that handles this nicely. Say for instance you want to store access tokens.

Using Objective-C only you would have to
> [Apple reference on keychain](https://developer.apple.com/library/content/documentation/Security/Conceptual/keychainServConcepts/iPhoneTasks/iPhoneTasks.html)  
```objective-c
#import <Foundation/Foundation.h>
#import <Security/Security.h>
 
//Define an Objective-C wrapper class to hold Keychain Services code.
@interface KeychainWrapper : NSObject {
    NSMutableDictionary        *keychainData;
    NSMutableDictionary        *genericPasswordQuery;
}
 
@property (nonatomic, strong) NSMutableDictionary *keychainData;
@property (nonatomic, strong) NSMutableDictionary *genericPasswordQuery;
 
- (void)mySetObject:(id)inObject forKey:(id)key;
- (id)myObjectForKey:(id)key;
- (void)resetKeychainItem;
 
@end
/* ********************************************************************** */
//Unique string used to identify the keychain item:
static const UInt8 kKeychainItemIdentifier[]    = "com.apple.dts.KeychainUI\0";
 
@interface KeychainWrapper (PrivateMethods)
 
 
//The following two methods translate dictionaries between the format used by
// the view controller (NSString *) and the Keychain Services API:
- (NSMutableDictionary *)secItemFormatToDictionary:(NSDictionary *)dictionaryToConvert;
- (NSMutableDictionary *)dictionaryToSecItemFormat:(NSDictionary *)dictionaryToConvert;
// Method used to write data to the keychain:
- (void)writeToKeychain;
 
@end
 
@implementation KeychainWrapper
 
//Synthesize the getter and setter:
@synthesize keychainData, genericPasswordQuery;
 
- (id)init
{
    if ((self = [super init])) {
 
        OSStatus keychainErr = noErr;
        // Set up the keychain search dictionary:
        genericPasswordQuery = [[NSMutableDictionary alloc] init];
        // This keychain item is a generic password.
        [genericPasswordQuery setObject:(__bridge id)kSecClassGenericPassword
                                 forKey:(__bridge id)kSecClass];
        // The kSecAttrGeneric attribute is used to store a unique string that is used
        // to easily identify and find this keychain item. The string is first
        // converted to an NSData object:
        NSData *keychainItemID = [NSData dataWithBytes:kKeychainItemIdentifier
                                  length:strlen((const char *)kKeychainItemIdentifier)];
        [genericPasswordQuery setObject:keychainItemID forKey:(__bridge id)kSecAttrGeneric];
        // Return the attributes of the first match only:
        [genericPasswordQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
        // Return the attributes of the keychain item (the password is
        //  acquired in the secItemFormatToDictionary: method):
        [genericPasswordQuery setObject:(__bridge id)kCFBooleanTrue
                                 forKey:(__bridge id)kSecReturnAttributes];
 
        //Initialize the dictionary used to hold return data from the keychain:
        CFMutableDictionaryRef outDictionary = nil;
        // If the keychain item exists, return the attributes of the item:
        keychainErr = SecItemCopyMatching((__bridge CFDictionaryRef)genericPasswordQuery,
                                         (CFTypeRef *)&outDictionary);
        if (keychainErr == noErr) {
            // Convert the data dictionary into the format used by the view controller:
            self.keychainData = [self secItemFormatToDictionary:(__bridge_transfer NSMutableDictionary *)outDictionary];
        } else if (keychainErr == errSecItemNotFound) {
            // Put default values into the keychain if no matching
            // keychain item is found:
            [self resetKeychainItem];
            if (outDictionary) CFRelease(outDictionary);
        } else {
            // Any other error is unexpected.
            NSAssert(NO, @"Serious error.\n");
            if (outDictionary) CFRelease(outDictionary);
        }
    }
    return self;
}
 
// Implement the mySetObject:forKey method, which writes attributes to the keychain:
- (void)mySetObject:(id)inObject forKey:(id)key
{
    if (inObject == nil) return;
    id currentObject = [keychainData objectForKey:key];
    if (![currentObject isEqual:inObject])
    {
        [keychainData setObject:inObject forKey:key];
        [self writeToKeychain];
    }
}
 
// Implement the myObjectForKey: method, which reads an attribute value from a dictionary:
- (id)myObjectForKey:(id)key
{
    return [keychainData objectForKey:key];
}
 
// Reset the values in the keychain item, or create a new item if it
// doesn't already exist:
 
- (void)resetKeychainItem
{
    if (!keychainData) //Allocate the keychainData dictionary if it doesn't exist yet.
    {
        self.keychainData = [[NSMutableDictionary alloc] init];
    }
    else if (keychainData)
    {
        // Format the data in the keychainData dictionary into the format needed for a query
        //  and put it into tmpDictionary:
        NSMutableDictionary *tmpDictionary =
                            [self dictionaryToSecItemFormat:keychainData];
        // Delete the keychain item in preparation for resetting the values:
        OSStatus errorcode = SecItemDelete((__bridge CFDictionaryRef)tmpDictionary);
        NSAssert(errorcode == noErr, @"Problem deleting current keychain item." );
    }
 
    // Default generic data for Keychain Item:
    [keychainData setObject:@"Item label" forKey:(__bridge id)kSecAttrLabel];
    [keychainData setObject:@"Item description" forKey:(__bridge id)kSecAttrDescription];
    [keychainData setObject:@"Account" forKey:(__bridge id)kSecAttrAccount];
    [keychainData setObject:@"Service" forKey:(__bridge id)kSecAttrService];
    [keychainData setObject:@"Your comment here." forKey:(__bridge id)kSecAttrComment];
    [keychainData setObject:@"password" forKey:(__bridge id)kSecValueData];
}
 
// Implement the dictionaryToSecItemFormat: method, which takes the attributes that
// you want to add to the keychain item and sets up a dictionary in the format
// needed by Keychain Services:
- (NSMutableDictionary *)dictionaryToSecItemFormat:(NSDictionary *)dictionaryToConvert
{
    // This method must be called with a properly populated dictionary
    // containing all the right key/value pairs for a keychain item search.
 
    // Create the return dictionary:
    NSMutableDictionary *returnDictionary =
                   [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
 
    // Add the keychain item class and the generic attribute:
    NSData *keychainItemID = [NSData dataWithBytes:kKeychainItemIdentifier
                              length:strlen((const char *)kKeychainItemIdentifier)];
    [returnDictionary setObject:keychainItemID forKey:(__bridge id)kSecAttrGeneric];
    [returnDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
 
    // Convert the password NSString to NSData to fit the API paradigm:
    NSString *passwordString = [dictionaryToConvert objectForKey:(__bridge id)kSecValueData];
    [returnDictionary setObject:[passwordString dataUsingEncoding:NSUTF8StringEncoding]
                                                           forKey:(__bridge id)kSecValueData];
    return returnDictionary;
}
 
// Implement the secItemFormatToDictionary: method, which takes the attribute dictionary
//  obtained from the keychain item, acquires the password from the keychain, and
//  adds it to the attribute dictionary:
- (NSMutableDictionary *)secItemFormatToDictionary:(NSDictionary *)dictionaryToConvert
{
    // This method must be called with a properly populated dictionary
    // containing all the right key/value pairs for the keychain item.
 
    // Create a return dictionary populated with the attributes:
    NSMutableDictionary *returnDictionary = [NSMutableDictionary
                                          dictionaryWithDictionary:dictionaryToConvert];
 
    // To acquire the password data from the keychain item,
    // first add the search key and class attribute required to obtain the password:
    [returnDictionary setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [returnDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    // Then call Keychain Services to get the password:
    CFDataRef passwordData = NULL;
    OSStatus keychainError = noErr; //
    keychainError = SecItemCopyMatching((__bridge CFDictionaryRef)returnDictionary,
                                       (CFTypeRef *)&passwordData);
    if (keychainError == noErr)
    {
        // Remove the kSecReturnData key; we don't need it anymore:
        [returnDictionary removeObjectForKey:(__bridge id)kSecReturnData];
 
        // Convert the password to an NSString and add it to the return dictionary:
        NSString *password = [[NSString alloc] initWithBytes:[(__bridge_transfer NSData *)passwordData bytes]
                 length:[(__bridge NSData *)passwordData length] encoding:NSUTF8StringEncoding];
        [returnDictionary setObject:password forKey:(__bridge id)kSecValueData];
    }
    // Don't do anything if nothing is found.
    else if (keychainError == errSecItemNotFound) {
            NSAssert(NO, @"Nothing was found in the keychain.\n");
            if (passwordData) CFRelease(passwordData);
    }
    // Any other error is unexpected.
    else
    {
        NSAssert(NO, @"Serious error.\n");
        if (passwordData) CFRelease(passwordData);
    }
 
    return returnDictionary;
}
 
// Implement the writeToKeychain method, which is called by the mySetObject routine,
//   which in turn is called by the UI when there is new data for the keychain. This
//   method modifies an existing keychain item, or--if the item does not already
//   exist--creates a new keychain item with the new attribute value plus
//  default values for the other attributes.
- (void)writeToKeychain
{
    CFDictionaryRef attributes = nil;
    NSMutableDictionary *updateItem = nil;
 
    // If the keychain item already exists, modify it:
    if (SecItemCopyMatching((__bridge CFDictionaryRef)genericPasswordQuery,
                           (CFTypeRef *)&attributes) == noErr)
    {
        // First, get the attributes returned from the keychain and add them to the
        // dictionary that controls the update:
        updateItem = [NSMutableDictionary dictionaryWithDictionary:(__bridge_transfer NSDictionary *)attributes];
 
        // Second, get the class value from the generic password query dictionary and
        // add it to the updateItem dictionary:
        [updateItem setObject:[genericPasswordQuery objectForKey:(__bridge id)kSecClass]
                                                          forKey:(__bridge id)kSecClass];
 
        // Finally, set up the dictionary that contains new values for the attributes:
        NSMutableDictionary *tempCheck = [self dictionaryToSecItemFormat:keychainData];
        //Remove the class--it's not a keychain attribute:
        [tempCheck removeObjectForKey:(__bridge id)kSecClass];
 
        // You can update only a single keychain item at a time.
        OSStatus errorcode = SecItemUpdate(
            (__bridge CFDictionaryRef)updateItem,
            (__bridge CFDictionaryRef)tempCheck);
        NSAssert(errorcode == noErr, @"Couldn't update the Keychain Item." );
    }
    else
    {
        // No previous item found; add the new item.
        // The new value was added to the keychainData dictionary in the mySetObject routine,
        // and the other values were added to the keychainData dictionary previously.
        // No pointer to the newly-added items is needed, so pass NULL for the second parameter:
        OSStatus errorcode = SecItemAdd(
            (__bridge CFDictionaryRef)[self dictionaryToSecItemFormat:keychainData],
            NULL);
        NSAssert(errorcode == noErr, @"Couldn't add the Keychain Item." );
        if (attributes) CFRelease(attributes);
    }
}
 
 
@end
```

### Using Stella

Like in the above example we write a `Wrapper` to access keychain data
```swift
import Foundation
import Stella

extension Keys {
	static let dropBoxAccessToken = Key<String?>("dropBoxAccessToken")
	static let dropBoxAccessTokenUID = Key<String?>("dropBoxAccessTokenUID")
}

class LottieDropperKeyChainBridge: NSObject {
	static let shared = LottieDropperKeyChainBridge()

	var dropBoxAccessToken: DBAccessToken? {
		get {
			guard let token = Keychain[.dropBoxAccessToken], let uid = Keychain[.dropBoxAccessTokenUID] else {
				return nil
			}
			return DBAccessToken(accessToken: token , uid:uid)
		}

		set {
			Keychain[.dropBoxAccessToken] = newValue?.accessToken
			Keychain[.dropBoxAccessTokenUID] = newValue?.uid
			
		}
	}

}
```

Now that this is done in `Objective-C` we can write:

```objective-c
			LottieDropperKeyChainBridge.shared.dropBoxAccessToken = authResult.accessToken;
```

### Conclusion
Writing secure code should be easy. Not having to write complex Keychain code is one of that reasons. This is why bridging to Swift is allowed in this case.
- - - -
## How imports work and how are they different for Swift. 
1. [Modules and Precompiled Headers](https://useyourloaf.com/blog/modules-and-precompiled-headers/) Very good comparison between old and new
2. [Modules — Clang 5 documentation](https://clang.llvm.org/docs/Modules.html#objective-c-import-declaration) Full explanation about what a module is and what its advantages are.

### Difference from Swift
In swift you do not import Headers. Swift imports modules
> **Objective-C** has no namespace!. A namespace is a part of the compiled code where your `Symbols` are uniquely named.  
*So what is a Symbol*
> A `Symbol` is a reference the compiler uses to find the binary reference of your code.  
```objective-c
@interfase UIViewController
@end

// Inside the UIKit framework a viewcontroller exists. This would not compile!
```

Compiler keeps track of names of classes:
* `UIViewController`
* `Foo`

```swift

// We are inside module Lesson
import UIKit
class UIViewController {
}

// This will compile
```

* `Lesson.UIViewController`
* `Lesson.Foo`

This is why in Objective-C importing is more important. And you should also be more careful with imports.  More detailed info can be found in the link [4 Ways Precompiled Headers Cripple Your Code](http://qualitycoding.org/precompiled-header/). But in general:

1. Only import the stuff you **need!**
2. **Clean up** imports if you do not use the files any more
Kind of imports in Objective-C:
> The `#import` directive used by Objective-C is almost identical to the classic `#include` mechanism it inherited from the C programming language.  The only difference is that it makes sure the same file is never included more than once.   

```objective-c
#import "Foo.h" // A file you own and is in your project
#import <UIKit/UIKit.h> // A file inside a framework/module
// If this framework is a module you can write
@import UIKit
```

The `@import UIKit` is preferred for 2 reasons:
1. More modern
2. Modules are precompiled and the compiler does some optimisations so compile time is better

#### How to use modules
> Opting into using modules is as easy as setting the Apple LLVM 6.0 - Language - Modules Xcode build settings:  

[Modules and Precompiled Headers](https://useyourloaf.com/blog/modules-and-precompiled-headers/)

### Prefix header
A prefix header is **something of the past** and you should avoid using it! But you can encounter it in projects. So what is it?

It is a file ending with `.pch` and usually starts with the project name. You let the compiler know this file exists via the build settings. 
In this file you write imports that the compiler will add to every file in your project.
## @class? why use that?
As you make files, header and implementation files the number of imports in the header can become long. Plus you also might import things you do not know. Sometimes this goes wrong!

```objective-c
#import Bar.h
@interface Foo 
@end

/// Next file 
#import "Foo.h"
@interface Bar
@porperty (nonatomic, strong) Foo* foo;
@end
```
The above example will go wrong for `Foo`. As `Foo` Header also imports the `Foo.h` header when it imports `Bar.h`!!

A way to solve this problem is write in the `@class Foo` in the `Bar` header.

```objective-C
@class Foo;
@interface Bar
@porperty (nonatomic, strong) Foo* foo;
@end
````

The `@class Foo` tells the compiler that you promise by the time the implementation has been reached you will have imported the header of `Foo`

So in the implementation of `Bar` you do

```objective-c
#import "Foo.h"
@implementation Bar 
@end
```

# Whats next
[Lesson 4: Mapping, filtering, reduce, sort…](bear://x-callback-url/open-note?id=E7068AAC-C318-4475-8EB7-C44574EF845F-1071-00000EABCC3CD0F8)




