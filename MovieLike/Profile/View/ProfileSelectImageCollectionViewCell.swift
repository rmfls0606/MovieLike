//
//  ProfileSelectImageCollectionViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSelectImageCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "ProfileSelectImageCollectionViewCell"
    
    var selectItem: Bool = false
    
    private lazy var profileImageButton: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
        view.alpha = 0.5
        return view
    }()
    
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
        self.profileImageButton.image = image
    }
    
    func configureBorderColor(){
        self.profileImageButton.layer.borderWidth = selectItem ? 3.0 : 1.0
        self.profileImageButton.layer.borderColor = selectItem ? UIColor(named: "blueColor")?.cgColor : UIColor(named: "lightGrayColor")?.cgColor
        self.profileImageButton.alpha = selectItem ? 1.0 : 0.5
    }
}
