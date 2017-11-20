# Lesson 2: How Apple teaches Objective-C
#Programming/objective-c

* [WWDC 2012 video 405](https://developer.apple.com/videos/play/wwdc2012/405/)
* [Apple Conceptual intro to objective-C](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)

## As a preparation for this lesson you can do:
1. Google drive SDK voor objective-C opzoeken
2. . Lottie van AirBnb opzoeken en beschikbaar voor Objective-C
3. Plannetje op papier hoe je de app zou bouwen
4.  Lijstje maken met dingen die je in Swift doet en hoe je die zou doen in objective-c
5. 

# WWDC video
<a href='Lesson%202:%20How%20Apple%20teaches%20Objective-C/session_405__modern_objectivec.pdf'>session_405__modern_objectivec.pdf</a>

![](Lesson%202:%20How%20Apple%20teaches%20Objective-C/Lesson%202:%20How%20Apple%20teaches%20Objective-C/screenshot.png)

* Object-Oriented C
* Retain and Release
* Properties
* Blocks
* ARC
## By reference pointer
```swift
var array = ["C", "d", "A"]
func sort(_ array: [String]) -> [String] {
		return array.sort{<}
}
sort(array)
// print(Array) -> ["C", "d", "A"]
array = sort(array)
// print(Array) -> [ "A", "C", "d"]
func sortInOut(_ array: inout[String]) {
		array.sort{<}
}
sortInOut(array)
// print(Array) -> [ "A", "C", "d"]
````
## Method ordering
Before you had to put the method implementation or declaration before you use it. This is no longer needed.

```objective-c
@interface SongPlayer : NSObject
 //In Old objective-C you would have to put this in the header or class extension
```

Whats is a class extension?
When you write __()__ it is a class extension.
```objective-c
@interface SongPlayer ()
```

## Enum with explicit types
```objective-c
enum {
```

Ok but butter to
```objective-c
typedef enum NSNumberFormatterStyle : NSUInteger {
```
Because then you have Strong type checking

You can use them easily in switches:
```objective-c
 switch (style) {
			break; // Best altijd schrijven want is fall through!!!
			[foo spell];
}
```

# Synthesize
```swift
@interface Person : NSObject
-(Foo*)foo {
	return _foo;
}
-(void) setFoo:(Foo *) value {
	_foo = value
}
// Is hetzelfde als @syntesize foo = _foo;

- (void) function {
	NSLog(@"%@", self.foo);
}
```
Always write as less as possible:

```swift
@interface Person : NSObject
```

__But__!! for Core Data this is different!
### Core Data Synthesize

```objective-c
@interface Person : NSManagedObject
@dynamic name;
```

# Literals
## Single Literals
### Old NSNumber
```objective-c
NSNumber *value;
```

### Much better
```objective-c
NSNumber *value;
```

Also a calculation result can be boxed into an NSNumber
```objective-c
NSNumber *piOverSixteen = @( M_PI / 16 );
```
### Why use NSNumber
1. To store in Core data. You cannot store a Bool, but you can store @YES (is 1 internally)
2. JSON can be made from NSNumber property, not from int
## Collection Literals
### OLD Array creation
```objective-c
NSArray *array;
```

### New Array creation
```objective-c
NSArray *array;
```

### Old Dictionary creation
```objective-c
NSDictionary *dict;
```

## New Dictionary creation
```objective-c
NSDictionary *dict;
```

### Mutable Collections
Use `-mutableCopy`

```objective-c
NSMutableArray *array = [@[1,2] mutableCopy];
```

Then you can do:
```objective-c
[array append: 3];
```

## Write initializers
```swift
class Foo {
	let name: String
	init(name: String) {
		self.name = name	
	}
}
```
In objective-c
[Object Initialization](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Initialization/Initialization.html)
```objective-c
@interface Foo: NSObject // File 1
@property (nonatomic, strong) NSSString * name;
@end
@implementation Foo // File 2

-(id)init:(NSString *) name {
id anObject = [[Foo alloc] init];
if (anObject) {
anObject.name = name    // more messages...
} else {
    // handle error
return nil
}
return anObject
}

// Shorter version
-(id)init:(NSString *) name {
if (self = [super init]) {
self.name = name    // more messages...
} else {
    // handle error
	return nil
}
return return self
}
@end
```
## Constant Containers
```objective-c
// Will give an error
static NSArray * thePlanets = @[
```

__Use `+initialize`

```objective-c
@implementation MyClass
 (void)initialize {
```

This does __NOT__ work for Dictionaries because of compiler optimalizations  [See WWDC 2012 video 405](https://developer.apple.com/videos/play/wwdc2012/405/)

## Subscripting and object literals, boxed expressions
With dictionaries and arrays you can do:
__Array__
```objective-c
NSArray* array = @[@1,@2];
NSLog(@"%@", array[1]) // will print 2
```
__Dictionary__
```objective-c
NSDictionary* dict = @{"first": @1, "second": @2}
NSLog(@"%@", dict[@"second"]) // will print 2
```

!! You can make your class _Subscriptable__  [See WWDC 2012 video 405](https://developer.apple.com/videos/play/wwdc2012/405/)

# ARC: Automatic Reference Counting
In Objective-C __AND__ Swift you have the __SAME__ memory management!!!!
Swift is no better at handling memory then Objective-C, it just has some language features like @escaping and the use of self to help you.

## How to make a memory leak?
```objective-c

@interface Foo () 
@property (nonatomic, strong) Service* service;
@property (nonatomic, strong) Model* model;
@end

@implementation 

- (void) load {
	self.service = [[Service alloc] init];
	[self.service perform: ^ {(Model* model) in
		self.model = model // this is a leak
	}];
}
@end
```

### How to fix it?

```objective-c
@interface Foo () 
@property (nonatomic, strong) Service* service;
@property (nonatomic, strong) Model* model;
@end

@implementation 

- (void) load {
	self.service = [[Service alloc] init];
  weak Foo* weakSelf = self
	[self.service perform: ^ {(Model* model) in
		weakSelf.model = model // this is the fix for the leak
	}];
}
@end
```

When you use see memory management becomes more difficult [See WWDC 2012 video 405](https://developer.apple.com/videos/play/wwdc2012/405/)

It bowls down to using stuff like:
```objective-c
NSArray *people = CFBridgingRelease( ABAddressBookCopyPeopleWithName(addressBook,CFSTR("Appleseed")));
```

# Summary
• `@synthesize` by default
• Fixed underlying type enums 
• Literals and subscripting
• Boxed expressions 
# Next
[Lesson 3: Protocols and Bridging](bear://x-callback-url/open-note?id=06F79FE9-4A48-46E5-BAB0-3D111EA5947F-74998-00003292A1E8E08B)
