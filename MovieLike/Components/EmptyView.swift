//
//  EmptyView.swift
//  MovieLike
//
//  Created by 이상민 on 1/30/25.
//

import UIKit
import SnapKit

final class EmptyView: BaseView {

    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "lightGrayColor")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
    
    func configureData(text: String){
        self.emptyLabel.text = text
    }
}
