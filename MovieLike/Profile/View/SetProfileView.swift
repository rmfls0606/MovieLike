//
//  SetProfileView.swift
//  MovieLike
//
//  Created by 이상민 on 1/30/25.
//

import UIKit
import SnapKit

final class SetProfileView: BaseView {
    
    private lazy var setListTableView: UITableView = {
        let view = UITableView()
        view.register(SetProfileTableViewCell.self , forCellReuseIdentifier: SetProfileTableViewCell.identifier)
        view.backgroundColor = .black
        return view
    }()

    override func configureHierarchy() {
        self.addSubview(setListTableView)
    }
    
    override func configureLayout() {
        self.setListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
    
    func configureDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.setListTableView.delegate = delegate
        self.setListTableView.dataSource = dataSource
    }
}
