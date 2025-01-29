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
    private let recentSearchView = RecentSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure(){
        self.view.backgroundColor = .black
        
        self.navigationItem.title = "MovieLike"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        rightBarButton.tintColor = UIColor(named: "blueColor")
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.addSubview(userProfieView)
        self.view.addSubview(recentSearchView)
        
        
        userProfieView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.userProfieView.userProfileView.snp.bottom)
        }
        
        recentSearchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(userProfieView.snp.bottom).offset(12)
        }
    }
}
