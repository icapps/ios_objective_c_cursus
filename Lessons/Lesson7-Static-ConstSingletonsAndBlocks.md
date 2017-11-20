# Lesson 7: Static, Const singletons and Blocks
previous: [Lesson 6: Overrides and Magic with categories](bear://x-callback-url/open-note?id=F768EBFA-53BC-4C89-B29B-35E862EA0D8C-2441-000003A6DA13F743)
next: [Praktische opdracht](bear://x-callback-url/open-note?id=E22CCB86-CFFA-4C9E-A195-C628EEA25FFB-1174-00000E0EAB80C00D)
- - - -
*  Verschil static en const en hoe gebruiken
* Singletons en hoe ze gebruik maken van static en const
* Block syntax in action
## Verschil static en const
### Const
```c++
int       *      mutable_pointer_to_mutable_int;
int const *      mutable_pointer_to_constant_int;
int       *const constant_pointer_to_mutable_int;
int const *const constant_pointer_to_constant_int;
```
Ook lastig is dat er 2 notaties zijn:
```c++
int const *      mutable_pointer_to_constant_int;
const int *      mutable_pointer_to_constant_int;
```
Beide betekenen hetzelfde 
### Static 
Dit wordt gebruikt om de naamgeving duidelijk een scope te geven. Als je in een header een waarde definieert die je global wil gebruiken. Met het woord static er voor gebeurd dit maar 1 keer in een gecompileerde source code. Zonder meerdere keren en kan duplicated symbols geven.
```objective-c
#import <UIKit/UIKit.h>
#import "TIITextFieldViewController.h"
#import "ObjcTextInput-Swift.h"


static int const globalValue = 10;
static int const * const global = &globalValue;

@interface TIIUIViewController : UIViewController <EditingValueFinishedDelegate, UICollectionViewDataSource>

@property (nonatomic) BOOL showPosts;

@end
```
- - - -
## Singletons
Dit werkt niet
```objective-c
static Post const * const globalPost = [[Post alloc] init];
```
Dit omdat Post een dynamische instantie is die niet at compile time gemaakt kan worden.
```objective-c
+(Post const * const)getSingletonConstantPointerPost {
    static Post const *  inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[Post alloc] initWithId:1
                                message:@"singleton instance"
                                  title:@"const pointer"
                                 userId:1];
    });
    return inst;
}
```
- - - -
## Block syntax
```objective-C
Foo * foo = [[Foo alloc] init];
Bar* (^variable)(Foo *) = ^ Bar* (foo) {
   Bar* bar = [[Bar alloc] init];
   // ..
    return bar
}
// gebruiken
Bar * bar = variable(foo)
```
- - - -
previous: [Lesson 6: Overrides and Magic with categories](bear://x-callback-url/open-note?id=F768EBFA-53BC-4C89-B29B-35E862EA0D8C-2441-000003A6DA13F743)
next: [Praktische opdracht](bear://x-callback-url/open-note?id=E22CCB86-CFFA-4C9E-A195-C628EEA25FFB-1174-00000E0EAB80C00D)