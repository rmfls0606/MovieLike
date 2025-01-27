//
//  ProfileView.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {
        
    //MARK: - 뷰 정의
    private let profileImageButton = ProfileImageView()
    private lazy var profileCameraIcon: UIButton = {
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
        self.addSubview(profileImageButton)
        self.addSubview(profileCameraIcon)
    }
    
    override func configureLayout() {
        //프로필 이미지
        self.profileImageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        //프로필 카메라 아이콘
        self.profileCameraIcon.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageButton)
            make.bottom.equalTo(profileImageButton)
            make.size.equalTo(30)
        }
        
    }
    
    override func configureView() {
        self.profileImageButton.randomImage()
    }
}
