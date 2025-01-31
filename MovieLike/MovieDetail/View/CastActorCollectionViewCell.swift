//
//  CastActorCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class CastActorCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "CastActorCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.image = UIImage(named: "profile_1")
        return view
    }()
    
    private lazy var actorName: UILabel = {
        let label = UILabel()
        label.text = "김민수"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private lazy var sceneName: UILabel = {
        let label = UILabel()
        label.text = "Ahn Jung-geun"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "darkGrayColor")
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
        self.addSubview(imageView)
        self.addSubview(nameStackView)
    }
    
    override func configureLayout() {
        self.imageView.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.leading.equalToSuperview()
        }
        
        self.nameStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
}
