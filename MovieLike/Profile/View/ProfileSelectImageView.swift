//
//  ProfileSelectImageView.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSelectImageView: BaseView {
    //선택된/선택한 프로필 이미지
    private let profileSelectedImage = ProfileImageView()
    
    //카메라 아이콘
    private lazy var profileSelectedCameraIcon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        btn.setImage(UIImage(systemName: "camera.fill"), for: .highlighted)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(named: "blueColor")
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    override func configureHierarchy() {
        self.addSubview(profileSelectedImage)
        self.addSubview(profileSelectedCameraIcon)
    }
    
    override func configureLayout() {
        //선택된/선택한 프로필 이미지
        self.profileSelectedImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        //프로필 카메라 아이콘
        self.profileSelectedCameraIcon.snp.makeConstraints { make in
            make.trailing.equalTo(profileSelectedImage)
            make.bottom.equalTo(profileSelectedImage)
            make.size.equalTo(30)
        }
    }
    
    override func configureView() {
        
    }
}
