//
//  ProfileSelectImageCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

class ProfileSelectImageCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "ProfileSelectImageCollectionViewCell"
    
    private lazy var profileImageButton = ProfileImageView()
    
    override func configureHierarchy() {
        self.addSubview(profileImageButton)
    }
    
    override func configureLayout() {
        profileImageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
    
    func configure(image: UIImage){
        self.profileImageButton.selectImage(image: image)
    }
}
