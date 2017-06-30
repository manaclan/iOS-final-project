//
//  PhotoViewController.swift
//  cameraKool
//
//  Created by Vinh on 6/24/17.
//  Copyright © 2017 Strong. All rights reserved.
//

import Foundation
/*Copyright (c) 2016, Andrew Walz.
 Redistribution and use in source and binary forms, with or without modification,are permitted provided that the following conditions are met:
 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
 BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */

import UIKit
import SwiftyCam

class PhotoViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private var backgroundImage: UIImage
    
    
    
    init(image: UIImage) {
        self.backgroundImage = image
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        let backgroundImageView = UIImageView(frame: view.frame)
        let BackgroundImageViewTag = 1
        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFit
        backgroundImageView.image = backgroundImage
        backgroundImageView.tag = BackgroundImageViewTag
        view.addSubview(backgroundImageView)
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        let saveButton = UIButton(frame: CGRect(x: view.frame.width - 40.0, y: 10.0, width: 30.0, height: 30.0))
        saveButton.setImage(#imageLiteral(resourceName : "save") , for: UIControlState())
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        
        
        let filterScrollView = UIScrollView(frame: CGRect(x: 0, y: (self.view.frame.height)-80, width: (self.view.frame.width), height: 80 ))
        let FILTER_SCROLLVIEW_TAG  = 2
        filterScrollView.isUserInteractionEnabled = true
        filterScrollView.tag = FILTER_SCROLLVIEW_TAG
        self.createFilterButton(scrollView: filterScrollView, imageView: (self.view))
        self.view.addSubview(filterScrollView)
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    func save(){
        let customPhotoAlbum = CustomPhotoAlbum.sharedInstance
        customPhotoAlbum.save(image: self.backgroundImage)
        dismiss(animated: true, completion: nil)
    }
    
    func getBackgroundImage() -> UIImage{
        return backgroundImage
    }
    func setBackgroundImage(image: UIImage){
        backgroundImage = image
    }
    func getView() ->UIView{
        return self.view
    }
    
    func getPhotoViewController() -> PhotoViewController{
        return self
    }
    
    func createFilterButton(scrollView: UIScrollView, imageView: UIView){
        var CIFilterNames = [
            "CIPhotoEffectChrome",
            "CIPhotoEffectFade",
            "CIPhotoEffectInstant",
            "CIPhotoEffectNoir",
            "CIPhotoEffectProcess",
            "CIPhotoEffectTonal",
            "CIPhotoEffectTransfer",
            "CISepiaTone"
        ]
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        
        let buttonHeight: CGFloat = 70
        let buttonWidth:CGFloat = buttonHeight*(imageView.frame.width)/(imageView.frame.height)
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        
        for filterNameNumber in 0..<CIFilterNames.count {
            itemCount = filterNameNumber
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self, action: #selector(self.filterButtonTapped(sender:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: (self.backgroundImage))
            let filter = CIFilter(name: "\(CIFilterNames[filterNameNumber])")
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            
            let imageForButton = UIImage(cgImage: filteredImageRef!, scale: self.backgroundImage.scale, orientation: backgroundImage.imageOrientation)
            
            filterButton.setBackgroundImage(imageForButton, for: .normal)
            
            xCoord +=  buttonWidth + gapBetweenButtons
            scrollView.addSubview(filterButton)
        }
        
        scrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+2), height: yCoord)
    }
    
    func filterButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        
        let backgroundImage = button.backgroundImage(for: UIControlState.normal)!
        let BACKGROUND_IMAGEVIEW_TAG = 1
        let backgroundImageView = self.view.viewWithTag(BACKGROUND_IMAGEVIEW_TAG) as! UIImageView
        backgroundImageView.image = backgroundImage
        self.backgroundImage = backgroundImage
        
        
    }
    
}
