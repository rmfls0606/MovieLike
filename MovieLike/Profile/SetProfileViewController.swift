//
//  SetProfileViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/30/25.
//

import UIKit
import SnapKit

final class SetProfileViewController: UIViewController {
    
    private let userProfieView = UserProfileView()
//    private let setProfileView = SetProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       configure()
    }
    
    private func configure(){
        self.view.backgroundColor = .black
        
        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.view.addSubview(userProfieView)
        userProfieView.onTapGesureClosure = presentViewController
        
        userProfieView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.userProfieView.userProfileView.snp.bottom)
        }
    }
    
    private func presentViewController(){
        let presentVC = ProfileSetNickNameViewController()
        presentVC.editMode = true
        presentVC.onDataUpdated = { [weak self] newData in
            self?.userProfieView.configureData(user: newData)
        }
        let navigationVC = UINavigationController(rootViewController: presentVC)
        self.present(navigationVC, animated: true)
    }
}
