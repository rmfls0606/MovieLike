//
//  MovieDetailViewController.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    private var currentPage: Int = 0{
        didSet{
            backDropView.pageControl.currentPage = currentPage
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .black
        view.alwaysBounceVertical = true // 세로 바운스 활성화
        view.isDirectionalLockEnabled = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 24
        view.distribution = .fill
        return view
    }()
    
    private let backDropView = BackDropView()
    private let synopsisView = SynopsisView()
    private let castView = CastView()
    private let posterView = PosterView()
    
    var navigationTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.navigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        configure()
    }
    
    private func configure(){
        self.view.backgroundColor = .black
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addSubview(backDropView)
        stackView.addSubview(synopsisView)
        stackView.addSubview(castView)
        castView.configureDelegate(delegate: self, dataSource: self)
        
        stackView.addSubview(posterView)
        posterView.configureDelegate(delegate: self, dataSource: self)
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(scrollView)
        }
        
        backDropView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.backDropView.backDropStackView)
        }
        backDropView.configureDelegate(delegate: self)
        
        synopsisView.snp.makeConstraints { make in
            make.top.equalTo(backDropView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.synopsisView.content.snp.bottom)
        }
        
        castView.snp.makeConstraints { make in
            make.top.equalTo(synopsisView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.castView.collectionView.snp.bottom)
        }
        
        posterView.snp.makeConstraints { make in
            make.top.equalTo(castView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
        }
    }
}

extension MovieDetailViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width + 0.5)
        currentPage = page
    }
    
}

extension MovieDetailViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastActorCollectionViewCell.identifier, for: indexPath) as? CastActorCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
}
