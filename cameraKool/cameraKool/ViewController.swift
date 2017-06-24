//
//  ViewController.swift
//  cameraKool
//
//  Created by Vinh on 6/20/17.
//  Copyright © 2017 Strong. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    // MARK: *** Data model
    // MARK: *** UI Elements
    @IBOutlet weak var imagePicked: UIImageView!
    // MARK: *** UI events
    // MARK: *** Local variables
    // MARK: *** UIViewController
    
    
    @IBAction func openPhotoLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBtn(_ sender: Any) {
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Yay", message: "Your image has been saved to Photo Library!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        })
        
        present(alert, animated: true)
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

