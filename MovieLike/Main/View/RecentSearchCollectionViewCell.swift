//
//  RecentSearchCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit

class RecentSearchCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "RecentSearchCollectionViewCell"
    
    //검색어
    private lazy var searchTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    //x버튼
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .highlighted)
        button.tintColor = .black
        return button
    }()
    
    override func configureHierarchy() {
        self.addSubview(searchTextLabel)
        self.addSubview(deleteButton)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    override func configureLayout() {
        searchTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(searchTextLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-12)
            make.size.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
    
    func configureText(text: String){
        searchTextLabel.text = text
    }
}
