# Appearance Proxy

A simple class to provide `UIAppearance` style customisation to classes that implement to `UIAppearance` protocol directly.

### Example Usage

```objc
@interface MyComponent : NSObject <UIAppearance>

@end


@import TAAAppearanceProxy;

@implementation


#pragma mark - UIAppearance

+ (instancetype)appearance {
    
    return [TAAAppearance proxyForClass:self];
}

+ (instancetype)appearanceWhenContainedIn...


- (void)applyAppearanceCustomisations {
    
    // best to be called when this custom component gets added to a window
    [[[self class] appearance] applyInvocationsToTarget:self];
}

@end
```

### Limitations

At the moment the proxy only supports one appearance per class, so `appearance`, `appearanceWhenContainedInInstancesOfClasses:`,  `appearanceForTraitCollection:`, etc. must all return the same appearance proxy.
