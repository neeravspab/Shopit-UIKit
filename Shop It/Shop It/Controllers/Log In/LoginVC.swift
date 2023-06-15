//
//  LoginVC.swift
//  Shop It
//
//  Created by niravkumar patel on 3/22/22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var isfrom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.setLeftPaddingPoints(10)
        txtPassword.setLeftPaddingPoints(10)
        
        switch isfrom {
        case "Admin":
            btnSignUp.isHidden = true

        case "User":
            btnSignUp.isHidden = false
        case "Vendor":
            btnSignUp.isHidden = false
        default:
            btnSignUp.isHidden = false
        }
    }

    // MARK: - IBAction

    @IBAction func btnLoginClick(_ sender: UIButton) {
        
        print("\(isfrom) Log In Successfull...")
        switch isfrom {
        case "Admin":
            
            if txtEmail.text == "admin@gmail.com" && txtPassword.text == "admin" {
                print("You're just starting out")
                UserDefaults.standard.set(true, forKey: "isAdmin")
                UserDefaults.standard.synchronize()

                Constants.kSharedAppDelegate?.adminTabScreen()
            } else {
                showAlert(self, msg: "Your Credentials Are Incorrect. \n Please Try Again.")
            }

        case "User":
            print("User Click")
            
            var arrUsers:[GetuserDetailModal] = []
            arrUsers = DatabaseManager.getInstance().getAllUsers(status: "1")
            if arrUsers.contains(where: { $0.email == txtEmail.text! && $0.password == txtPassword.text!}) {
                
                UserDefaults.standard.set(true, forKey: "isUser")
                Constants.kUserDefaults.set(txtEmail.text!, forKey: "email")
                UserDefaults.standard.synchronize()
                Constants.kSharedAppDelegate?.userTabScreen()
            } else {
                showAlert(self, msg: "Your Credentials Are Incorrect. \n Or \n You Are Not Approved.\n Please Try Again.")
            }

        case "Vendor":
            print("Vendor Click")
            var arrVendors:[GetVendorListModal] = []
            arrVendors = DatabaseManager.getInstance().getAllVendors(status: "1")
            if arrVendors.contains(where: { $0.email == txtEmail.text! && $0.password == txtPassword.text!}) {
                
                Constants.kUserDefaults.set(txtEmail.text!, forKey: "email")
                UserDefaults.standard.set(true, forKey: "isVendor")
                UserDefaults.standard.synchronize()
                Constants.kSharedAppDelegate?.vendorTabScreen()
            } else {
                showAlert(self, msg: "Your Credentials Are Incorrect. \n Or \n You Are Not Approved.\n Please Try Again.")
            }

        default:
            print("Have you done something new?")
        }
    }
    
    @IBAction func btnSignUPClick(_ sender: UIButton) {
        
        switch isfrom {
        case "Admin":
            
            if txtEmail.text == "admin@gmail.com" && txtPassword.text == "admin" {
                print("You're just starting out")
                Constants.kSharedAppDelegate?.adminScreen()
            }

        case "User":
            print("User Click")
            let userRegistration  = self.storyboard?.instantiateViewController(withIdentifier: "CustomerRagistrationVC") as! CustomerRagistrationVC
            self.navigationController?.pushViewController(userRegistration, animated: true)

        case "Vendor":
            print("Vendor Click")
            let vendorRegistration  = self.storyboard?.instantiateViewController(withIdentifier: "VendorRagistrationVC") as! VendorRagistrationVC
            self.navigationController?.pushViewController(vendorRegistration, animated: true)

        default:
            print("Have you done something new?")
        }
    }
}
