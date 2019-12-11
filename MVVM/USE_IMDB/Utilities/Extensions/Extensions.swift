//
//  Extensions.swift
//  USE_IMDB
//
//  Created by Usemobile on 15/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

// MARK: Primitive types (String, Int, ...)

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}

// MARK: UI Components (UIView, UIImageView, ...)

extension UIImageView {
    
    func cast(urlStr: String?, placeholder: UIImage? = nil, completion: ((UIImage?, String?) -> Void)? = nil) {
        guard let urlStr = urlStr else {
            if let placeHolder = placeholder {
                self.image = placeHolder
            }
            return
        }
        if let data = UserDefaults.standard.object(forKey: urlStr) as? Data, let image = UIImage(data: data) {
            completion?(image, nil)
            self.image = image
        } else {
            self.image = placeholder
            guard let url = URL.init(string: urlStr) else {
                completion?(nil, "INVALID_URL_TEXT".localized)
                return
            }
            URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(data, forKey: urlStr)
                        let image: UIImage? = UIImage(data: data)
                        completion?(image, nil)
                        self.image = image ?? placeholder
                    }
                } else if let error = error {
                    completion?(nil, error.localizedDescription)
                } else {
                    completion?(nil, "IMAGE_FETCH_FAILURE_TEXT".localized)
                }
                }.resume()
        }
    }
}

extension UIViewController {
    
    func showAlertCommon(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "OK_TEXT".localized, style: .default, handler: handler)
        alert.addAction(btnOk)
        self.present(alert, animated: true, completion: nil)
    }
    
}
