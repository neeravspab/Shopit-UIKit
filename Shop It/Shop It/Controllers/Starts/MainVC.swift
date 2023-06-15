//
//  MainVC.swift
//  Shop It
//
//  Created by niravkumar patel on 3/3/22.
//

import UIKit

class MainVC: UIViewController {

    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: Action
    
    @IBAction func btnAdminClick(_ sender: UIButton) {
        print("Admin Click")
        let adminlogin  = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        adminlogin.isfrom = "Admin"
        self.present(adminlogin, animated: true)
    }
    
    @IBAction func btnUserClick(_ sender: UIButton) {
        print("User Click")
        let userlogin  = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        userlogin.isfrom = "User"
        userlogin.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(userlogin, animated: true)
    }
    
    @IBAction func btnVendorClick(_ sender: UIButton) {
        print("Vendor Click")
        let vendorlogin  = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vendorlogin.isfrom = "Vendor"
        vendorlogin.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(vendorlogin, animated: true)
    }
}

