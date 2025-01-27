//
//  ProfileSelectImageViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSelectImageViewController: UIViewController {
    private let profileSelectImageView = ProfileSelectImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure(){
        self.navigationItem.title = "프로필 이미지 설정"
        
        self.view.backgroundColor = .black
        self.view.addSubview(profileSelectImageView)
        
        profileSelectImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
