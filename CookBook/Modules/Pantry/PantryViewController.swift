//
//  PantryViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 23.06.2025.
//

import UIKit

final class PantryViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureTabBarItem()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTabBarItem() {
        let item = UITabBarItem()
        item.image = UIImage(systemName: "refrigerator")
        tabBarItem = item
    }

}
