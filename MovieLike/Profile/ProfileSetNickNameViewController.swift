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
    var editMode: Bool = false
    var onDataUpdated: ((User) -> Void)?
    
    private let profileSetNickNameView = ProfileSetNickNameView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure(){
        // TODO: 시작하자마 텍스트필드 선택하게 하기
        if editMode{
            let user = UserManager.shared.getUserInfo()
            self.navigationItem.title = "프로필 편집"
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeButtonTappd))
            leftBarButtonItem.tintColor = UIColor(named: "blueColor")
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            
            let rightButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
            rightButtonItem.tintColor = UIColor(named: "blueColor")
            self.navigationItem.rightBarButtonItem = rightButtonItem
            
            self.profileSetNickNameView.configureUserDate(user: user)
            self.profileSetNickNameView.profileCompleteButton.isHidden = true
        }else{
            self.navigationItem.title = "프로필 설정"
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
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
        nextVC.editMode = self.editMode
        nextVC.selectedImageName = profileSetNickNameView.profileImageButton.profileImageButton.accessibilityIdentifier
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func completePushViewController(_ user: User){
        if nicknameStatus == .success{
            UserManager.shared.saveUserInfo(user: user)
            
            UserManager.shared.saveOnBoarding()
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
    
    @objc
    private func closeButtonTappd(){
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonTapped(){
        if nicknameStatus == .success{
            let imageName = profileSetNickNameView.profileImageButton.profileImageButton.accessibilityIdentifier
            let nickName = profileSetNickNameView.nickNameTextField.text
            let joinDate = UserManager.shared.getJoinDate()
            let user = User(imageName: imageName!, nickname: nickName!, joinDate: joinDate)
            UserManager.shared.saveUserInfo(user: user)
            self.onDataUpdated?(user)
            dismiss(animated: true)
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
