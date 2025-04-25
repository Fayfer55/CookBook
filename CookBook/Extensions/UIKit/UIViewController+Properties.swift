//
//  UIViewController+Properties.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit.UIViewController

extension UIViewController {
    
    var sceneDelegate: SceneDelegate {
        view.window?.windowScene?.delegate as! SceneDelegate
    }
    
}
