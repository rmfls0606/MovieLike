//
//  OnBoardingView.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

final class OnBoardingView: BaseView {
    
    var onButtonTapped: (() -> Void)?
    
    private lazy var onboardingImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onboarding")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var onBoardingTitle: UILabel = {
        let label = UILabel()
        label.text = "Onboarding"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var onBoardingContent: UILabel = {
        let label = UILabel()
        label.text = "당신만의 영화 세상,\nMovieLike에서 시작해보세요."
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(configuration: .filled())
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.baseForegroundColor = UIColor(named: "blueColor")
        config.cornerStyle = .capsule
        config.background.strokeColor = UIColor(named: "blueColor")
        config.background.strokeWidth = 2.0
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        config.titleAlignment = .center
        
        var title = AttributedString("시작하기")
        title.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = title
        
        button.configuration = config
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func configureHierarchy() {
        self.addSubview(onboardingImageView)
        self.addSubview(onBoardingTitle)
        self.addSubview(onBoardingContent)
        self.addSubview(startButton)
    }
    
    override func configureLayout() {
        self.onboardingImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        
        self.onBoardingTitle.snp.makeConstraints { make in
            make.top.equalTo(onboardingImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        self.onBoardingContent.snp.makeConstraints { make in
            make.top.equalTo(onBoardingTitle.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        self.startButton.snp.makeConstraints { make in
            make.top.equalTo(onBoardingContent.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    override func configureView() {
        
    }
    
    @objc
    private func startButtonTapped(_ sender: UIButton){
        self.onButtonTapped?()
    }
}
