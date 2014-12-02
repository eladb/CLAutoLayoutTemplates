//
//  AutoLayoutTemplates.swift
//
//  Created by Elad Ben-Israel on 11/25/14.
//  Copyright (c) 2014 Elad Ben-Israel. All rights reserved.
//

import UIKit

extension UIView {
    func replaceConstraintsForItem(targetItem: AnyObject, usingTemplate templateItem: AnyObject) {
        assert(targetItem.superview === templateItem.superview, "target and template must share a superview")
        
        // depth first
        for subview in self.subviews {
            subview.replaceConstraintsForItem(targetItem, usingTemplate: templateItem)
        }

        // filter intrinsic-size constraints
        let constraints = (self.constraints() as [NSLayoutConstraint]).filter { !$0.isContentSizeLayoutConstraint() }
        
        // remove any constraints referencing the target item
        let toRemove = constraints.filter { $0.referencesItem(targetItem) }
        self.removeConstraints(toRemove)
        
        // add mapped constraints (any template constraints should be added to the target item instead)
        (self !== templateItem ? self : targetItem).addConstraints(constraints
            .filter { $0.referencesItem(templateItem) } // find all constraints referencing the template item
            .map {                                      // create new constraints replacing the template item with the target item
                NSLayoutConstraint(
                    item: templateItem === $0.firstItem ? targetItem : $0.firstItem,
                    attribute: $0.firstAttribute,
                    relatedBy: $0.relation,
                    toItem: templateItem === $0.secondItem ? targetItem : $0.secondItem,
                    attribute: $0.secondAttribute,
                    multiplier: $0.multiplier,
                    constant: $0.constant)
            })
    }
}

extension NSLayoutConstraint {
    func isContentSizeLayoutConstraint() -> Bool {
        return NSStringFromClass(self.classForCoder) == "NSContentSizeLayoutConstraint"
    }
    
    func referencesItem(item: AnyObject) -> Bool {
        return self.firstItem === item || self.secondItem === item
    }
}