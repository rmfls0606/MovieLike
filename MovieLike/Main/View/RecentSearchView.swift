//
//  RecentSearchView.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

final class RecentSearchView: BaseView {

    //타이틀
    private lazy var recentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근검색어"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    //전체삭제 버튼
    private lazy var allRemoveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("전체 삭제", for: .normal)
        btn.setTitle("전체 삭제", for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(UIColor(named: "blueColor"), for: .normal)
        btn.setTitleColor(UIColor(named: "blueColor"), for: .highlighted)
        return btn
    }()
    
    //최근 검색어 컬렉션 뷰
    private(set) lazy var recentSearchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.tag = 0
        collectionView.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override func configureHierarchy() {
        self.addSubview(recentTitleLabel)
        self.addSubview(allRemoveButton)
        self.addSubview(recentSearchCollectionView)
    }
    
    override func configureLayout() {
        recentTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview()
        }
        
        allRemoveButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
        
        recentSearchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recentTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        
    }
    
    func configureDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
        self.recentSearchCollectionView.delegate = delegate
        self.recentSearchCollectionView.dataSource = dataSource
    }
}
