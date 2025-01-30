//
//  SetProfileViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/30/25.
//

import UIKit
import SnapKit

final class SetProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let userProfieView = UserProfileView()
    private let setProfileView = SetProfileView()

    private let titleList: [String] = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
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
        
        self.view.addSubview(setProfileView)
        setProfileView.configureDelegate(delegate: self, dataSource: self)
        
        userProfieView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.userProfieView.userProfileView.snp.bottom)
        }
        
        setProfileView.snp.makeConstraints { make in
            make.top.equalTo(userProfieView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
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

extension SetProfileViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SetProfileTableViewCell.identifier, for: indexPath) as? SetProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureData(text: self.titleList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.titleList.count - 1{
            self.showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.\n탈퇴 하시겠습니까?") {
                UserManager.shared.removeOnBoarding()
                UserManager.shared.removeUserInfo()
                
                
                print("AAA")
                print(UserDefaults.standard
                    .bool(forKey: "onBoarding"))
                
                guard let sceneDelgate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else{
                    return
                }
                
                let newVC = OnBoardingViewController()
                sceneDelgate.window?.rootViewController = newVC
                sceneDelgate.window?.makeKeyAndVisible()
            }
        }
    }
}
