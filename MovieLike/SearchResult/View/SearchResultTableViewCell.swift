//
//  SearchResultTableViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit
import Kingfisher

class SearchResultTableViewCell: BaseTableViewCell {

    static let identifier = "SearchResultTableViewCell"
    
    private lazy var searchResultimageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
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
    
    private lazy var searchFooterView: UIView = {
        let view = UIView()
        view.addSubview(searchResultGenreStackView)
        view.addSubview(searchResultLikeBtn)
        return view
    }()
    
    private lazy var searchResultGenreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
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
        self.addSubview(searchFooterView)
    }
    
    override func configureLayout() {
        searchResultimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
            make.width.equalTo(searchResultimageView.snp.height).multipliedBy(0.8)
        }
        
        searchResultTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(searchResultimageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
        }
        
        searchResultDate.snp.makeConstraints { make in
            make.top.equalTo(searchResultTitle.snp.bottom).offset(6)
            make.leading.equalTo(searchResultimageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
        }
        
        searchFooterView.snp.makeConstraints { make in
            make.leading.equalTo(searchResultimageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        searchResultGenreStackView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
        }
        
        searchResultLikeBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(20)
        }
    }
    
    override func configureView() {
        self.selectionStyle = .none
        self.backgroundColor = .black
    }
    
    func configureInsertData(data: SearchMovieResult){
        if let poster_path = data.poster_path {
            let poster_image_url = "https://image.tmdb.org/t/p/w400/\(poster_path)"
            self.searchResultimageView.kf.setImage(with: URL(string: poster_image_url))
        }else{
            self.searchResultimageView.image = UIImage(systemName: "xmark")
        }
        self.searchResultTitle.text = data.title
        self.searchResultDate.text = DateFormatterManager.shared.formatString(data.release_date)
        genreInsertData(genreID: data.genre_ids)
    }
    
    func genreInsertData(genreID: [Int]){
        self.searchResultGenreStackView.arrangedSubviews.forEach {$0.removeFromSuperview()}
        
        let genres = GenreMappingModel.returnGenreNames(genre_Ids: genreID)
        for genre in genres {
            let view = UIView()
            view.backgroundColor = UIColor(named: "darkGrayColor")
            view.layer.cornerRadius = 5
            view.layer.masksToBounds = true
            
            let label = UILabel()
            label.text = genre
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(named: "lightGrayColor")
            
            view.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(6)
                make.leading.equalToSuperview().inset(6)
                make.trailing.equalToSuperview().inset(6)
                make.bottom.equalToSuperview().inset(6)
            }
            
            self.searchResultGenreStackView.addArrangedSubview(view)
        }
    }
}
