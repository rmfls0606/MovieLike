//
//  PosterView.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class PosterView: BaseView {

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.text = "Poster"
        return label
    }()
    
    private(set) lazy var collectionView = createCollectionView()
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.backgroundColor = .black
        collectionView.tag = 1
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let padding = 10.0
        let spacing = 12.0
        layout.minimumLineSpacing = 10
        
        let width = (UIScreen.main.bounds.width - (spacing * 2) - (padding * 3)) / 4
        layout.itemSize = CGSize(width: width, height: 200)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureHierarchy() {
        self.addSubview(title)
        self.addSubview(collectionView)
    }
    
    override func configureLayout() {
        self.title.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    func configureDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }

    func reloadData(){
        self.collectionView.reloadData()
    }
}
