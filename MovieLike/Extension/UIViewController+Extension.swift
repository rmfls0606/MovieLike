//
//  UIViewController+Extension.swift
//  MovieLike
//
//  Created by 이상민 on 1/30/25.
//

import UIKit

extension UIViewController{
    func showAlert(title: String,
    message: String,
    onAction: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "확인", style: .default) { _ in
            onAction()
        }
        alert.addAction(okButton)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
}
