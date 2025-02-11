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
    
    private(set) lazy var todayMovieCollectionView = createCollectionView()
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
        collectionView.tag = 1
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.backgroundColor = .black
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
//        let width = (UIScreen.main.bounds.width - 24 - 10) / 1.5
//        layout.itemSize = CGSize(width: width, height: width * 1.7)
        layout.scrollDirection = .horizontal
        return layout
    }
       
    
    override func configureHierarchy() {
        self.addSubview(todayMovieTitleLabel)
        self.addSubview(todayMovieCollectionView)
    }
    
    override func configureLayout() {
        todayMovieTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        todayMovieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(todayMovieTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.backgroundColor = .black
    }
    
    func configureDelegate(delegate: UICollectionViewDelegateFlowLayout, dataSource: UICollectionViewDataSource){
        self.todayMovieCollectionView.delegate = delegate
        self.todayMovieCollectionView.dataSource = dataSource
    }

    func reloadData(){
        self.todayMovieCollectionView.reloadData()
    }
}
