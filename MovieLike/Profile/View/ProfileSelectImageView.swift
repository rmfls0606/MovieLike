//
//  ProfileSelectImageView.swift
//  MovieLike
//
//  Created by 이상민 on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileSelectImageView: BaseView {
    //선택된/선택한 프로필 이미지
    private let profileSelectedImage = ProfileImageView()
    
    //카메라 아이콘
    private lazy var profileSelectedCameraIcon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        btn.setImage(UIImage(systemName: "camera.fill"), for: .highlighted)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(named: "blueColor")
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        return btn
    }()
    
    //선택할 수 있는 이미지들 보여주는 CollectionView
    private lazy var collectionView = createCollectionView()
    
    
    override func configureHierarchy() {
        self.addSubview(profileSelectedImage)
        self.addSubview(profileSelectedCameraIcon)
        self.addSubview(collectionView)
    }
    
    override func configureLayout() {
        //선택된/선택한 프로필 이미지
        self.profileSelectedImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        //프로필 카메라 아이콘
        self.profileSelectedCameraIcon.snp.makeConstraints { make in
            make.trailing.equalTo(profileSelectedImage)
            make.bottom.equalTo(profileSelectedImage)
            make.size.equalTo(30)
        }
        
        //선택할 수 있는 이미지들 보여주는 CollectionView
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileSelectedImage.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.collectionView.backgroundColor = .black
    }
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ProfileSelectImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileSelectImageCollectionViewCell.identifier)
        collectionView.collectionViewLayout = createCollectionViewLayout()
        return collectionView
    }
    
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let padding = 12.0
        let spacing = 10.0
        let width = (UIScreen.main.bounds.width - (padding * 2) - (spacing * 3)) / 4
        layout.itemSize = CGSize(width: width, height: width)
        layout.scrollDirection = .vertical
        return layout
    }
    
    func configureDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
    
    func selectedProfileImage(image: UIImage){
        self.profileSelectedImage.selectedProfileImage(image: image)
    }
}
