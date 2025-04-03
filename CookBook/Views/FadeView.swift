//
//  FadeView.swift
//  CookBook
//
//  Created by Kirill Faifer on 03.04.2025.
//

import UIKit

class FadeView: UIView {
    
    lazy var mainStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, textStack])
        view.axis = .vertical
        view.spacing = 70
        view.distribution = .fill
        view.alignment = .center
        view.backgroundColor = .red
        return view
    }()
    
    // MARK: - UI Elements
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        view.alignment = .center
        view.alpha = .zero
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 15
        view.directionalLayoutMargins = .safeArea
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()

    // MARK: - Init
    
    init(image: UIImage, title: String, subtitle: String) {
        super.init(frame: .zero)
        
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
        directionalLayoutMargins = .safeArea
        
        layoutIfNeeded()
        
        setupSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        addSubview(mainStack)
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.size.equalTo(100)
        }
        mainStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leadingMargin.trailingMargin.equalToSuperview()
        }
    }

}

// MARK: - Helpers

extension FadeView {
    
    func toggleText(isHidden: Bool, withAnimation: Bool) {
        if withAnimation {
            if !isHidden {
                textStack.transform = .init(scaleX: 3, y: 3)
            }
            
            UIView.animate(withDuration: 1) {
                self.performTransitions(isHidden: isHidden)
            }
        } else {
            performTransitions(isHidden: isHidden)
        }
    }
    
    private func performTransitions(isHidden: Bool) {
        textStack.alpha = isHidden ? 0 : 1
        textStack.transform = isHidden ? .init(scaleX: 3, y: 3) : CGAffineTransform.identity
    }
    
}
