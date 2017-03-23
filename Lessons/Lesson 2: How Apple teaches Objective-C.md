# Lesson 2: How Apple teaches Objective-C
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

![](Lesson%202:%20How%20Apple%20teaches%20Objective-C/screenshot.png)

* Object-Oriented C
* Retain and Release
* Properties
* Blocks
* ARC

## Method ordering
Before you had to put the method implementation or declaration before you use it. This is no longer needed.

```objective-c
@interface SongPlayer : NSObject- (void)playSong:(Song *)song;@end@implementation SongPlayer- (void)playSong:(Song *)song {  NSError *error;
 //In Old objective-C you would have to put this in the header or class extension  [self startAudio:&error];  ...}- (void)startAudio:(NSError **)error { ... }@end
```

Whats is a class extension?
When you write __()__ it is a class extension.
```objective-c
@interface SongPlayer ()- (void)startAudio:(NSError **)error;@end
```

## Enum with explicit types
```objective-c
enum {    NSNumberFormatterNoStyle,    NSNumberFormatterDecimalStyle,    NSNumberFormatterCurrencyStyle,    NSNumberFormatterPercentStyle,    NSNumberFormatterScientificStyle,    NSNumberFormatterSpellOutStyle};typedef NSUInteger NSNumberFormatterStyle;
```

Ok but butter to
```objective-c
typedef enum NSNumberFormatterStyle : NSUInteger {    NSNumberFormatterNoStyle,    NSNumberFormatterDecimalStyle,    NSNumberFormatterCurrencyStyle,    NSNumberFormatterPercentStyle,    NSNumberFormatterScientificStyle,    NSNumberFormatterSpellOutStyle} NSNumberFormatterStyle;
```
Because then you have Strong type checking

You can use them easily in switches:
```objective-c
 switch (style) {  case NSNumberFormatterNoStyle:    break;  case NSNumberFormatterSpellOutStyle:break; }
```

# Synthesize
We talked already about properties and their need for setters and getters:
Always write as less as possible:

```swift
@interface Person : NSObject@property(strong) NSString *name;@end@implementation Person@end
```

__But__!! for Core Data this is different!
### Core Data Synthesize

```objective-c
@interface Person : NSManagedObject@property(strong) NSString *name;@end@implementation Person
@dynamic name;@end
```

# Literals
## Single Literals
### Old NSNumber
```objective-c
NSNumber *value;value = [NSNumber numberWithChar:'X'];value = [NSNumber numberWithInt:12345];value = [NSNumber numberWithUnsignedLong:12345ul];value = [NSNumber numberWithLongLong:12345ll];value = [NSNumber numberWithFloat:123.45f];value = [NSNumber numberWithDouble:123.45];value = [NSNumber numberWithBool:YES];
```

### Much better
```objective-c
NSNumber *value;value = @'X';value = @12345;value = @12345ul;value = @12345ll;value = @123.45f;value = @123.45;value = @YES;
```

Also a calculation result can be boxed into an NSNumber
```objective-c
NSNumber *piOverSixteen = @( M_PI / 16 );
```

## Collection Literals
### OLD Array creation
```objective-c
NSArray *array;array = [NSArray array];array = [NSArray arrayWithObject:a];array = [NSArray arrayWithObjects:a, b, c, nil];id objects[] = { a, b, c };NSUInteger count = sizeof(objects) / sizeof(id);array = [NSArray arrayWithObjects:objects count:count];
```

### New Array creation
```objective-c
NSArray *array;array = @[];array = @[ a ];array = @[ a, b, c ];array = @[ a, b, c ];
```

### Old Dictionary creation
```objective-c
NSDictionary *dict;dict = [NSDictionary dictionary];dict = [NSDictionary dictionaryWithObject:o1 forKey:k1];dict = [NSDictionary dictionaryWithObjectsAndKeys:                       o1, k1, o2, k2, o3, k3, nil];id objects[] = { o1, o2, o3 };id keys[] = { k1, k2, k3 };NSUInteger count = sizeof(objects) / sizeof(id);dict = [NSDictionary dictionaryWithObjects:objects                                   forKeys:keys                                     count:count];
```

## New Dictionary creation
```objective-c
NSDictionary *dict;dict = @{};dict = @{ k1 : o1 };dict = @{ k1 : o1, k2 : o2, k3 : o3 };
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

## Constant Containers
```objective-c
// Will give an error
static NSArray * thePlanets = @[  @"Mercury", @"Venus", @"Earth",  @"Mars", @"Jupiter", @"Saturn",  @"Uranus", @"Neptune"];
```

__Use `+initialize`

```objective-c
@implementation MyClassstatic NSArray *thePlanets;+ (void)initialize {  if (self == [MyClass class]) {    thePlanets = @[      @"Mercury", @"Venus", @"Earth",      @"Mars", @"Jupiter", @"Saturn",      @"Uranus", @"Neptune"    ];} }
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
		weakSelf.model = model // this is a leak
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
• `@synthesize` by default• Forward declarations optional 
• Fixed underlying type enums • Literals and subscripting
• Boxed expressions • GC is deprecated
