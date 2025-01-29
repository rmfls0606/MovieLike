//
//  MainViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/28/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let userProfieView = UserProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure(){
        self.view.backgroundColor = .black
        self.view.addSubview(userProfieView)
        
        userProfieView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
}
