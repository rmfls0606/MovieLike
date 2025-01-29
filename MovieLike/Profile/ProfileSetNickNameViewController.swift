//
//  ProfileSetViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSetNickNameViewController: UIViewController, UITextFieldDelegate {
    var defaultImageName: String?
    private var nicknameStatus: NicknameResult = .rangeError
    
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
        
        self.profileSetNickNameView.configureTextFieldDelegate(delegate: self)
        
        self.profileSetNickNameView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        profileSetNickNameView.pushNextViewControllerClosure = self.pushNextViewController
    }
    
    private func pushNextViewController(){
        let nextVC = ProfileSelectImageViewController()
        nextVC.selectedImageName = profileSetNickNameView.profileImageButton.profileImageButton.accessibilityIdentifier
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func completePushViewController(user: User){
        
        
    }
}

extension ProfileSetNickNameViewController{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else{
            self.nicknameStatus = .empty
            self.profileSetNickNameView.configureNicknameStatusLabel(text: self.nicknameStatus.resultDescription)
            return
        }
        self.nicknameStatus = nicknameStatus.nickNameIsValid(nickname: text)
        self.profileSetNickNameView.configureNicknameStatusLabel(text: self.nicknameStatus.resultDescription)
    }
}
