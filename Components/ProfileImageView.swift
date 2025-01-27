//
//  ProfileImageView.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit

final class ProfileImageView: BaseView {

    //MARK: - 뷰 정의
    private lazy var profileImageButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 50
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor(named: "blueColor")?.cgColor
        btn.alpha = 0.5
        return btn
    }()
    
    override func configureHierarchy() {
        self.addSubview(profileImageButton)
    }
    
    override func configureLayout() {
        profileImageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // TODO: 사용하는 곳이 1곳 밖에 없으므로 해당 View로 빼기
    func randomImage(){
        let imageIndex = Int.random(in: 0...11)
        let imageName = "profile_\(imageIndex)"
        let image = UIImage(named: imageName)
        self.profileImageButton.setImage(image, for: .normal)
        self.profileImageButton.setImage(image, for: .highlighted)
        self.profileImageButton.alpha = 1.0
        self.profileImageButton.layer.borderWidth = 3.0
    }
    
}
