//
//  RecentSearchCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

class RecentSearchCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "RecentSearchCollectionViewCell"
    var onButtonTapped: (() -> Void)?
    
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
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    override func configureHierarchy() {
        self.contentView.addSubview(searchTextLabel)
        self.contentView.addSubview(deleteButton)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    override func configureLayout() {
        self.searchTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        
        self.deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(searchTextLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-12)
            make.size.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
    
    //contentView에 버튼을 넣으면 이벤트 처리 가능!
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let result = deleteButton.hitTest(convert(point, to: deleteButton), with: event) {
            return result
        }
        return super.hitTest(point, with: event)
    }
    
    func configureText(text: String){
        searchTextLabel.text = text
    }
    
    @objc
    private func deleteButtonTapped(){
        self.onButtonTapped?()
    }
}
