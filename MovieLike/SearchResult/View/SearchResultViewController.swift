//
//  SearchResultViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

final class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITableViewDataSourcePrefetching {
    
    private let searchResultView = SearchResultView()
    private lazy var emptyView = EmptyView()
    
    let viewModel = SearchResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setLogic()
        setBind()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLikeMovieList), name: Notification.Name("likeButtonClicked"), object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUI(){
        self.view.backgroundColor = .black
        
        self.navigationItem.title = "영화 검색"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.view.addSubview(searchResultView)
    }
    
    private func setLayout(){
        searchResultView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setLogic(){
        searchResultView.configureDelegate(delegate: self, dataSource: self, preFetching: self)
        searchResultView.configureSearchBarDelegate(delegate: self)
    }
    
    private func setBind(){
        viewModel.output.searchResults.bind { [weak self] _ in
            self?.searchResultView.reloadData()
        }
    }
    
    @objc
    private func updateLikeMovieList(_ notification: Notification){
        guard let userInfo = notification.userInfo,
              let movieID = userInfo["movieID"] as? Int else { return }
        
        if let index = viewModel.output.searchResults.value.firstIndex(where: {$0.id == movieID}){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = searchResultView.searchResultTableView.cellForRow(at: indexPath) as? SearchResultTableViewCell {
                let isLiked = UserManager.shared.movieLikeContain(movieID: movieID)
                cell.searchResultLikeBtn.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
                cell.searchResultLikeBtn.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .highlighted)
                cell.searchResultLikeBtn.isSelected = isLiked
            }
        }
    }
}

extension SearchResultViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.first{
            self.searchResultView.searchResultTableView.backgroundView = emptyView
        }else{
            if viewModel.output.searchResults.value.count == 0 {
                self.searchResultView.searchResultTableView.backgroundView = emptyView
                emptyView.configureData(text: "원하는 검색결과를 찾지 못했습니다.")
            }else{
                self.searchResultView.searchResultTableView.backgroundView = nil
            }
        }
        return viewModel.output.searchResults.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.output.searchResults.value[indexPath.row]
        cell.configureInsertData(data: data, likeButtonState: UserManager.shared.movieLikeContain(movieID: data.id))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = MovieDetailViewController()
        nextVC.viewModel.input.detailItem.value = viewModel.output.searchResults
            .value[indexPath.item]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchResultViewController{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        viewModel.input.query.value = searchBar.text
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
}

extension SearchResultViewController{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths{
            if viewModel.output.searchResults.value.count - 2 <= item.item{
                viewModel.input.page.value += 1
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
}
