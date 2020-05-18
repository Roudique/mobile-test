//
//  BaseNavigationController.swift
//  QSTest
//
//  Created by Denys Volkov on 2020-05-18.
//  Copyright © 2020 quickseries. All rights reserved.
//

import Foundation
import UIKit

private enum NavControllerConstants {
    static let fontSize = CGFloat(24)
    static let backgroundColor = UIColor.blue
    static let fontColor = UIColor.white
}

class BaseNavigationController: UINavigationController {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyTheme()
    }
    
    private func applyTheme() {
        let font = UIFont.systemFont(ofSize: NavControllerConstants.fontSize)
        
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = NavControllerConstants.backgroundColor
        self.navigationBar.tintColor = NavControllerConstants.backgroundColor
        self.navigationBar.titleTextAttributes = [.foregroundColor: NavControllerConstants.fontColor,
                                                  .font: font]

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = NavControllerConstants.backgroundColor
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: NavControllerConstants.fontColor,
                                                         .font: font]
            navBarAppearance.titleTextAttributes = [.foregroundColor: NavControllerConstants.fontColor,
                                                    .font: font]

            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else if #available(iOS 11.0, *) {
                self.navigationBar.largeTitleTextAttributes = [.foregroundColor: NavControllerConstants.fontColor,
                                                               .font: font]
        }
    }
}
