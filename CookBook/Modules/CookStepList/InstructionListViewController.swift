//
//  InstructionListViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 29.04.2025.
//

import UIKit
import CoreData

final class InstructionListViewController: UIViewController {
    
    var stepsCount: Int {
        stepsStack.arrangedSubviews.count
    }
    
    // MARK: - Properties
    
    private lazy var stepsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupParentView()
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        view.addSubview(stepsStack)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        stepsStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - Helpers

extension InstructionListViewController {
    
    func add(step: CookStep) {
        let label = UILabel()
        label.text = String(step.number) + .dot + .space + step.title
        
        stepsStack.addArrangedSubview(label)
    }
    
}
