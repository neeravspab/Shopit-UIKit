//
//  UpdateVendorProfileVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/22/22.
//

import UIKit

class UpdateVendorProfileVC: UIViewController {

    @IBOutlet weak var txtStoreName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConfirmEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtBusinessAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    var userinfo:GetVendorListModal?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Update Profile"
        setleftpeddding(textfild: txtStoreName)
        setleftpeddding(textfild: txtUserName)
        setleftpeddding(textfild: txtEmail)
        setleftpeddding(textfild: txtConfirmEmail)
        setleftpeddding(textfild: txtPhone)
        setleftpeddding(textfild: txtCountry)
        setleftpeddding(textfild: txtState)
        setleftpeddding(textfild: txtCity)
        setleftpeddding(textfild: txtBusinessAddress)
        setleftpeddding(textfild: txtPassword)
        setleftpeddding(textfild: txtConfirmPassword)
        
        userinfo = DatabaseManager.getInstance().getVendorDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")
        
        txtStoreName.text = userinfo?.storename
        txtUserName.text = userinfo?.username
        txtEmail.text = userinfo?.email
        txtConfirmEmail.text = userinfo?.email
        txtPhone.text = userinfo?.phone
        txtCountry.text = userinfo?.country
        txtState.text = userinfo?.state
        txtCity.text = userinfo?.city
        txtBusinessAddress.text = userinfo?.address
        txtPassword.text = userinfo?.password
        txtConfirmPassword.text = userinfo?.password


    }

    // MARK: - IBAction

    @IBAction func btnRegisterClick(_ sender: UIButton) {
        if (validateFields())
        {
            let modalInfo = GetVendorListModal(id: userinfo!.id, storename: txtStoreName.text!, username: txtUserName.text!, email: txtEmail.text!, phone: txtPhone.text!, country: txtCountry.text!, state: txtState.text!, city: txtCity.text!, address: txtBusinessAddress.text!, password: txtPassword.text!, status: userinfo!.status, discription: userinfo!.discription)
            print(modalInfo)
           _ = DatabaseManager.getInstance().updateVendorProfile(modalInfo)

            showAlertwithOk(self, msg: "Your Profile Has been updatede successfully") { alert in
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            showAlert(self, msg: StringConstants.SOMETHINGWENTWRONG)
        }

    }
    
    @IBAction func btnMaleClick(_ sender: UIButton) {}
    
    @IBAction func btnFemaleClick(_ sender: UIButton) {}

    func setleftpeddding(textfild: UITextField) {
        textfild.setLeftPaddingPoints(10)
    }
    
    func validateFields()->Bool{
        
        if (!NullCheck.checkNullNil(txtStoreName.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_FIRSTNAME)
            
            return false
        }
        
        else if (!NullCheck.checkNullNil(txtUserName.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_LASTNAME)
            
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtEmail.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_EMAIL)
            
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtConfirmPassword.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_EMAIL)
            
            return false
        }
        
        else if(!NullCheck.isValidEmail(email: txtEmail.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_VALIDEMAIL)
            return false
        }
        
        else if(!NullCheck.isValidEmail(email: txtConfirmEmail.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_VALIDEMAIL)
            return false
        }
        
        else if (txtEmail.text! != txtConfirmEmail.text!)
        {
            showAlert(self, msg: StringConstants.VALID_EMAIL)
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtPhone.text!))
        {
            showAlert(self, msg: StringConstants.ENTERMOBILENUMBER)
            return false
        }
        
        else if(txtPhone.text!.count != 10)
        {
            showAlert(self, msg: StringConstants.VALIDMOBILENUMBER)
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtCountry.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_COUNTRY)
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtState.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_STATE)
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtCity.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_TOWNCITY)
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtBusinessAddress.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_ADDRESS)
            return false
        }

        else if(!NullCheck.checkNullNil(txtPassword.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_PASSWORD)
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtConfirmPassword.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_CNFPASSWORD)
            return false
        }
        
        else if (txtConfirmPassword.text! != txtPassword.text!)
        {
            showAlert(self, msg: StringConstants.CNDF_PASSWORD)
            return false
        }
        
        var arrApprovedVendors:[GetVendorListModal] = []
        var arrUnApprovedVendors:[GetVendorListModal] = []

        if "\(Constants.kUserDefaults.value(forKey: "email") ?? "")" == txtEmail.text {
            return true
        } else {
            arrApprovedVendors = DatabaseManager.getInstance().getAllVendors(status: "1")
            if arrApprovedVendors.contains(where: { $0.email == txtEmail.text!}) {
                showAlert(self, msg: StringConstants.USER_EXIST)
                return false
            }
            
            arrUnApprovedVendors = DatabaseManager.getInstance().getAllVendors(status: "0")
            if arrUnApprovedVendors.contains(where: { $0.email == txtEmail.text!}) {
                showAlert(self, msg: StringConstants.USER_EXIST)
                return false
            }
        }
        return true
    }
}
