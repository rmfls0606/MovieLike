//
//  MainViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/28/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let userProfieView = UserProfileView()
    private let recentSearchView = RecentSearchView()
    private let todayMovieView = TodayMovieView()
    private lazy var emptyView = EmptyView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewModel.output.recentSearchData.value = UserManager.shared.getRecentSearchName()
        self.recentSearchView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLikeMovieList), name: Notification.Name("likeButtonClicked"), object: nil)
        setUI()
        setLayout()
        setLogic()
        setBind()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUI(){
        self.view.backgroundColor = .black
        self.navigationItem.title = "오늘의 영화"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        rightBarButton.tintColor = UIColor(named: "blueColor")
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.addSubview(userProfieView)
        
        self.view.addSubview(recentSearchView)
        
        self.view.addSubview(todayMovieView)
    }
    
    private func setLayout(){
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
        
        todayMovieView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setLogic(){
        self.viewModel.output.recentSearchData.value = UserManager.shared.getRecentSearchName()
        
        userProfieView.onTapGesureClosure = presentViewController
        
        self.recentSearchView.configureDelegate(delegate: self, dataSource: self)
        self.recentSearchView.onButtonTapped = { [weak self] in
            self?.recentSearchRemoveAll()
        }
        
        self.todayMovieView.configureDelegate(delegate: self, dataSource: self)
    }
    
    private func setBind(){
        viewModel.output.recentSearchData.lazyBind { data in
            self.recentSearchView.reloadData()
        }
        
        viewModel.output.trendingMovieData.lazyBind { data in
            self.todayMovieView.reloadData()
        }
    }
    
    //MARK: - Actions
    private func recentSearchRemoveAll(){
        UserManager.shared.removeAllRecentSearchName()
        self.viewModel.output.recentSearchData.value = [] //todo: UserManager를 통하여 처리 가능할 것 같다
    }
    
    @objc
    private func updateLikeMovieList(_ notification: Notification){
        guard let userInfo = notification.userInfo,
              let movieID = userInfo["movieID"] as? Int else { return }
        
        if let index = viewModel.output.trendingMovieData.value.firstIndex(where: { $0.id == movieID }) {
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = todayMovieView.todayMovieCollectionView.cellForItem(at: indexPath) as? TodayMovieCollectionViewCell {
                let isLiked = UserManager.shared.movieLikeContain(movieID: movieID)
                cell.movieLikeBtn.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
                cell.movieLikeBtn.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .highlighted)
                cell.movieLikeBtn.isSelected = isLiked
            }
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
            self?.viewModel.output.recentSearchData.value = UserManager.shared.getRecentSearchName()
            
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            if !self.viewModel.output.recentSearchData.value.isEmpty{
                self.recentSearchView.recentSearchCollectionView.backgroundView = nil
                return viewModel.output.recentSearchData.value.count
            }else{
                self.recentSearchView.recentSearchCollectionView.backgroundView = emptyView
                self.emptyView.configureData(text: "최근 검색어 내역이 없습니다.")
                return 0
            }
        }else{
            return viewModel.output.trendingMovieData.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as? RecentSearchCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            let data = self.viewModel.output.recentSearchData.value[indexPath.item]
            cell.configureText(text: data)
            cell.onButtonTapped = { [weak self] in
                UserManager.shared.removeRecentSearchName(text: data)
                self?.viewModel.output.recentSearchData.value = UserManager.shared.getRecentSearchName()
            }
            return cell
        }else if collectionView.tag == 1{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.identifier, for: indexPath) as? TodayMovieCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            let data = viewModel.output.trendingMovieData.value[indexPath.item]
            cell.configureData(data: data, likeButtonState: UserManager.shared.movieLikeContain(movieID: data.id))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0{
            let nextVC = SearchResultViewController()
            nextVC.preVCReload = { [weak self] in
                self?.viewModel.output.recentSearchData.value = UserManager.shared.getRecentSearchName()
            }
            nextVC.query = self.viewModel.output.recentSearchData.value[indexPath.item]
            nextVC.viewModel.input.query.value = nextVC.query
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else{
            let nextVC = MovieDetailViewController()
            nextVC.result = self.viewModel.output.trendingMovieData.value[indexPath.item]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            return collectionView.bounds.size
        }else{
            let width = (collectionView.bounds.width - 24 - 10) / 1.5
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        }
    }
}
