//
//  TodayMovieCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

final class TodayMovieCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "TodayMovieCollectionViewCell"
    
    private lazy var movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "profile_1")
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "영화"
        label.textColor = .white
        label.backgroundColor = .gray
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
        view.backgroundColor = .green
        return view
    }()
    
    private lazy var movieContent: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "안녕하세요 지금은 연습 더미 데이터로 사용하는 중입니다."
        label.textColor = .white
        label.backgroundColor = .orange
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(movieImageView)
        self.addSubview(titleAndLikeButtonView)
        self.addSubview(movieContent)
    }
    
    override func configureLayout() {
        movieImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width).multipliedBy(1.5)
        }
        
        titleAndLikeButtonView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(movieLikeBtn.snp.leading).offset(-6)
        }
        
        movieTitle.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        movieLikeBtn.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(20)
        }
        
        movieContent.snp.makeConstraints { make in
            make.top.equalTo(titleAndLikeButtonView.snp.bottom).offset(6)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.backgroundColor = .orange
    }
    
}
