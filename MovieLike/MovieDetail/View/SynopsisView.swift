//
//  Synopsis.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class SynopsisView: BaseView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 3
        label.text = "Syopsis"
        return label
    }()
    
    private(set) lazy var MoreButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("More", for: .normal)
        btn.setTitle("More", for: .highlighted)
        btn.setTitleColor(UIColor(named: "blueColor"), for: .normal)
        btn.setTitleColor(UIColor(named: "blueColor"), for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return btn
    }()
    
    private lazy var synopsisHeaderView: UIView = {
        let view = UIView()
        view.addSubview(title)
        view.addSubview(MoreButton)
        return view
    }()
    
    private(set) lazy var content: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = "이것은 연습용 문구입니다. 이것은 연습용 문구입니다. 이것은 연습용 문구입니다. 이것은 연습용 문구입니다. 이것은 연습용 문구입니다.이것은 연습용 문구입니다."
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(synopsisHeaderView)
        self.addSubview(content)
    }
    
    override func configureLayout() {
        self.synopsisHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        self.title.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.trailing.equalTo(MoreButton.snp.leading).offset(-6)
        }
        
        self.MoreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.content.snp.makeConstraints { make in
            make.top.equalTo(synopsisHeaderView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
