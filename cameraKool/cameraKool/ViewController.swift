//
//  ViewController.swift
//  cameraKool
//
//  Created by Vinh on 6/20/17.
//  Copyright © 2017 Strong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    // MARK: *** Data model
    // MARK: *** UI Elements
    @IBOutlet weak var imagePicked: UIImageView!
    // MARK: *** UI events
    // MARK: *** Local variables
    // MARK: *** UIViewController
    
    @IBAction func openCameraButton(_ sender: Any) {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

