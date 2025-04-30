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
    
//    lazy var fetchedResultsController: NSFetchedResultsController<CookStep> = {
//        let request = CookStep.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "number", ascending: true)]
//        request.predicate = NSPredicate(format: "recipe == %@", recipe)
//        
//        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        controller.delegate = self
//        return controller
//    }()
    
    private let recipe: Recipe
    private let context: NSManagedObjectContext
//    
//    private lazy var dataSource = UITableViewDiffableDataSource<Int, NSManagedObjectID>(tableView: tableView) { [unowned self] tableView, indexPath, objectID in
//        guard let step = try? self.context.existingObject(with: objectID) as? CookStep else {
//            fatalError("CookStep should exist") // TODO: - handle error
//        }
//        let cell: CookStepTableCell = tableView.dequeueReusableCell(for: indexPath)
//        cell.configure(with: step)
//        return cell
//    }
    
    // MARK: - Lifecycle
    
    init(recipe: Recipe, context: NSManagedObjectContext) {
        self.recipe = recipe
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupParentView()
//        try? fetchedResultsController.performFetch()
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        view.addSubview(stepsStack)
//        tableView.register(cellType: CookStepTableCell.self)
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

// MARK: - NSFetchedResultsControllerDelegate

//extension InstructionListViewController: NSFetchedResultsControllerDelegate {
//    
//    nonisolated
//    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
//        let snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
//        
//        DispatchQueue.main.async { [weak self] in
//            self?.dataSource.apply(snapshot, animatingDifferences: true)
//        }
//    }
//    
//}
