//
//  RecipeCreationViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

final class RecipeCreationViewController: UITableViewController {
    
    private lazy var presenter = RecipeCreationPresenter()
    
    private lazy var dataSource = UITableViewDiffableDataSource<RecipeCreationSection, RecipeCreationRow>(tableView: tableView) { [unowned self] tableView, indexPath, row in
        switch row {
            case .name:
                let cell: TextFieldTableCell = tableView.dequeueReusableCell(for: indexPath)
                cell.textField.placeholder = "Name"
                cell.textField.delegate = self
                cell.textField.addTarget(self, action: #selector(nameDidChange), for: .editingChanged)
                return cell
            case .ingredient:
                let cell: IngredientTableCell = tableView.dequeueReusableCell(for: indexPath)
                let model = IngredientModel(tag: indexPath.row, text: presenter.ingredients[indexPath.row])
                
                cell.configure(model: model)
                cell.textField.delegate = self
                cell.textField.addTarget(self, action: #selector(ingredientDidChange), for: .editingChanged)
                return cell
            case .cookStep:
                let cell: CookStepTableCell = tableView.dequeueReusableCell(for: indexPath)
                let model = CookStepModel(tag: indexPath.row, text: presenter.cookSteps[indexPath.row])
                
                cell.configure(model: model)
                cell.textField.delegate = self
                cell.textField.addTarget(self, action: #selector(cookStepDidChange), for: .editingChanged)
                return cell
        }
    }
    
    // MARK: - Lifecycle
    
    init() {
        super.init(style: .insetGrouped)
        
        hidesBottomBarWhenPushed = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("method unavailable")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupParentView()
        setupSubviews()
        createInitialDataSourceSnapshot()
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        navigationItem.title = "New recipe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.down"),
            style: .done,
            target: self,
            action: #selector(createRecipeDidTap)
        )
    }
    
    private func setupSubviews() {
        tableView.separatorColor = .systemGray
        tableView.registerHeaderFooterView(viewType: LabelHeader.self)
        tableView.register(cellType: TextFieldTableCell.self)
        tableView.register(cellType: IngredientTableCell.self)
        tableView.register(cellType: CookStepTableCell.self)
    }
    
    // MARK: - Actions
    
    @objc
    private func nameDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        presenter.changeName(text)
    }
    
    @objc
    private func ingredientDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        presenter.changeIngredient(name: text, index: textField.tag)
    }
    
    @objc
    private func cookStepDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        presenter.changeCookStep(text: text, index: textField.tag)
    }
    
    @objc
    private func createRecipeDidTap(_ button: UIButton) {
        do {
            try presenter.createRecipe()
            navigationController?.popViewController(animated: true)
        } catch let error as RecipeCreationError {
            switch error {
                case .emptyName:
                    let cell: TextFieldTableCell = tableView.cellForRow(at: IndexPath(row: .zero, section: RecipeCreationSection.metaData.rawValue))
                    shakeView(cell)
                case .emptyIngredients:
                    let header = tableView.headerView(forSection: RecipeCreationSection.ingredients.rawValue)
                    shakeView(header)
                case .emptyCookSteps:
                    let header = tableView.headerView(forSection: RecipeCreationSection.cookSteps.rawValue)
                    shakeView(header)
            }
            HapticHelper.notification(type: .error)
        } catch let error {
            showAlertController(title: "Recipe saving failed", message: error.localizedDescription)
        }
    }
    
    // MARK: - Data Source Helpers
    
    private func createInitialDataSourceSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<RecipeCreationSection, RecipeCreationRow>()
        snapshot.appendSections(RecipeCreationSection.allCases)
        snapshot.appendItems([.name], toSection: .metaData)
        snapshot.appendItems([.ingredient(.init())], toSection: .ingredients)
        snapshot.appendItems([.cookStep(.init())], toSection: .cookSteps)
        dataSource.apply(snapshot)
    }
    
    private func createNewRow(in section: RecipeCreationSection) {
        var snapshot = dataSource.snapshot()
        let row: RecipeCreationRow = if section == .ingredients {
            .ingredient(.init())
        } else {
            .cookStep(.init())
        }
        snapshot.appendItems([row], toSection: section)
        dataSource.apply(snapshot)
    }
    
    private func makeRowAsFirstResponder(index: Int, in section: RecipeCreationSection) {
        switch section {
            case .metaData:
                break
            case .ingredients:
                let cell: IngredientTableCell = tableView.cellForRow(at: IndexPath(row: index, section: section.rawValue))
                cell.textField.becomeFirstResponder()
            case .cookSteps:
                let cell: CookStepTableCell = tableView.cellForRow(at: IndexPath(row: index, section: section.rawValue))
                cell.textField.becomeFirstResponder()
        }
    }
    
    private func fillIngredient(cellIndex: Int, suggestion: String) {
        let cell: IngredientTableCell = tableView.cellForRow(at: IndexPath(row: cellIndex, section: RecipeCreationSection.ingredients.rawValue))
        cell.textField.text = suggestion
    }
    
    // MARK: - Error Handling Helpers
    
    private func shakeView(_ view: UIView?) {
        UIView.animate(withDuration: 0.1) {
            UIView.modifyAnimations(withRepeatCount: 2, autoreverses: true) {
                view?.transform = .init(translationX: 2, y: 0)
            }
        } completion: { _ in
            view?.transform = .identity
        }
    }
    
    private func showAlertController(title: String?, message: String?) {
        let viewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        viewController.addAction(okAction)
        present(viewController, animated: true)
    }
    
}

// MARK: - UITableViewDelegate

extension RecipeCreationViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = dataSource.sectionIdentifier(for: section) else { return nil }
        switch section {
            case .metaData:
                return nil
            case .ingredients, .cookSteps:
                let view: LabelHeader = tableView.dequeueReusableHeaderFooterView()
                view.label.text = section.headerTitle
                return view
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension RecipeCreationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview?.superview is IngredientTableCell {
            if textField.tag + 1 == presenter.ingredients.count {
                presenter.createEmptyIngredient()
                createNewRow(in: .ingredients)
            }
            makeRowAsFirstResponder(index: textField.tag + 1, in: .ingredients)
        } else if textField.superview?.superview is CookStepTableCell {
            if textField.tag + 1 == presenter.cookSteps.count {
                presenter.createEmptyStep()
                createNewRow(in: .cookSteps)
            }
            makeRowAsFirstResponder(index: textField.tag + 1, in: .cookSteps)
        } else if textField.superview?.superview is TextFieldTableCell {
            makeRowAsFirstResponder(index: .zero, in: .ingredients)
        }
        return true
    }
    
}
