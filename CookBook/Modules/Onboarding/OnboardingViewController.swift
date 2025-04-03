//
//  OnboardingViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.03.2025.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = OnboardingView()
    }

}

#Preview {
    OnboardingViewController()
}
