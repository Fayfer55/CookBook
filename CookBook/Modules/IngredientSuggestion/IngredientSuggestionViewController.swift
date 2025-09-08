//
//  IngredientSuggestionViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.09.2025.
//

import UIKit
import CoreData.NSManagedObjectID

final class IngredientSuggestionViewController: UIViewController {
    
    var isSuggestionExist: Bool {
        presenter.suggestion != nil
    }
    
    var suggestionID: NSManagedObjectID? {
        presenter.suggestion?.objectID
    }
    
    private var presenter: IngredientSuggestionPresenter
    
    // MARK: - UI Elements
    
    lazy var ingredientButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17)
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(storage: any CoreDataContextStorage) {
        presenter = IngredientSuggestionPresenter(storage: storage)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(ingredientButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        ingredientButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Helpers
    
    func searchIngredient(prompt: String) {
        presenter.searchIngredient(prompt: prompt)
        updateButtonTitle(text: presenter.suggestion?.name, prompt: prompt)
    }
    
    // MARK: - Private Helpers
    
    private func updateButtonTitle(text: String?, prompt: String) {
        let attributedString = attributedString(text: text, prompt: prompt)
        ingredientButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func attributedString(text: String?, prompt: String) -> NSAttributedString? {
        guard let text else { return nil }
        let attributedString = NSMutableAttributedString(string: text)
        let location = prompt.count
        let lenght = text.count - location
        let range = NSRange(location: location, length: lenght)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: range)
        return attributedString
    }

}
