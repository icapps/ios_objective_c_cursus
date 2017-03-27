# Objective-C vs Swift differences
---

This document contains a brief overview for the following differences between Objective-C and Swift:

* [Classes](#Classes)

## <a name= "Classes"></a> Classes
---

TODO: Add Explanation

##### Objective-C:
```Objective-C
// add example
```

##### Swift:
```Swift
// add example
```

## Structures
---

TODO: Add Explanation

##### Objective-C:
```Objective-C
// add example
```

##### Swift:
```Swift
// add example
```


## Variables
---

All variables in Objective-C have to be typed, as opposed to Swift where they can be implicitly defined.

```Objective-C
NSString *aString = @"Some text"
```

```Swift
var aString = "Some text"
```

## Functions
---

TODO: Add Explanation

##### Objective-C:
```Objective-C
// add example
```

##### Swift:
```Swift
func someFunction(s:String, i: Int) -> Bool {
    ...    // code    
}
```

## Enumerations
---

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
---

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
