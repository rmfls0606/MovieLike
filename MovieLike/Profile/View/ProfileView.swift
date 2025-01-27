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
    //프로필 이미지
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
    
    //닉네임 스택뷰
    private lazy var nickNameStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nickNameTextfieldPaddingView, nickNameLine, nickNameStatusPaddingView])
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    //닉네임 텍스트필드 패딩뷰
    private lazy var nickNameTextfieldPaddingView: UIView = {
        let view = UIView()
        view.addSubview(nickNameTextField)
        return view
    }()
    
    //닉네임
    private lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요"
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [.foregroundColor: UIColor.white])
        textField.borderStyle = .none
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    //닉네임 구분선
    private lazy var nickNameLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //닉네임 상태 패딩뷰
    private lazy var nickNameStatusPaddingView: UIView = {
        let view = UIView()
        view.addSubview(nickNameStatusLabel)
        return view
    }()
    
    //닉네임 상태 레이블
    private lazy var nickNameStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "blueColor")
        label.text = "닉네임에 숫자는 포함할 수 없어요"
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(profileImageButton)
        self.addSubview(profileCameraIcon)
        self.addSubview(nickNameStackView)
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
        
        
        //닉네임 스택뷰
        self.nickNameStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        //닉네임 텍스트필드 패딩뷰
        self.nickNameTextfieldPaddingView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(nickNameTextField.snp.height)
        }
        
        //닉네임 텍스트필드
        self.nickNameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        //닉네임 구분선
        self.nickNameLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        //닉네임 상태 패딩뷰
        self.nickNameStatusPaddingView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(nickNameTextField.snp.height)
        }
        
        //닉네임 상태 레이블
        self.nickNameStatusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
    }
    
    override func configureView() {
        self.profileImageButton.randomImage()
    }
}
