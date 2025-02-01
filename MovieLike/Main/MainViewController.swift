//
//  MainViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/28/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let userProfieView = UserProfileView()
    private let recentSearchView = RecentSearchView()
    private let todayMovieView = TodayMovieView()
    private lazy var emptyView = EmptyView()
    private var recentSearchData: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.recentSearchData = UserManager.shared.getRecentSearchName()
        self.recentSearchView.reloadData()
        self.view.layoutIfNeeded()
        print(1)
        print(recentSearchData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(2)
        configure()
    }
    
    private func configure(){
        self.recentSearchData = UserManager.shared.getRecentSearchName()
        self.recentSearchView.reloadData()
        self.view.backgroundColor = .black
        self.navigationItem.title = "오늘의 영화"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        rightBarButton.tintColor = UIColor(named: "blueColor")
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.addSubview(userProfieView)
        userProfieView.onTapGesureClosure = presentViewController
        self.view.addSubview(recentSearchView)
        self.recentSearchView.configureDelegate(delegate: self, dataSource: self)
        self.recentSearchView.onButtonTapped = { [weak self] in
            self?.recentSearchRemoveAll()
        }
        
        self.view.addSubview(todayMovieView)
        self.todayMovieView.configureDelegate(delegate: self, dataSource: self)
        
        
        userProfieView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.userProfieView.userProfileView.snp.bottom)
        }
        
        recentSearchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(userProfieView.snp.bottom).offset(12)
            make.bottom.equalTo(recentSearchView.recentSearchCollectionView.snp.bottom)
        }
//        
        todayMovieView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func presentViewController(){
        let presentVC = ProfileSetNickNameViewController()
        presentVC.editMode = true
        presentVC.onDataUpdated = { [weak self] newData in
            self?.userProfieView.configureData(user: newData)
            self?.todayMovieView.todayMovieCollectionView.reloadData()
        }
        let navigationVC = UINavigationController(rootViewController: presentVC)
        self.present(navigationVC, animated: true)
    }
    
    @objc
    private func searchButtonTapped(){
        let nextVC = SearchResultViewController()
        nextVC.preVCReload = { [weak self] in
            self?.recentSearchData = UserManager.shared.getRecentSearchName()
            
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MainViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !self.recentSearchData.isEmpty{
            self.recentSearchView.recentSearchCollectionView.backgroundView = nil
            print(recentSearchData.count)
            return recentSearchData.count
        }else{
            self.recentSearchView.recentSearchCollectionView.backgroundView = emptyView
            emptyView.configureData(text: "최근 검색어 내역이 없습니다.")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as? RecentSearchCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            let data = self.recentSearchData[indexPath.item]
            cell.configureText(text: data)
            return cell
        }else if collectionView.tag == 1{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.identifier, for: indexPath) as? TodayMovieCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    private func recentSearchRemoveAll(){
        UserManager.shared.removeAllRecentSearchName()
        self.recentSearchData = []
        self.recentSearchView.reloadData()
        print(UserManager.shared.getRecentSearchName())
    }
}
