//
//  RecentSearchView.swift
//  MovieLike
//
//  Created by 이상민 on 1/29/25.
//

import UIKit
import SnapKit

final class RecentSearchView: BaseView {

    private lazy var recentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근검색어"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var allRemoveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("전체 삭제", for: .normal)
        btn.setTitle("전체 삭제", for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(UIColor(named: "blueColor"), for: .normal)
        btn.setTitleColor(UIColor(named: "blueColor"), for: .highlighted)
        return btn
    }()
    
    
    override func configureHierarchy() {
        self.backgroundColor = .red
        self.addSubview(recentTitleLabel)
        self.addSubview(allRemoveButton)
    }
    
    override func configureLayout() {
        recentTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview()
        }
        
        allRemoveButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    override func configureView() {
        
    }
}
