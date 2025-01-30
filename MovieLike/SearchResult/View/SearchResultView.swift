//
//  SearchResultView.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

class SearchResultView: BaseView {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "영화 제목을 검색해주세요"
        searchBar.barTintColor = UIColor(named: "darkGrayColor")
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView!.tintColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBar.searchTextField.placeholder!, attributes: [.foregroundColor: UIColor.white])
        searchBar.layer.cornerRadius =  10
        searchBar.layer.masksToBounds = true
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultTableViewCell.self , forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override func configureHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(searchResultTableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        searchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }

    func configureDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.searchResultTableView.delegate = delegate
        self.searchResultTableView.dataSource = dataSource
    }
    
    func configureSearchBarDelegate(delegate: UISearchBarDelegate){
        self.searchBar.delegate = delegate
    }
    
    func reloadDate(){
        self.searchResultTableView.reloadData()
    }
}
