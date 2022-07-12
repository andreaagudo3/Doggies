//
//  AppAppearance.swift
//  ExampleMVVM
//
//  Created by Oleh on 23.09.18.
//

import Foundation
import UIKit

final class AppAppearance {

    static func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: Colors.greyPrimary]
        appearance.backgroundColor = Colors.brand
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UINavigationBar.appearance().tintColor = Colors.greyPrimary
        UINavigationBar.appearance().prefersLargeTitles = true
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
