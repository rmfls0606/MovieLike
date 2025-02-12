//
//  CastActorCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit
import Kingfisher

final class CastActorCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "CastActorCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = contentView.bounds.height / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var actorName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var sceneName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "darkGrayColor")
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var nameStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [actorName, sceneName])
        view.axis = .vertical
        view.spacing = 6
        view.distribution = .fill
        return view
    }()
    
    override func configureHierarchy() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameStackView)
    }
    
    override func configureLayout() {
        self.imageView.snp.makeConstraints { make in
            make.size.equalTo(contentView.snp.height)
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        self.nameStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        nameStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    func configureData(data: Cast){
        if let profile_path = data.profile_path {
            let profile_path_url = "https://image.tmdb.org/t/p/w400/\(profile_path)"
            self.imageView.kf.setImage(with: URL(string: profile_path_url))
        }
        
        self.actorName.text = data.name
        self.sceneName.text = data.original_name
    }
}
