//
//  ProfileSelectImageViewController.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSelectImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let profileSelectImageView = ProfileSelectImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure(){
        self.navigationItem.title = "프로필 이미지 설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.view.backgroundColor = .black
        self.view.addSubview(profileSelectImageView)
        self.profileSelectImageView.configureDelegate(delegate: self, dataSource: self)
        
        profileSelectImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension ProfileSelectImageViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileSelectImageCollectionViewCell.identifier, for: indexPath) as? ProfileSelectImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let image = UIImage(named: "profile_\(indexPath.item)"){
            cell.configure(image: image)
        }
        return cell
    }
}
