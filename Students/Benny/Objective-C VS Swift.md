# Objective-C vs Swift differences
---

This document contains a brief overview for the following differences between Objective-C and Swift:

* Classes
* Variables
* Functions
* Enumerations
* Debugging

## Classes

### Objective-C:

Objective-C abstracts a class's interface from it's implementation. This means that classes only provide essential information from the interface (.h file) while hiding details in the implementation file (.m file)

* Interface (.h file):


  ```Objective-C
  @interface Car: NSObject {
    // Add Protected instance variables here (not recommended)
  }
  // Add properties and methods here
  ```

* Implementation (.m file):

  ```Objective-C
  @implementation Car {
    // Define functions, properties, etc.
  }
  ```

* Initializing

  We allocate and initialize classes in an object of the class to access it's data members defined in the Interface.

  ```Objective-C
  Car car = [[Car alloc]init];     // Create car object of type Car
  ```

### Swift:

In Swift, there is no need to create interfaces or implementation files. It allows us to create a class as a single file while the external interface will be created by default once the class is initialized.

* Class (.swift file):

  ```Swift
  class Car {

  }
  ```

## Variables

All variables in Objective-C have to be typed, as opposed to Swift where they can be implicitly defined.

```Objective-C
NSString *aString = @"Some text"
```

```Swift
var aString = "Some text"
```

## Functions

##### Objective-C:
```Objective-C
- (int)addX:(int)x toY:(int)y { // (return type)methodName:(parameter1 type)(parameter1 name) ...
  int sum = x + y;
  return sum;
}
```

##### Swift:
```Swift
func add(_ x:Int, to y: Int) -> Int {
    let sum = x + y
    return sum
}
```

## Enumerations

TODO: Add Explanation

##### Objective-C:
```Objective-C
// add example
```

##### Swift:
```Swift
// add example
```

## Debugging

In Objective-C we need format specifiers to print out our code. These format specifiers include:

  * %@ (Objective-C Object)
  * %d (int)
  * %f (float, double)
  * ...

These are no longer necessary in Swift

##### Objective-C:
```Objective-C
NSLog(@"%@", aString) // prints: "Some text"
```

##### Swift:
```Swift
print(aString) // prints: "Some text"
```
