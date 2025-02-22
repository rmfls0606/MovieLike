//
//  PosterCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PosterCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "PosterCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func configureHierarchy() {
        self.contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureInsertImage(imageName: String){
        self.imageView.image = nil
        self.imageView.kf.setImage(with: URL(string: imageName))
    }

}
