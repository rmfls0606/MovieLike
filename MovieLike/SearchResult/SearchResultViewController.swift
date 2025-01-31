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
    private var searchList = [SearchMovieResult]()
    private var emptyView = EmptyView()
    private var page = 1
    private var isEnd = false
    private var query = ""
    
    var searchStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure(){
        self.view.backgroundColor = .black
        
        self.navigationItem.title = "영화 검색"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.view.addSubview(searchResultView)
        searchResultView.configureDelegate(delegate: self, dataSource: self, preFetching: self)
        searchResultView.configureSearchBarDelegate(delegate: self)
        
        searchResultView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func callBackRequest(query: String, page: Int){
        let parameters = ["page": page]
        APIManager.shard.callRequest(api: .search(query: query), parameters: parameters) { (response: SearchResponse) in
            if page == 1{
                self.searchList = response.results
            }else{
                self.searchList.append(contentsOf: response.results)
            }
            
            self.isEnd = page >= response.total_pages
            self.searchResultView.reloadDate()
        } failHandler: { error in
            print(error.localizedDescription)
        }
    }
}

extension SearchResultViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchList.count == 0 {
            if searchStatus{
                self.searchResultView.searchResultTableView.backgroundView = emptyView
                emptyView.configureData(text: "원하는 검색결과를 찾지 못했습니다.")
            }else{
                self.searchResultView.searchResultTableView.backgroundView = emptyView
            }
        }else{
            self.searchResultView.searchResultTableView.backgroundView = nil
        }
        
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        let data = searchList[indexPath.row]
        cell.configureInsertData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SearchResultViewController{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        
        self.page = 1
        self.query = searchBar.text!
        self.searchStatus = true
        callBackRequest(query: query, page: 1)
        UserManager.shared.saveRecentSearchName(text: self.query)
        print(UserManager.shared.getREcentSearchName())
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
        guard !isEnd else { return }
        
        for item in indexPaths{
            if searchList.count - 2 <= item.item{
                self.page += 1
                callBackRequest(query: query, page: self.page)
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
}
