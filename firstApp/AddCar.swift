//
//  AddCar.swift
//  firstApp
//
//  Created by Igor Lishchenko on 11/22/18.
//  Copyright © 2018 Igor Lishchenko. All rights reserved.
//

import UIKit
import Parse


let myCar = Car.init()

class AddCar: UITableViewController  {
    @IBOutlet weak var carAvatar: UIImageView!
    @IBOutlet weak var carName: UITextField!
    @IBOutlet weak var carOdometr: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLogin()
    }
    
    func addcar() {
        //        var carNameAdd = UserDefaults.standard.string(forKey: "kCarName")
        //        carNameAdd = carName.text
        //        UserDefaults.standard.set(carNameAdd, forKey: "kCarName")
        //        var carOdometrAdd = UserDefaults.standard.string(forKey: "kCarOdometr")
        //        carOdometrAdd = carOdometr.text
        //        UserDefaults.standard.set(carOdometrAdd, forKey: "kCarOdometr")
        //        myCar.carName = String(carName.text!)
        //        myCar.carOdometer = Int(carOdometr.text!)!
        //        myCar.carAvatar = carAvatar.image!
       
        let carmodel = String(carName.text!)
        let carodometr = Int(carOdometr.text!)!
        let caravatar1 = carAvatar.image!
        let imageData = caravatar1.pngData()
        let imageFile = PFFileObject(name:"avatar.png", data:imageData!)
        let car = PFObject(className: "Car")
        car["model"] = carmodel
        car["odometr"] = carodometr
        car["caravatar"] = imageFile
        car.saveEventually()
        
    }
    
    @IBAction func selectCarAvatar(_ sender: UIButton) {
        let controller = UIImagePickerController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func saveCar(_ sender: UIButton) {
        addcar()
     
        
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
extension AddCar: PFSignUpViewControllerDelegate {
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        log(PFLogInViewController(), didLogIn: user)
    }
}

extension AddCar: PFLogInViewControllerDelegate {
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        print("welcome", user.username!)
        navigationItem.title = user.username!
        dismiss(animated: true, completion: nil)
    }
    
    func checkLogin() {
        
        if PFUser.current() == nil {
            // Show the signup or login screen
            let loginVC = PFLogInViewController()
            loginVC.delegate = self
            loginVC.signUpController?.delegate = self
            //            loginVC.de
            present(loginVC, animated: true, completion: nil)
        }
        //        PFUser.logOut()
    }
    
    
}
