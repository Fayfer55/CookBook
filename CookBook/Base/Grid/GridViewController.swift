//
//  GridViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 30.04.2025.
//

import UIKit

class GridViewController: UIViewController {
    
    let layout: UICollectionViewFlowLayout
    
    lazy var gridView: GridView = {
        let view = GridView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(layout: UICollectionViewFlowLayout) {
        self.layout = layout
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(gridView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        gridView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension GridViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegate

extension GridViewController: UICollectionViewDelegate { }
