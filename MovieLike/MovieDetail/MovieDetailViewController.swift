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
    private let backDropView = BackDropView()
    private let synopsisView = SynopsisView()
    private let castView = CastView()
    
    var navigationTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.navigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        configure()
    }
    
    private func configure(){
        self.view.backgroundColor = .black
        view.addSubview(backDropView)
        view.addSubview(synopsisView)
        view.addSubview(castView)
        castView.configureDelegate(delegate: self, dataSource: self)
        
        backDropView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastActorCollectionViewCell.identifier, for: indexPath) as? CastActorCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
