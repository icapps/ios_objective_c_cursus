# Lesson 4: Mapping, filtering, reduce, sort…
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
- [ ] Add an alternative

## Reduce
- [ ] Add an alternative

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

```objective-c
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self.collectionView reloadData];
		}];
```
