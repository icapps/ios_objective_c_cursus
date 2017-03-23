## Objective-C classes:
## .h file:
*  The public file where you define your implementations of the .m file you want to use outside of this class.
```Objective-C
    @interface ViewController: UIViewController
    @end
    ```

## .m file:
* @interface: This is where you define your private properties.

  ```Objective-C
    @interface ViewController()
    @end
  ```

* @implementation: This is where you define your functions etc.

  ```Objective-C
    @implementation ViewController
    @end
  ```

## Swift classes:

```Swift
class ViewController: UIViewController {

}
```

## Objective-C functions + actions + outlets:
##### functions:
```Objective-C
-(void)doSomethingWith: (NSArray*)property {
    // property is the name of the array type we want to use.
}
```  
##### actions:

```Objective-C
- (IBAction)buttonPressed:(id)sender {
  // short way = - (IBAction)buttonPressed;
}
```  
##### outlets:

```Objective-C
@property (weak, nonatomic) IBOutlet UILabel *label;
// label is the name to link to this outlet.
```

## Swift functions + actions + outlets:
##### functions:
```Swift
func doSomething(with property: Array) {
}
```

##### actions:
```Swift
@IBAction func buttonPressed(sender: AnyObject) {
}
```

#### outlets:
```Swift
@IBOutlet weak var label: UILabel!
```

## Variables

#### Objective-C:

```Objective-C
@property (strong, nonatomic) NSString* string;
```

#### Swift:

```Swift
var string: String
```
