//
//  UIImage+StringUrlToImage.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 07/09/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromStringUrl(stringUrl: String){
        
        DispatchQueue.global().async {
            if let url = URL(string: stringUrl) {
                if let imageData = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
    }
    
    func makeImageCircler(){
        self.layer.cornerRadius = self.frame.width / 2
    }
}
