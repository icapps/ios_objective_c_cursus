# Lesson 4: Mapping, filtering, reduce, sort…
> Previous: [Lesson 3: Protocols and Bridging](bear://x-callback-url/open-note?id=06F79FE9-4A48-46E5-BAB0-3D111EA5947F-74998-00003292A1E8E08B)  

#Programming/Objective-C/Mapping&Filtering

1. Mapping
2. Filtering
3. Reduce
4. Sort
5. Lazy
6. QUEUE

**For Mapping, filtering, reduce**
Objective-C has no language support. This only came when Swift came out.
Code examples come form: [Lottie Dropper](https://github.com/icapps/ios_lottie_dropper)

## Mapping the Objective-C way
```objective-c
- (NSArray<NSString *> *)fileNames {
	NSMutableArray <NSString *> *mapped = [NSMutableArray arrayWithCapacity:[self.entries count]];
	[self.entries enumerateObjectsUsingBlock:^(DBFILESMetadata * obj, NSUInteger idx, BOOL *stop) {
		[mapped addObject:obj.name];
	}];
	return mapped;
}
```

## Filter
```objective-c
NSArray *filteredArray = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
    return [object shouldIKeepYou];  // Return YES for each object you want in filteredArray.
}]];
```
## Reduce
There is no alternative.
Challenge: Why don’t you find, make one!
## Sort
Also this is rather *nasty*in Objective-C. There are many options of which non is as readable as in swift `array.sort {$0 < $1}` translates to:

```objective-c
- (NSArray<DropboxDetailViewModel *> *)fileDetails {
// assume mapped is array of DropboxDetailViewModel's.
	NSComparisonResult (^sortBlock)(id, id) = ^(DropboxDetailViewModel * obj1, DropboxDetailViewModel * obj2)
	{
		return [[obj1 fileName] compare: [obj2 fileName]];
	};
	return [mapped sortedArrayUsingComparator:sortBlock];
}
```

## Lazy
**Does not exist in Objective-C**

But you can do it in code.

```objective-c
- (DBUserClient *)client {
	if (_client == nil) {
		NSString * accessToken = LottieDropperKeyChainBridge.shared.dropBoxAccessToken.accessToken;
		if (accessToken != nil) {
			_client = [[DBUserClient alloc] initWithAccessToken: accessToken];
		} else {
			NSLog(@" No Dropbox user client");
		}
	}
	return _client;
}
```

## QUEUE
You have GCD. Grand central dispatch. This is a relatively complex API in `C` . You can also use `NSOperation` 
### GCD
[Dispatch Queue Apple Documentation](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html)
#### Back to main
```objective-c
 dispatch_async(dispatch_get_main_queue(), ^{
             [peopleInArray addObject:<whatever>];
         });
```
#### To the background
```objective-c
		dispatch_queue_t getPeopleQueue = dispatch_queue_create("Pinta Ocupantes", NULL);
      dispatch_async(getPeopleQueue, ^{
           [self getPeople];
       });
```
### NSOperation
![](Lesson%204:%20Mapping,%20filtering,%20reduce,%20sort%E2%80%A6/NSOperation%20dependent%20ques.png)
[Operation - Foundation | Apple Developer Documentation](https://developer.apple.com/reference/foundation/operation)
#### Back to main
```objective-c
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self.collectionView reloadData];
	}];
```
#### To the background
[Block Operation | Apple Developer Documentation](https://developer.apple.com/reference/foundation/blockoperation)
```objective-c
NSOperationQueue * backgroundQUEUE [[NSOperationQueue alloc] init];
[backgroundQUEUE setName: @"Background QUEUE"];
NSBlockOperation * backgroundOperation = [[NSBlockOperation alloc] init]; 
[backgroundOperation addExecutionBlock: {
	// Perform background operation.
}];
[backgroundQUEUE addOperation: backgroundOperation];
[backgroundQUEUE start];
``` 
#### Extra: Dependencies
You can use a `NSBlockOperation` to do something like promises in other languages.
[addDependency(_:) - Operation | Apple Developer Documentation](https://developer.apple.com/reference/foundation/operation/1412859-adddependency)
```objective-c
NSBlockOperation * backgroundOperation = [[NSBlockOperation alloc] init]; 
[backgroundOperation addExecutionBlock: {
	NSLog(@"Operation 1 done");
}];
NSBlockOperation * backgroundOperation2 = [[NSBlockOperation alloc] init]; 
[backgroundOperation2 addExecutionBlock: {
		NSLog(@"Operation 3 done");
}];
NSBlockOperation * finalOperation = [[NSBlockOperation alloc] init]; 
[background setName: @"Final"];
[background addExecutionBlock: {
		NSLog(@"Operation 3 done");
}];
// Add dependencies
[finalOperation addDependency: backgroundOperation];
[finalOperation addDependency: backgroundOperation2];
// Add all operations to a queue
[backgroundQUEUE addOperation: backgroundOperation];
[backgroundQUEUE addOperation: backgroundOperation2];
[backgroundQUEUE addOperation: finalOperation];
[backgroundQUEUE start];
```
After Operation 1 & 2 are finished the finalOperation will be executed. Both operation 1&2 can be fired in parallel and asynchronous.
## Conclusion
* Mapping, filtering, reduce, sort is much more complex or even impossible in Objective-C
* Lazy is a concept used in Objective-C but not supported by the language like in Swift
* QUEUE’s are more handy then the cumbersome C like api of GCD.
> Next: [Lesson 5: Bridging](bear://x-callback-url/open-note?id=F7A57C55-7B50-47A0-A88B-23BB4FE5F477-6928-00001225859E2F76)  