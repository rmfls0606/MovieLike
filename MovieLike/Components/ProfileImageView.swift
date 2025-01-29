//
//  ProfileImageView.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit

final class ProfileImageView: BaseView {

    //MARK: - 뷰 정의
    private(set) lazy var profileImageButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 50
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        btn.alpha = 0.5
        return btn
    }()
    
    //클로저를 이용하여 액션 전달
    var buttonTappedClosure: (() -> Void)?
    
    override func configureHierarchy() {
        self.addSubview(profileImageButton)
    }
    
    override func configureLayout() {
        profileImageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // TODO: 사용하는 곳이 1곳 밖에 없으므로 해당 View로 빼기
    //랜덤 이미지 넣기
    func randomImage(){
        let imageIndex = Int.random(in: 0...11)
        let imageName = "profile_\(imageIndex)"
        let image = UIImage(named: imageName)
        self.profileImageButton.setImage(image, for: .normal)
        self.profileImageButton.setImage(image, for: .highlighted)
        self.profileImageButton.layer.borderColor = UIColor(named: "blueColor")?.cgColor
        self.profileImageButton.alpha = 1.0
        self.profileImageButton.layer.borderWidth = 3.0
        self.profileImageButton.accessibilityIdentifier = imageName
    }
    
    //원하는 이미지 넣기
    func selectImage(imageName: String){
        let profileImage = UIImage(named: imageName)
        self.profileImageButton.setImage(profileImage, for: .normal)
        self.profileImageButton.setImage(profileImage, for: .highlighted)
        self.profileImageButton.accessibilityIdentifier = imageName
    }
    
    //사용자가 선택한 이미지를 상단 프로필 이미지로 보여주는 함수
    func selectedProfileImage(imageName: String){
        let profileImage = UIImage(named: imageName)
        self.profileImageButton.setImage(profileImage, for: .normal)
        self.profileImageButton.setImage(profileImage, for: .highlighted)
        self.profileImageButton.layer.borderColor = UIColor(named: "blueColor")?.cgColor
        self.profileImageButton.alpha = 1.0
        self.profileImageButton.layer.borderWidth = 3.0
        self.profileImageButton.accessibilityIdentifier = imageName
    }
    
    @objc
    private func buttonTapped() {
        buttonTappedClosure?()
    }
}
