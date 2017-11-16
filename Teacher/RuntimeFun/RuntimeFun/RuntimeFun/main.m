//
//  main.m
//  RuntimeFun
//
//  Created by Stijn Willems on 16/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <Foundation/Foundation.h>

@interface Book : NSObject
{
    NSMutableDictionary *data;
}
@property (retain) NSString *title;
@property (retain) NSString *author;
@end

@implementation Book
@dynamic title, author;

- (id)init
{
    if ((self = [super init])) {
        data = [[NSMutableDictionary alloc] init];
        [data setObject:@"Tom Sawyer" forKey:@"title"];
        [data setObject:@"Mark Twain" forKey:@"author"];
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSString *sel = NSStringFromSelector(selector);
    if ([sel rangeOfString:@"set"].location == 0) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *key = NSStringFromSelector([invocation selector]);
    if ([key rangeOfString:@"set"].location == 0) {
        key = [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
        NSString *obj;
        [invocation getArgument:&obj atIndex:2];
        [data setObject:obj forKey:key];
    } else {
        NSString *obj = [data objectForKey:key];
        [invocation setReturnValue:&obj];
    }
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {

        Book *book = [[Book alloc] init];
        printf("%s is written by %s\n", [book.title UTF8String], [book.author UTF8String]);
        book.title = @"1984";
        book.author = @"George Orwell";
        printf("%s is written by %s\n", [book.title UTF8String], [book.author UTF8String]);

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
