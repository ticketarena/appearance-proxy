//
//  TAAAppearanceProxy.h
//  TAAAppearanceProxy
//
//  Created by Elliot Neal on 26/10/2016.
//  Copyright © 2016 Ticket Arena LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides a simple implementation of proxying for `UIAppearance` compliant classes that
 don't subclass `UIView` directly. This class saves invocations that are made on it and
 is able to replay those invocations onto and instance of a `UIAppearance` compliant class
 later on in the application lifecycle
 */
@interface TAAAppearanceProxy : NSProxy


/**
 Return the shared appearance proxy for the specified class.

 @param klass A class that conforms to `UIAppearance` directly
 @return An instance of `TAAAppearanceProxy` that can be return from `+ (instancetype)appearance`
 */
+ (id)proxyForClass:(Class)klass;


/**
 Perform saved invocations onto a target of the class

 @param target An instance of the class of this appearance proxy
 */
- (void)applyInvocationsToTarget:(id)target;

@end

