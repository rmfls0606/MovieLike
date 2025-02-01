//
//  PosterCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class PosterCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "PosterCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "profile_4")
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
