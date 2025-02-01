//
//  RecentSearchView.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

final class RecentSearchView: BaseView {

    var onButtonTapped: (() -> Void)?
    //타이틀
    private lazy var recentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근검색어"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(recentTitleLabel)
        view.addSubview(allRemoveButton)
        return view
    }()
    
    //전체삭제 버튼
    private lazy var allRemoveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("전체 삭제", for: .normal)
        btn.setTitle("전체 삭제", for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(UIColor(named: "blueColor"), for: .normal)
        btn.setTitleColor(UIColor(named: "blueColor"), for: .highlighted)
        btn.addTarget(self, action: #selector(removeAllButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    //최근 검색어 컬렉션 뷰
    private(set) lazy var recentSearchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.estimatedItemSize = CGSize(width: 100, height: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.tag = 0
        collectionView.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override func configureHierarchy() {
        self.addSubview(containerView)
        self.addSubview(recentSearchCollectionView)
    }
    
    override func configureLayout() {
        
        self.containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview()
            make.height.equalTo(20)
        }
        
        recentTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        allRemoveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        recentSearchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(12)
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
    
    func reloadData(){
        self.recentSearchCollectionView.reloadData()
        self.recentSearchCollectionView.layoutIfNeeded()
    }
    
    @objc
    private func removeAllButtonTapped(){
        onButtonTapped?()
    }
}
