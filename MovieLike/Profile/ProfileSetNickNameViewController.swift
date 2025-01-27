//
//  ProfileSetViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSetNickNameViewController: UIViewController {
    var defaultImageName: String?
    
    private let profileSetNickNameView = ProfileSetNickNameView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure(){
        self.navigationItem.title = "프로필 설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.view.backgroundColor = .black
        
        self.view.addSubview(profileSetNickNameView)
        
        self.profileSetNickNameView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        profileSetNickNameView.pushNextViewControllerClosure = self.pushNextViewController
    }
    
    func pushNextViewController(){
        let nextVC = ProfileSelectImageViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
