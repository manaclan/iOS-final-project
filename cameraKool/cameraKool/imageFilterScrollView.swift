//
//  imageFilterScrollView.swift
//  cameraKool
//
//  Created by Vinh on 6/28/17.
//  Copyright © 2017 Strong. All rights reserved.
//

import Foundation
import UIKit

class imageFilterScrollView {
    var scrollView : UIScrollView!
    
    init(view: UIView) {
        scrollView.contentSize = CGSize(width: view.frame.width, height: 100)
    }
}
