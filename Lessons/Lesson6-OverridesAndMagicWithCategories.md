# Lesson 6: Overrides and Magic with categories
Previous:  [Lesson 5: Bridging Objectiv-C  <-> Swift](bear://x-callback-url/open-note?id=F7A57C55-7B50-47A0-A88B-23BB4FE5F477-6928-00001225859E2F76)
Next: [Lesson 7: Static, Const singletons and Blocks](bear://x-callback-url/open-note?id=A88D4654-FAE2-4BC8-A160-701B091E6809-1174-000001250A06170C)
- - - -
## What will we do
* Dive into setters and getters
* Categories
	* Verschil met protocol extensions
* Overrides
* For statement
### Setters en getters override
```objective-c
// Begin Header
@interface TIILabel : UILabel
@property (nonatomic, strong) UIColor* colorOne;
@end
// end header
@interface TIILabel ()
@property BOOL invert;
@property (nonatomic, strong) UIColor* colorTwo;

@end
@implementation TIILabel
@synthesize colorOne = _colorOne;

-(UIColor *)colorTwo {
    if (_colorTwo == nil) {
        _colorTwo = UIColor.blackColor;
    }
    return _colorTwo;
}

-(UIColor *)colorOne {
    if (_colorOne == nil) {
        _colorOne = UIColor.brownColor;
    }
    return _colorOne;
}

-(void)setColorOne:(UIColor *)colorOne {
    _colorOne = colorOne;
    _colorTwo = UIColor.blueColor;
}
-(NSString *)text {
    return super.text;
}
-(void)setText:(NSString *)text {
    self.invert = !self.invert;
    self.textColor = self.invert ? self.colorOne : UIColor.blackColor;
    super.text = text;
}
@end
```
- - - -
## Category
Waarom zouden we een category gebruiken?
```objective-c
#import "ObjcTextInput-Swift.h"
@class Post;
@interface Post (Post_Service)
- (void) print:(NSArray <Post *>* )array;
@end
#import "Post+Post_Service.h"
#import "ObjcTextInput-Swift.h"
@implementation Post (Post_Service)
-(void) print:(NSArray <Post *>* )array {
    for (NSInteger i = 0; i< array.count; i++) {
        NSLog(@"%@", array[i]);
    }
    for (Post* post in array) {
        NSLog(@"%@", post);
    }
}
@end
```
Dus dit is hoe het werkt. Waarom je het zou gebruiken kan je merken als je de category op **UIImageView** bekijkt op github:
[GitHub - mbcharbonneau/UIImage-Categories: 🛠 A fork of Trevor Harmon’s UIImage category methods, updated for the latest versions of iOS.](https://github.com/mbcharbonneau/UIImage-Categories)
### Hoe verschilt category van swift extension
* Een extension in swift kan geen methoden overschrijven van de class. In swift kan dit wel.
* Category op Int of NSString zijn niet mogelijk, extensions wel
* Category is een header en een implementation file. Extension is enkel een implementatie.
* Een protocol extension is eigenlijk een Category want zij bevat een header, het protocol, en de extension, de implementatie
```swift
protocol Proto {
func pop(foo: Foo) -> Bar
}
extension Proto {
func pop(foo: Foo) -> Bar {
	return Bar(foo)
}
```
Dit wordt in objective-c
```objective-c
@interface Proto
- (Bar *) popFoo: (Foo*) foo;
@end
@implementation
- (Bar*) popFoo:(Foo*) foo {
	return [[Bar alloc] initWithFoo: foo];
}
@end
```
* Category geldt enkel waar je de header implementeert. Extension geld direct binnen de hele module.
- - - -
## Overrides
In objective-c kan je alles overriden van de super class. Dus alle gedrag van Foundation/cocoa kan je aanpassen, niets is final.
- - - -
## Hoe gebruik je een for statement
```objective-c
 for (NSInteger i = 0; i< array.count; i++) {
        NSLog(@"%@", array[i]);
    }

    for (Post* post in array) {
        NSLog(@"%@", post);
    }
```
- - - -
Previous:  [Lesson 5: Bridging Objectiv-C  <-> Swift](bear://x-callback-url/open-note?id=F7A57C55-7B50-47A0-A88B-23BB4FE5F477-6928-00001225859E2F76)
Next: [Objc-Fun: Questions and wishes](bear://x-callback-url/open-note?id=A88D4654-FAE2-4BC8-A160-701B091E6809-1174-000001250A06170C)
