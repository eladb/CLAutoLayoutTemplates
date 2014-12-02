//
//  ViewController.swift
//  CLAutoLayoutTemplatesExample
//
//  Created by Elad Ben-Israel on 12/2/14.
//  Copyright (c) 2014 Elad Ben-Israel. All rights reserved.
//

import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
}

class ViewController: UIViewController {
    @IBOutlet private var button: UIButton!
    @IBOutlet private var templateView: UIView!
    @IBAction private func clickMe() {
        UIView.animateWithDuration(0.4,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0,
            options: UIViewAnimationOptions(0),
            animations: {
                self.view.replaceConstraintsForItem(self.button, usingTemplate: self.templateView)
                self.view.layoutIfNeeded()
            },
            completion: nil)
    }
}