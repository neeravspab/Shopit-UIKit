//
//  VendorRagistrationVC.swift
//  Shop It
//
//  Created by niravkumar patel on 3/29/22.
//

import UIKit

class VendorRagistrationVC: UIViewController {
    
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


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Registration"
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
    }

    // MARK: - Navigation

    
    @IBAction func btnRegisterClick(_ sender: UIButton) {
        if (validateFields())
        {
            let modalInfo = VendorRegistrationModel(storename: txtStoreName.text!, username: txtUserName.text!, email: txtEmail.text!, phone: txtPhone.text!, country: txtCountry.text!, state: txtState.text!, city: txtCity.text!, address: txtBusinessAddress.text!, password: txtPassword.text!, status: "0", discription: "")
            print(modalInfo)
            let isSave = DatabaseManager.getInstance().registerVendor(modalInfo)

            if isSave == true
            {
                print("Sign up successfull...😀😀")
                showAlertwithOk(self, msg: "Your registration is pending...\n Please wait for Approval.") { alert in
                    Constants.kSharedAppDelegate?.StartsScreen()
                }
            }
            print(isSave)
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

        return true
    }
}
