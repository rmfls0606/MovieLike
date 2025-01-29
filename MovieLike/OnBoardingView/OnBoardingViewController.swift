//
//  OnBoardingViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

final class OnBoardingViewController: UIViewController {
    
    private let onboardingView = OnBoardingView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure(){
        self.view.backgroundColor = .black
        self.view.addSubview(onboardingView)
        onboardingView.onButtonTapped = { [weak self] in
            self?.startButtonTapped()
        }
        
        self.onboardingView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func startButtonTapped(){
        let nextVc = ProfileSetNickNameViewController()
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
}
