//
//  BackDropView.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit
import Kingfisher

final class BackDropView: BaseView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var innerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var openDay: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        return label
    }()
    
    private lazy var likePoint: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        return label
    }()
    
    private lazy var genre: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        return label
    }()
    
    private(set) lazy var backDropStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [openDay, lineView(), likePoint, lineView(), genre])
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fill
        return view
    }()
    
    private(set) lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.backgroundColor = .clear
        pageControl.pageIndicatorTintColor = UIColor(named: "lightGrayColor")
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(pageControlPageTapped), for: .valueChanged)
        return pageControl
    }()
    
    override func configureHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(innerView)
        self.addSubview(pageControl)
        self.addSubview(backDropStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        innerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.snp.bottom).offset(-12)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.snp.bottom).offset(-12)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        backDropStackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    override func configureView() {}
    
    @objc private func pageControlPageTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let offsetX = CGFloat(page) * scrollView.frame.width
        
        if scrollView.contentOffset.x == offsetX{ return }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    func insertImage(images: [String]) {
        innerView.subviews.forEach { $0.removeFromSuperview() }
        
        var previousImageView: UIImageView? = nil
        
        for imageName in images {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            innerView.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(scrollView.snp.width)
                make.height.equalTo(200)
                
                if let previousView = previousImageView {
                    make.leading.equalTo(previousView.snp.trailing)
                } else {
                    make.leading.equalToSuperview()
                }
            }
            
            previousImageView = imageView
            
            DispatchQueue.main.async {
                imageView.kf.setImage(with: URL(string: imageName))
            }
        }
        
        previousImageView?.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        pageControl.numberOfPages = images.count
    }
    
    private func lineView() -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor(named: "lightGrayColor")
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        return view
    }
    
    private func createImageTextLabel(imageName: String, text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: imageName)?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedString.append(NSAttributedString(attachment: attachment))
        
        let textString = NSAttributedString(
            string: " \(text)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor(named: "lightGrayColor")!,
            ]
        )
        attributedString.append(textString)
        
        return attributedString
    }
    
    func configureBackDropInfo(data: SearchMovieResult){
        openDay.attributedText = createImageTextLabel(imageName: "calendar", text: DateFormatterManager.shared.formatString(data.release_date))
        if let vote_average = data.vote_average{
            likePoint.attributedText = createImageTextLabel(imageName: "star.fill", text: String(vote_average))
        }else{
            likePoint.attributedText = createImageTextLabel(imageName: "star.fill", text: "-")
        }
        genre.attributedText = createImageTextLabel(imageName: "film.fill", text: GenreMappingModel.returnGenreNames(genre_Ids: data.genre_ids).joined(separator: ","))
    }
}

extension BackDropView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / self.bounds.width + 0.5)
        pageControl.currentPage = page
    }
}
