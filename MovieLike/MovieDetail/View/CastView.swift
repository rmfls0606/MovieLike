//
//  CastView.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class CastView: BaseView {

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.text = "Cast"
        return label
    }()
    
    private(set) lazy var collectionView = createCollectionView()
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CastActorCollectionViewCell.self, forCellWithReuseIdentifier: CastActorCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.backgroundColor = .black
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let padding = 20.0
        let spacing = 12.0
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 6
        
        let width = (UIScreen.main.bounds.width - (spacing * 2) - (padding * 2)) / 3
        layout.itemSize = CGSize(width: width, height: 126)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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
            make.height.equalTo(126)
        }
    }
    
    func configureDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
}
