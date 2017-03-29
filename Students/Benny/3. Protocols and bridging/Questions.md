# Questions

## Lesson 3:

1. Is there a difference between protocols in swift and protocols in Objective-C?

2. Why is using Introspection important when we already imported and conformed the ViewController to the "DropboxLoginable" protocol?

3. If modules are theoretically the better option over #import for things like UIKit, why do we still use #import <UIKit/UIKit.h>
?

## Lesson 4:

1. What's the importance of 'arrayWithCapacity' when mapping an array. Is this required?

2. Can you explain why we use an NSOperationQueue mainQueue and not simply dispatch the mainQueue in the following example?

```Objective-C
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self.collectionView reloadData];
		}];
```
