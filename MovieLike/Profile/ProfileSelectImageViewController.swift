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
    private var selectedIndexPath: IndexPath?
    var selectedImageName: String?
    var editMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure(){
        if editMode{
            self.navigationItem.title = "프로필 이미지 편집"
        }else{
            self.navigationItem.title = "프로필 이미지 설정"
        }
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.view.backgroundColor = .black
        self.view.addSubview(profileSelectImageView)
        self.profileSelectImageView.configureDelegate(delegate: self, dataSource: self)
        if let selectedImageName = self.selectedImageName{
            self.profileSelectImageView.selectedProfileImage(imageName: selectedImageName)
        }
        
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
            cell.selectItem = indexPath == selectedIndexPath
            cell.profileImageButton.layer.cornerRadius = cell.frame.width / 2
            cell.configureBorderColor()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageName = "profile_\(indexPath.item)"
        profileSelectImageView.selectedProfileImage(imageName: imageName)
        
        if let prevIndexPath = selectedIndexPath,
           let previousCell = collectionView.cellForItem(at: prevIndexPath) as? ProfileSelectImageCollectionViewCell {
            previousCell.selectItem = false
            previousCell.configureBorderColor()
        }
        
        if let currentCell = collectionView.cellForItem(at: indexPath) as? ProfileSelectImageCollectionViewCell {
            currentCell.selectItem = true
            currentCell.configureBorderColor()
        }
        
        NotificationCenter.default.post(name: Notification.Name("profileImage"), object: imageName)
        
        self.selectedIndexPath = indexPath
    }
}
