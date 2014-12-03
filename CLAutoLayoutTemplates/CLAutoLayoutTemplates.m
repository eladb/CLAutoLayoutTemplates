//
//  CLAutoLayoutTemplates.m
//  CLAutoLayoutTemplatesExample
//
//  Created by Elad Ben-Israel on 12/3/14.
//  Copyright (c) 2014 Elad Ben-Israel. All rights reserved.
//

#import "CLAutoLayoutTemplates.h"

@implementation NSLayoutConstraint (CLAutoLayoutTemplates)

- (BOOL)isContentSizeLayoutConstraint
{
    return [NSStringFromClass(self.class) isEqualToString:@"NSContentSizeLayoutConstraint"];
}

- (BOOL)referencesItem:(id)item
{
    return self.firstItem == item || self.secondItem == item;
}

@end

@implementation UIView (CLAutoLayoutTemplates)

- (void)replaceConstraintsForItem:(UIView *)targetItem usingTemplate:(UIView *)templateItem
{
    NSAssert(targetItem.superview == templateItem.superview, @"target and template must share a superview");
    
    // depth first
    for (UIView *subview in self.subviews) {
        [subview replaceConstraintsForItem:targetItem usingTemplate:templateItem];
    }
    
    NSMutableArray *removals = [[NSMutableArray alloc] init];
    NSMutableArray *additions = [[NSMutableArray alloc] init];
    
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if ([c isContentSizeLayoutConstraint]) {
            return; // filter intrinsic-size constraints
        }

        // remove any constraints that reference the target item
        if ([c referencesItem:targetItem]) {
            [removals addObject:c];
        }

        // create new constraints based on template item and add
        if ([c referencesItem:templateItem]) {
            [additions addObject:[NSLayoutConstraint constraintWithItem:(templateItem == c.firstItem) ? targetItem : c.firstItem
                                                              attribute:c.firstAttribute
                                                              relatedBy:c.relation
                                                                 toItem:(templateItem == c.secondItem) ? targetItem : c.secondItem
                                                              attribute:c.secondAttribute
                                                             multiplier:c.multiplier
                                                               constant:c.constant]];
        }
    }];

    UIView *targetView = (self == templateItem) ? targetItem : self;
    [self removeConstraints:removals];
    [targetView addConstraints:additions];
}

@end
