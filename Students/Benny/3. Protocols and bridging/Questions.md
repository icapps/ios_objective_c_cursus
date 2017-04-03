# Questions

## Lesson 3:

1. Is there a difference between protocols in swift and protocols in Objective-C?

2. Why is using Introspection important when we already imported and conformed the ViewController to the "DropboxLoginable" protocol?

3. Can't you just cast the nav.topViewController to the desired class instead?

4. If performSelector has no target given, will it use the target it is being called from? e.g.
```Objective-C
[aClass performSelector: @selector(aSelector)];
```

5. If modules are theoretically the better option over #import for things like UIKit, why do we still use #import <UIKit/UIKit.h>?



## Lesson 4:

1. What's the importance of 'arrayWithCapacity' when mapping an array. Is this required?

2. Can you explain why we use an NSOperationQueue mainQueue and not simply dispatch the mainQueue in the following example?

```Objective-C
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self.collectionView reloadData];
		}];
```

3. Explain the difference between NSOperation and GDC please.

4. NSDictionary 'bindings' argument in NSPredicate filtering?

## SideNote

1. When having to react to delegates, like for example UITextFieldDidEndEditing(), it seems unlikely that you're not going to retain your viewModel inside the collectionViewCell. Isn't "never" a bit harsh?

2. So when only displaying a certain amount of data ,structs are the way to go, but as soon as we need to display more or edit data , viewModel?
