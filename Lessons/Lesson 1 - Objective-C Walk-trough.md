# Lesson 1 - Objective-C Walk-trough
> Next: [Lesson 2: How Apple teaches Objective-C](bear://x-callback-url/open-note?id=E347B683-AFB4-480D-86C7-48FEC8A1E120-46707-000020F9D8F4893C)  
- - - -
## Running into Objective-C from swift
As a funny intro to Objective-C checkout the following website
* http://fuckingblocksyntax.com
* http://fuckingclosuresyntax.com
- - - -
## We will now have a look at:
* Functions (Methods)  structures
* Pointers
* Types: Objective-C meets swift
* Instantiation and a look back at pointers
* Runtime
	* Swift Vs Objective-C: Short sighted view
* Externe links en referenties
- - - -
## ​Functions (Methods)  structures
```swift
func ships(atPoint bombLocation: CGPoint, withDamage damaged: Bool)
```

![](Lesson1Images/screenshot.png)

![](Lesson1Images/screenshot%201.png)

### Pointers VS Value type
Dit is in Swift veel beter gedefinieerd. In Objective-C mag alles!
#### Array’s
Best om dit te begrijpen is met een voorbeeld in array
```swift
let array: [String] = ["string"]
```
```objective-c
NSArray* array; //je moet het geen waarde geven
array = @[@"string"];
```
**In Objective-C kan je alles mixen in een array**

```objective-c
NSArray* array; //je moet het geen waarde geven
Foo* foo= [[Foo alloc] init];
array = @[@"string", 12, foo]
```
Dit zou in swift in een Any array kunnen:

```swift
let array: [Any] = ["string", 12]
```
##### Mutability
Arrays manipuleren maakt duidelijk dat er een verschil is tussen objective-C en swift

In objective-C heb je van veel classes een mutable tegenhanger
* NSMutableArray & NSArray
* NSMutableURlRequest * NSURLRequest

In swift is dit opgelost met `let` & `var`
- - - -
## Types: Objective-C meets swift
Je kan ook in Objective-C dezelfde type safety gaan opzoeken als in Swift. Daarvoor is er vorig jaar aan Objective-C een soort  [Leight Weigth Generics](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID173) toegevoegd.

```Objective-C
NSArray <NSString *> * array = @[@"string"]
```

Nu kan er in een array enkel een string **steken**
- - - -
## Instantiation and a look back at pointers
![](Lesson1Images/screenshot%202.png)

Zoals gezegd is objective-C een oude taal. Dus gaat zij er vanuit dat je alles begrijpt over memory.
* Plaats maken voor iets = **alloceren**
* Plaats opvullen met iets = **instantieren**
**Ook is code opgedeeld in 2 files**
* Hetgeen de buitenwereld moet weten om aan de code te kunnen
Om iets aan te maken als `Foo` heb je dus twee stappen nodig

```Objective-c
// in een file met extensie .h
@interface Foo: NSObject
// alles hierin is publiek
@end

// Als je toch private dingen wil hebben zet je die in dezelfde file

@interface Foo() // de haken zijn nodig maar magisch
@end
// Eventueel in tweede file
@implementation Foo

@end

```

![](Lesson1Images/screenshot%203.png)

![](Lesson1Images/screenshot%204.png)

Objective-C is veel dynamischer als Swift. Het heeft namelijk een runtime die bepaald hoe de code gaat werken. Dit is belangrijk voor Unit testing!!!
- - - -
### Swift Vs Objective-C: Short sighted view
> **Swift** -> Hoe de code gaat ‘draaien’ wordt bepaald wanneer je compileert  
> **Objective-C** -> de basis wordt opgezet maar tijdens het doorlopen van het programma kunnen er **alternatieve** paden aangebracht worden. Of anders de beslissing over welk code path er gevolgd zal worden wordt ad runtime gedaan.  
- - - -
## Externe links en referenties
* [Objective-C Tutorial | Code School](https://www.codeschool.com/courses/try-objective-c)
* [Videos | Ray Wenderlich](https://videos.raywenderlich.com)
* [Objective-C for Swift Developers | Udacity](https://www.udacity.com/course/objective-c-for-swift-developers--ud1009)
- - - -
> Next: [Lesson 2: How Apple teaches Objective-C](bear://x-callback-url/open-note?id=E347B683-AFB4-480D-86C7-48FEC8A1E120-46707-000020F9D8F4893C)  
