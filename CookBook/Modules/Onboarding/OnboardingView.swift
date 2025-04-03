//
//  OnboardingView.swift
//  CookBook
//
//  Created by Kirill Faifer on 03.04.2025.
//

import UIKit

final class OnboardingView: UIView {
    
    private let data: [(image: UIImage, title: String, subtitle: String)] = [
        (image: UIImage(systemName: "sun.max")!, title: String("firstTitle"), subtitle: String("firstSubtitle")),
        (image: UIImage(systemName: "moon")!, title: String("secondTitle"), subtitle: String("secondSubtitle")),
        (image: UIImage(systemName: "cloud.bolt.rain")!, title: String("thirdTitle"), subtitle: String("thirdSubtitle"))
    ]
    
    // MARK: - Properties
    
    
    
    // MARK: - Private properties
    
    private var lastOffset: CGFloat = .zero
    private var lastPage: Int = .zero
    
    // MARK: - UI Elements
    
    /// Main stack of the view
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = .zero
        return stack
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        view.delegate = self
        return view
    }()
    
    private func setupUI() {
        scrollView.addSubview(stack)
        addSubview(scrollView)
        
        for tuple in data {
            let view = FadeView(image: tuple.image, title: tuple.title, subtitle: tuple.subtitle)
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.black.cgColor
            
            stack.addArrangedSubview(view)
            
            guard tuple == data.first! else { continue }
            view.toggleText(isHidden: false, withAnimation: false)
        }
    }
 
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stack.arrangedSubviews.forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(bounds.size)
            }
        }
    }
    
}

// MARK: - UIScrollViewDelegate

extension OnboardingView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageSize = frame.size
        let currentPage = Int((scrollView.contentOffset.x / pageSize.width).rounded())
        
        defer {
            lastOffset = scrollView.contentOffset.x
            lastPage = Int((scrollView.contentOffset.x / pageSize.width).rounded())
        }
        
        let scrollTowards = scrollView.contentOffset.x > lastOffset
        
        let anotherAnimatedPage = if scrollTowards {
            currentPage - 1
        } else {
            currentPage + 1
        }
        
        guard currentPage != lastPage,
              stack.arrangedSubviews.indices.contains(currentPage),
              let currentSubview = stack.arrangedSubviews[currentPage] as? FadeView else { return }
        
        currentSubview.toggleText(isHidden: false, withAnimation: true)
        
        if stack.arrangedSubviews.indices.contains(anotherAnimatedPage),
           let anotherView = stack.arrangedSubviews[anotherAnimatedPage] as? FadeView {
            anotherView.toggleText(isHidden: true, withAnimation: true)
        }
    }
    
}
