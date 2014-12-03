//
//  CLAutoLayoutTemplates.h
//  CLAutoLayoutTemplatesExample
//
//  Created by Elad Ben-Israel on 12/3/14.
//  Copyright (c) 2014 Elad Ben-Israel. All rights reserved.
//

@import UIKit;

@interface UIView (CLAutoLayoutTemplates)

- (void)replaceConstraintsForItem:(UIView *)targetItem usingTemplate:(UIView *)templateItem;

@end
