//
//  SearchResultTableViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

class SearchResultTableViewCell: BaseTableViewCell {

    static let identifier = "SearchResultTableViewCell"
    
    private lazy var searchResultimageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(named: "profile_1")
        return view
    }()
    
    private lazy var searchResultTitle: UILabel = {
        let label = UILabel()
        label.text = "어벤져스: 인피니티 워"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var searchResultDate: UILabel = {
        let label = UILabel()
        label.text = "2024.04.25"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        return label
    }()
    
    private lazy var searchResultGenreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        return stackView
    }()
    
    private lazy var searchResultLikeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.setImage(UIImage(systemName: "heart"), for: .highlighted)
        btn.tintColor = UIColor(named: "blueColor")
        return btn
    }()
    
    override func configureHierarchy() {
        self.addSubview(searchResultimageView)
        self.addSubview(searchResultTitle)
        self.addSubview(searchResultDate)
        self.addSubview(searchResultGenreStackView)
        self.addSubview(searchResultLikeBtn)
    }
    
    override func configureLayout() {
        searchResultimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(searchResultimageView.snp.height)
        }
        
        searchResultTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(searchResultimageView.snp.trailing).offset(12)
        }
        
        searchResultDate.snp.makeConstraints { make in
            make.top.equalTo(searchResultTitle.snp.bottom).offset(6)
            make.leading.equalTo(searchResultimageView.snp.trailing).offset(12)
        }
        
        searchResultGenreStackView.snp.makeConstraints { make in
            make.leading.equalTo(searchResultimageView.snp.trailing).offset(12)
            make.trailing.equalTo(searchResultLikeBtn.snp.leading).offset(-6)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        searchResultLikeBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
        
    }
    
    override func configureView() {
        self.selectionStyle = .none
        self.backgroundColor = .black
    }
}
