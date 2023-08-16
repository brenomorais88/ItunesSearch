//
//  UIImageView+Extension.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import UIKit

extension UIImageView {

    public func imageFromURL(urlString: String) {
        if self.image == nil{
            self.image = UIImage(named: Strings.kPlaceholder.rawValue)
        }
        
        guard let url = NSURL(string: urlString) else {
            self.image = UIImage(named: Strings.kPlaceholder.rawValue)
            return
        }
        
        URLSession.shared.dataTask(with: url as URL,
                                   completionHandler: { (data, response, error) -> Void in

            if error != nil {
                self.image = UIImage(named: Strings.kPlaceholder.rawValue)
                return
            }
            
            guard let imgData = data else {
                self.image = UIImage(named: Strings.kPlaceholder.rawValue)
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: imgData)
                self.image = image
            })

        }).resume()
    }
}
