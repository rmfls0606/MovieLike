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
        // TODO: 시작하자마 텍스트필드 선택하게 하기
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
        profileSetNickNameView.completeNickNameClosure = self.completePushViewController
    }
    
    private func pushNextViewController(){
        let nextVC = ProfileSelectImageViewController()
        nextVC.selectedImageName = profileSetNickNameView.profileImageButton.profileImageButton.accessibilityIdentifier
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func completePushViewController(_ user: User){
        if nicknameStatus == .success{
            UserManager.shared.saveUserInfo(user: user)
            
            guard let sceneDelgate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else{
                return
            }
            
            let newVC = MainViewController()
            sceneDelgate.window?.rootViewController = newVC
            sceneDelgate.window?.makeKeyAndVisible()
            
        }else{
            // TODO: alert으로 알려주기
        }
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
