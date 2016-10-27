//
//  TAAAppearanceProxy.m
//  TAAAppearanceProxy
//
//  Created by Elliot Neal on 26/10/2016.
//  Copyright © 2016 Ticket Arena LTD. All rights reserved.
//

#import "TAAAppearanceProxy.h"


@interface TAAAppearanceProxy ()


- (instancetype)initWithClass:(Class)klass;

@property (strong, nonatomic) Class klass;
@property (strong, nonatomic) NSMutableArray<NSInvocation *> *invocations;

@end


@implementation TAAAppearanceProxy


+ (id)proxyForClass:(Class)klass {
    
    NSString *key = NSStringFromClass(klass);
    id proxy = self.proxies[key];
    
    if (!proxy) {
        proxy = [[self alloc] initWithClass:klass];
        self.proxies[key] = proxy;
    }
    
    return proxy;
}

+ (NSMutableDictionary<NSString *, TAAAppearanceProxy *> *)proxies {
    
    static NSMutableDictionary<NSString *, TAAAppearanceProxy *> *proxies = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        proxies = [[NSMutableDictionary alloc] init];
    });
    
    return proxies;
}

- (void)applyInvocationsToTarget:(id)target {
    
    for (NSInvocation *invocation in self.invocations) {
        [invocation invokeWithTarget:target];
    }
}


#pragma mark - NSProxy

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    return [self.klass instanceMethodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    // clear the target to prevent a retain cycle
    // (caused by invocation strongly referencing self)
    [invocation setTarget:nil];
    [invocation retainArguments];
    
    [self.invocations addObject:invocation];
}


#pragma mark - Initialization

- (instancetype)initWithClass:(Class)klass {
    
    if (self) {
        _klass = klass;
        _invocations = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
