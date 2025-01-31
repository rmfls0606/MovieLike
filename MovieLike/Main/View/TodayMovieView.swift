//
//  TodayMovieView.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

final class TodayMovieView: BaseView {

    //타이틀
    private lazy var todayMovieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 영화"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
//    //오늘의 영화 컬렉션 뷰
//    private(set) lazy var todayMovieCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 100
//        
//        let width = UIScreen.main.bounds.width * 0.6
//        layout.itemSize = CGSize(width: width, height: 300)
//
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.tag = 1
//        collectionView.backgroundColor = .blue
//        collectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
//        return collectionView
//    }()
    
    private(set) lazy var todayMovieCollectionView = createCollectionView()
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
        collectionView.tag = 1
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.backgroundColor = .green
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        let width = (UIScreen.main.bounds.width * 0.6)
        layout.itemSize = CGSize(width: width, height: 250)
        layout.scrollDirection = .horizontal
        return layout
    }
       
    
    override func configureHierarchy() {
        self.addSubview(todayMovieTitleLabel)
        self.addSubview(todayMovieCollectionView)
    }
    
    override func configureLayout() {
        todayMovieTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview()
        }
        
        todayMovieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(todayMovieTitleLabel.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
    
    func configureDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
        self.todayMovieCollectionView.delegate = delegate
        self.todayMovieCollectionView.dataSource = dataSource
    }

}
