//
//  IngredientSuggestionViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.09.2025.
//

import UIKit

final class IngredientSuggestionViewController: UIViewController {
    
    var ingredientDidSelect: ((Ingredient) -> Void)?
    
    private var presenter: IngredientSuggestionPresenter
    
    // MARK: - UI Elements
    
    private lazy var ingredientButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
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
    
    // MARK: - Actions
    
    @objc
    private func buttonDidTap(_ button: UIButton) {
        guard let ingredient = presenter.searchedIngredient else { return }
        ingredientDidSelect?(ingredient)
    }
    
    // MARK: - Helpers
    
    func searchIngredient(for prompt: String) {
        do {
            let ingredientName = try presenter.searchIngredient(prompt: prompt)
            updateButtonTitle(text: ingredientName, prompt: prompt)
        } catch {
            ingredientButton.setAttributedTitle(nil, for: .normal)
        }
    }
    
    func searchedIngredient() -> Ingredient? {
        presenter.searchedIngredient
    }
    
    private func updateButtonTitle(text: String, prompt: String) {
        let attributedString = NSMutableAttributedString(string: text)
        let location = prompt.count
        let lenght = text.count - location
        let range = NSRange(location: location, length: lenght)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: range)
        ingredientButton.setAttributedTitle(attributedString, for: .normal)
    }

}
