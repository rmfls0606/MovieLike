//
//  ProfileView.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSetNickNameView: BaseView {
    
    //MARK: - ViewController에서 부터 push하는 함수 받아오기
    var pushNextViewControllerClosure: (() -> Void)?
    
    //MARK: - 뷰 정의
    //프로필 이미지
    private let profileImageButton = ProfileImageView()
    
    // TODO: 카메아 아이콘 더 작게 해보기
    //카메라 아이콘
    private lazy var profileCameraIcon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        btn.setImage(UIImage(systemName: "camera.fill"), for: .highlighted)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(named: "blueColor")
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(profileCameraIconButtonTapped), for: .touchUpInside)
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
    
    //완료 버튼
    private lazy var profileCompleteButton: UIButton = {
        let button = UIButton(configuration: .filled())
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.baseForegroundColor = UIColor(named: "blueColor")
        config.cornerStyle = .capsule
        config.background.strokeColor = UIColor(named: "blueColor")
        config.background.strokeWidth = 2.0
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        config.titleAlignment = .center
        
        var title = AttributedString("완료")
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        config.attributedTitle = title
        
        button.configuration = config
        
        return button
    }()
    
    override func configureHierarchy() {
        self.addSubview(profileImageButton)
        self.addSubview(profileCameraIcon)
        self.addSubview(nickNameStackView)
        self.addSubview(profileCompleteButton)
    }
    
    override func configureLayout() {
        //프로필 이미지
        self.profileImageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
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
        
        //프로필 완료 버튼
        self.profileCompleteButton.snp.makeConstraints { make in
            make.top.equalTo(nickNameStackView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
    }
    
    override func configureView() {
        self.profileImageButton.randomImage()
//        닉네임 설정 화면에서 버튼을 눌렀을 때 실행되는 함수
        self.profileImageButton.buttonTappedClosure = {[weak self] in
            self?.pushNextViewControllerClosure?()
        }
    }
}

extension ProfileSetNickNameView{
    
    //MARK: - 카메라 아이콘을 선택했을 때
    @objc
    private func profileCameraIconButtonTapped(){
        self.pushNextViewControllerClosure?()
    }
}
