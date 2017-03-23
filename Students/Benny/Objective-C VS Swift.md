# Objective-C VS Swift differences

## Variables

All variables in Objective-C have to be typed, as opposed to Swift where they can be implicitly defined.

```Objective-C
NSString *aString = @"Some text"
```

```Swift
var aString = "Some text"
```
## Debugging

In Objective-C we need format specifiers to print out our code. These format specifiers include:

  * %@ (Objective-C Object)
  * %d (int)
  * %f (float, double)
  * ...

These are no longer nessecary in Swift

```Objective-C
NSLog(@"%@", aString) // prints: "Some text"
```

```Swift
print(aString)
```
