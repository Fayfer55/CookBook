//
//  IngredientCollectionViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

final class IngredientCollectionViewController: GridViewController {
    
    private(set) var ingredients = [Ingredient]()
    
    var selectedIngredients: Set<Ingredient> {
        guard let selectedIndexPaths = gridView.indexPathsForSelectedItems else { return [] }
        return Set(selectedIndexPaths.map { ingredients[$0.item] })
    }
    
    private var selectedCell: IngredientCollectionCell?
    
    private lazy var animator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 0.33, curve: .easeInOut)
        return animator
    }()
    
    // MARK: - Lifecycle
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        super.init(layout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupParentView()
    }
    
    // MARK: - Layout

    private func setupParentView() {
        gridView.register(cellType: IngredientCollectionCell.self)
        gridView.allowsMultipleSelection = true
        gridView.addGestureRecognizer(timeLongPressGestureRecognizer())
    }
    
    private func timeLongPressGestureRecognizer() -> TimeLongPressGestureRecognizer {
        let recognizer = TimeLongPressGestureRecognizer(target: self, action: #selector(longPressAction(recognizer:)))
        recognizer.minimumPressDuration = 0.1
        recognizer.targetDuration = 0.5
        return recognizer
    }
    
    // MARK: - Actions
    
    @objc
    private func longPressAction(recognizer: TimeLongPressGestureRecognizer) {
        let location = recognizer.location(in: gridView)
        guard let indexPath = gridView.indexPathForItem(at: location) else { return }
        let cell: IngredientCollectionCell = gridView.cellForItem(at: indexPath)
        
        switch recognizer.state {
            case .possible, .changed, .recognized:
                break
            case .began:
                selectedCell = cell
                configureAnimator()
                animator.startAnimation()
            case .ended:
                animator.stopAnimation(false)
                animator.finishAnimation(at: .end)
            case .cancelled:
                selectedCell = nil
                animator.stopAnimation(false)
                animator.finishAnimation(at: .start)
            case .failed:
                selectedCell = nil
                animator.stopAnimation(false)
                animator.finishAnimation(at: .start)
            @unknown default:
                break
        }
    }
    
    private func showIngredientPreview(selectedCell: IngredientCollectionCell) {
        guard let ingredient = selectedCell.ingredient else { return }
        
        let previewViewController = IngredientPreviewViewController(ingredient: ingredient)
        previewViewController.modalPresentationStyle = .custom
        previewViewController.transitioningDelegate = self
        
        if let snapshotView = selectedCell.snapshotView(afterScreenUpdates: true) {
//            previewViewController.view.addSubview(snapshotView)
//            snapshotView.snp.makeConstraints { make in
//                
//            }
        }
        present(previewViewController, animated: true)
    }
    
    private func configureAnimator() {
        animator.addAnimations { [weak self] in
            guard let self, let selectedCell else { return }
            selectedCell.transform = .init(scaleX: 0.9, y: 0.9)
        }
        animator.addCompletion { [weak self] position in
            guard position == .end, let selectedCell = self?.selectedCell else { return }
            
            HapticHelper.tap(style: .soft)
            self?.showIngredientPreview(selectedCell: selectedCell)
            self?.selectedCell?.transform = .identity
            self?.selectedCell = nil
        }
    }

}

// MARK: - Helpers

extension IngredientCollectionViewController {
    
    func set(ingredients: [Ingredient]) {
        self.ingredients = ingredients
        gridView.reloadData()
    }
    
}

// MARK: UICollectionViewDataSource

extension IngredientCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { ingredients.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: IngredientCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: ingredients[indexPath.item])
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension IngredientCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = ingredients[indexPath.item].name
        let safeArea = NSDirectionalEdgeInsets.safeArea
        var size = title.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)])
        size.width += safeArea.leading + safeArea.trailing
        size.height += safeArea.top + safeArea.bottom
        return size
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate

extension IngredientCollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        GenieAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        GenieAnimator(isPresenting: false)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let selectedCell else { return nil }
        let selectedFrame = gridView.convert(selectedCell.frame, to: navigationController?.view ?? view.superview)
        return FramePresentationController(frame: selectedFrame, presentedViewController: presented, presenting: presenting)
    }
    
}
