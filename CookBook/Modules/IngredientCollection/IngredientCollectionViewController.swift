//
//  IngredientCollectionViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

@MainActor
protocol IngredientSelectionDelegate: AnyObject {
    func didSelectIngredient(_ ingredient: Ingredient)
    func didDeselectIngredient(_ ingredient: Ingredient)
}

final class IngredientCollectionViewController: GridViewController {
    
    // MARK: - Internal properties
    
    weak var delegate: IngredientSelectionDelegate?
    
    private(set) var items = [Ingredient]()
    
    // MARK: - Private properties
    
    private lazy var animator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 0.33, curve: .easeInOut)
        return animator
    }()
    
    private var selectedCell: IngredientCollectionCell?
    
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
        
//        if let _ = selectedCell.snapshotView(afterScreenUpdates: true) {
//            previewViewController.view.addSubview(snapshotView)
//            snapshotView.snp.makeConstraints { make in
//                
//            }
//        }
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
        items = ingredients
        gridView.reloadData()
    }
    
}

// MARK: UICollectionViewDataSource

extension IngredientCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { items.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: IngredientCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: items[indexPath.item])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension IngredientCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectIngredient(items[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate?.didDeselectIngredient(items[indexPath.item])
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension IngredientCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ingredient = items[indexPath.item]
        let cell = IngredientCollectionCell(frame: .zero)
        cell.configure(with: ingredient)
        cell.setNeedsLayout()
        
        return cell.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        )
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
