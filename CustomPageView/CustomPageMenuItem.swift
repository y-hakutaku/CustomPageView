//
//  CustomPageMenuItem.swift
//  CustomPageView
//
//  Created by Hakutaku on 2018/09/24.
//  Copyright © 2018年 Hakutaku. All rights reserved.
//

import UIKit

class CustomPageMenuItem: UIView {

    var label: UILabel!
    var title: String!

    public init (frame: CGRect, title: String) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.autoresizesSubviews = true
        
        let label: UILabel = UILabel(frame: self.bounds)
        label.text = title
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.addSubview(label)
        self.label = label
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
