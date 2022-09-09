//
//  SawdoView.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 07/09/2022.
//

import UIKit

class ShadowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeShadoView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeShadoView()
    }
    
    func makeShadoView() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = 5
    }
}
