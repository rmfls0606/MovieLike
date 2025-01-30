//
//  SetProfileTableViewCell.swift
//  MovieLike
//
//  Created by 이상민 on 1/30/25.
//

import UIKit
import SnapKit

final class SetProfileTableViewCell: BaseTableViewCell {

    static let identifier = "SetProfileTableViewCell"
    
    private lazy var setProfileListTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(setProfileListTitle)
    }
    
    override func configureLayout() {
        setProfileListTitle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }

    func configureData(text: String){
        self.setProfileListTitle.text = text
    }
}
