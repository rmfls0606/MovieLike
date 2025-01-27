//
//  ProfileSetViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSetViewController: UIViewController {
    private let profileView = ProfileView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure(){
        self.navigationItem.title = "프로필 설정"
        self.view.backgroundColor = .black
        
        self.view.addSubview(profileView)
        
        self.profileView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
