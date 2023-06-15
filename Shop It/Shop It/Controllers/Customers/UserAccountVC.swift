//
//  UserAccountVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/20/22.
//

import UIKit

class UserAccountVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var userinfo:GetuserDetailModal?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        userinfo = DatabaseManager.getInstance().getUserDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")
        
        lblEmail.text = userinfo?.email
        lblName.text = userinfo?.fname
        lblPhoneNumber.text = userinfo?.phone
        lblDOB.text = userinfo?.dob
        lblCountry.text = userinfo?.country
        lblState.text = userinfo?.state
        lblCity.text = userinfo?.city
        lblAddress.text = userinfo?.address
    }
    
    //MARK: IBAction
    
    @IBAction func btnUpdateProfileClick(_ sender: UIButton) {
        let updatesProfile  = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
        self.navigationController?.pushViewController(updatesProfile, animated: true)
    }
    
    @IBAction func btnLogoutClick(_ sender: UIButton) {
        showAlertLogout(self, msg: "Are you sure you want to logout?") { alert in
            Constants.kSharedAppDelegate?.resetDefaults()
            Constants.kSharedAppDelegate?.StartsScreen()
        }
    }
}
