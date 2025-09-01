//
//  IngredientsListViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 28.08.2025.
//

import UIKit

class IngredientsListViewController: UITableViewController {
    
    var textFieldDidChange: ((_ textField: UITextField) -> Void)?
    
    private lazy var dataSource = UITableViewDiffableDataSource<Int, Int>(tableView: tableView) { [unowned self] tableView, indexPath, _ in
        let cell: ButtonedTextFieldListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textField.placeholder = "New item"
        cell.textField.delegate = self
        cell.textField.addTarget(self, action: #selector(textFieldDidChangeEditing), for: .editingChanged)
        if indexPath.row != .zero { // TODO: - improve logic
            cell.textField.becomeFirstResponder()
        }
        return cell
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellType: ButtonedTextFieldListCell.self)
        setupInitialDataSourceSnapshot()
    }
    
    // MARK: - Setup DataSource
    
    private func setupInitialDataSourceSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([.zero])
        snapshot.appendItems([.zero], toSection: .zero)
        dataSource.apply(snapshot)
    }
    
    // MARK: - Actions
    
    @objc
    private func textFieldDidChangeEditing(_ textField: UITextField) {
        textFieldDidChange?(textField)
    }

}

// MARK: - UITextFieldDelegate

extension IngredientsListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var snapshot = dataSource.snapshot()
        let itemsCount = snapshot.numberOfItems(inSection: .zero)
        snapshot.appendItems([itemsCount], toSection: .zero)
        dataSource.apply(snapshot)
        
        return true
    }
    
}
