//
//  UserProfileView.swift
//  MovieLike
//
//  Created by 이상민 on 1/28/25.
//

import UIKit

final class UserProfileView: BaseView {
    var onTapGesureClosure: (() -> Void)?
    private let user = UserManager.shared.getUserInfo()
    
    //MARK: - 뷰 정의
    //사용자 프로필 정보 뷰
    private(set) lazy var userProfileView: UIView = {
        let view = UIView()
        view.addSubview(userProfileInnerView)
        view.addSubview(userSavedMovieBoxLabel)
        view.backgroundColor = UIColor(named: "darkGrayColor")
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(userProfileViewTapped))]
        return view
    }()
    
    //여백안의 이너 뷰
    private lazy var userProfileInnerView: UIView = {
        let view = UIView()
        view.addSubview(userProfileImageView)
        view.addSubview(userInfoView)
        view.addSubview(rightArrowIcon)
        return view
    }()
    
    //사용자 닉네임, 가입날짜 뷰
    private lazy var userInfoView: UIView = {
        let view = UIView()
        view.addSubview(userInfoCenterYView)
        return view
    }()
    
    //가운데 정렬
    private lazy var userInfoCenterYView: UIView = {
        let view = UIView()
        view.addSubview(userNicknameLabel)
        view.addSubview(userJoinDate)
        return view
    }()
    
    // TODO: 재사용되는 이미지 뷰로 사용 (지금은 button인데 imageView로 수정 예정)
    // TODO: 유저 정보 싱글톤으로 구현하여 모든 곳에서 이미지, 닉네임 사용할 수 있게 하기
    //사용자 프로필 이미지
    private lazy var userProfileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor(named: "blueColor")?.cgColor
        view.alpha = 1.0
        return view
    }()
    
    //사용자 닉네임
    private lazy var userNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    //사용자 가입날짜
    private lazy var userJoinDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        return label
    }()
    
    //사용자 보관중인 무비박스
    private lazy var userSavedMovieBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "0개의 무비박스 보관중"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(named: "blueColor")
        return label
    }()
    
    private lazy var rightArrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = UIColor(named: "lightGrayColor")
        return view
    }()
    
    
    override func configureHierarchy() {
        self.addSubview(userProfileView)
        
    }
    
    override func configureLayout() {
        self.userProfileView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(userSavedMovieBoxLabel.snp.bottom).offset(12)
        }
        
        self.userProfileInnerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(userProfileImageView.snp.bottom)
        }
        
        self.userProfileImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(60)
        }
        
        self.userInfoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(userProfileImageView.snp.trailing).offset(6)
            make.trailing.equalTo(rightArrowIcon.snp.leading).offset(-6)
        }
        
        self.userInfoCenterYView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.userNicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.userJoinDate.snp.makeConstraints { make in
            make.top.equalTo(userNicknameLabel.snp.bottom).offset(3)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.rightArrowIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(15)
        }
        
        
        self.userSavedMovieBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(userProfileInnerView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(40)
        }
        
    }
    
    override func configureView() {
        self.userProfileImageView.image = UIImage(named: self.user.imageName)
        self.userNicknameLabel.text = self.user.nickname
        self.userJoinDate.text = "\(self.user.joinDate) 가입"
    }
    
    @objc
    private func userProfileViewTapped(){
        self.onTapGesureClosure?()
    }
    
    func configureData(user: User){
        self.userProfileImageView.image = UIImage(named: user.imageName)
        self.userNicknameLabel.text = user.nickname
        self.userJoinDate.text = "\(user.joinDate) 가입"
    }
}
