//
//  TodayMovieCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit
import Kingfisher

final class TodayMovieCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "TodayMovieCollectionViewCell"
    
    private lazy var movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.image = UIImage(named: "profile_1")
        return view
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "영화"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var movieLikeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.setImage(UIImage(systemName: "heart"), for: .highlighted)
        btn.tintColor = UIColor(named: "blueColor")
        return btn
    }()
    
    private lazy var titleAndLikeButtonView: UIView = {
        let view = UIView()
        view.addSubview(movieTitle)
        view.addSubview(movieLikeBtn)
        return view
    }()
    
    private lazy var movieContents: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "안녕하세요 지금은 연습 더미 데이터로 사용하는 중입니다."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(movieImageView)
        self.addSubview(titleAndLikeButtonView)
        self.addSubview(movieContents)
    }
    
    override func configureLayout() {
        
        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.width).multipliedBy(1.2)
        }
        
        titleAndLikeButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(movieImageView.snp.bottom).offset(6)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        movieLikeBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
            
        }
        
        movieContents.snp.makeConstraints { make in
            make.top.equalTo(titleAndLikeButtonView.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.backgroundColor = .black
    }
    
    func configureData(data: TrendingMovie){
        if let poster_path_url = data.poster_path{
            self.movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w400/\(poster_path_url)"))
        }
        self.movieTitle.text = data.title
        self.movieContents.text = data.overview
    }
    
}
