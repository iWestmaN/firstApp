//
//  AddCar.swift
//  firstApp
//
//  Created by Igor Lishchenko on 11/22/18.
//  Copyright © 2018 Igor Lishchenko. All rights reserved.
//

import UIKit

class AddCar: UITableViewController  {
    @IBOutlet weak var carAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func selectCarAvatar(_ sender: UIButton) {
        let controller = UIImagePickerController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
   

}
extension AddCar: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        carAvatar.image = img
        picker.dismiss(animated: true, completion: nil)
    }
}
