# BLOCKS - VS Closures

* http://fuckingblocksyntax.com
* http://fuckingclosuresyntax.com

## ​Method structure
![](Lesson%201%20-%20Objective-C%20Foundation%20via%20Mocks/screenshot.png)

![](Lesson%201%20-%20Objective-C%20Foundation%20via%20Mocks/screenshot%201.png)


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

##### Objective-C meets swift
Je kan ook in Objective-C dezelfde type safety gaan opzoeken als in Swift. Daarvoor is er vorig jaar aan Objective-C een soort  [Leight Weigth Generics](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID173) toegevoegd.

```Objective-C
NSArray <NSString *> * array = @[@"string"]
```

Nu kan er in een array enkel een string *steken*

### Instantiation and now finally about pointers and value types
![](Lesson%201%20-%20Objective-C%20Foundation%20via%20Mocks/screenshot%202.png)

Zoals gezegd is objective-C een oude taal. Dus gaat zij er vanuit dat je alles begrijpt over memory. 
* Plaats maken voor iets = *alloceren*
* Plaats opvullen met iets = *instantieren*

Ook is code opgedeeld in 2 files
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

![](Lesson%201%20-%20Objective-C%20Foundation%20via%20Mocks/screenshot%203.png)

![](Lesson%201%20-%20Objective-C%20Foundation%20via%20Mocks/screenshot%204.png)

Objective-C is veel dynamischer als Swift. Het heeft namelijk een runtime die bepaald hoe de code gaat werken. Dit is belangrijk voor Unit testing!!!

* Swift: -> Hoe de code gaat ‘draaien’ wordt bepaald wanneer je compileerd
* Objective-C: -> de basis wordt opgezet maar tijdens het doorlopen van het programma kunnen er *alternatieve* paden aangebracht worden. Of anders de beslissing over welk code path er gevolgd zal worden wordt ad runtime gedaan.

# Uitdaging: Gebruiken bij unit testen
Om dit beter te begrijpen is het gemakkelijkste dat we unit testen beginnen schrijven.

[OCMOCK](http://ocmock.org/introduction/) is een framework dat je toe laat met de RunTime te spelen. Dit kan je ook *Dependency Injection* noemen als je graag hebt dat mensen je niet snappen en slim vinden.

## Opdracht
* Maak objective-C project
* Maak een unit test target
* `pod init`
* voeg OCMock toe via `pod 'OCMock', '~> 3.4’`
* voeg Quick en Nimble toe
* doe pod project open en verander voor Quick en Nimble de `Us legacy Swift` naar YES

Wat ga je maken:
1. TableView die labels vult vanaf een viewModel
2. ViewModel ga je testen op basis van OCMock en OCMSTub [Stubbing](http://ocmock.org/reference/#stubing-methods) [Mock Objects](http://ocmock.org/reference/#creating-mock-objects)
3. Toon het aantal cellen vanaf het viewModel

Uitbreiding:
1. Voeg Faro toe
2. Maak een Mock van Faro
3. Doe een `gemockte` service call











