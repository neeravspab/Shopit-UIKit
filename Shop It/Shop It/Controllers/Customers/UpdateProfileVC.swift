//
//  UpdateProfileVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/22/22.
//

import UIKit

class UpdateProfileVC: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConfirmEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtStreetApt: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    var datePicker :UIDatePicker!
    var gender = String()
    var userinfo:GetuserDetailModal?

    override func viewDidLoad() {
        super.viewDidLoad()

        setDatePiker()
        self.title = "Update Profile"
        setleftpeddding(textfild: txtFirstName)
        setleftpeddding(textfild: txtLastName)
        setleftpeddding(textfild: txtEmail)
        setleftpeddding(textfild: txtConfirmEmail)
        setleftpeddding(textfild: txtPhone)
        setleftpeddding(textfild: txtDOB)
        setleftpeddding(textfild: txtCountry)
        setleftpeddding(textfild: txtState)
        setleftpeddding(textfild: txtCity)
        setleftpeddding(textfild: txtStreetApt)
        setleftpeddding(textfild: txtPassword)
        setleftpeddding(textfild: txtConfirmPassword)
        
        userinfo = DatabaseManager.getInstance().getUserDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")
        
        txtEmail.text = userinfo?.email
        txtFirstName.text = userinfo?.fname
        txtLastName.text = userinfo?.lname
        txtConfirmEmail.text = userinfo?.email
        txtDOB.text = userinfo?.dob
        txtPhone.text = userinfo?.phone
        txtCountry.text = userinfo?.country
        txtState.text = userinfo?.state
        txtCity.text = userinfo?.city
        txtStreetApt.text = userinfo?.address
        txtPassword.text = userinfo?.password
        txtConfirmPassword.text = userinfo?.password
        gender = userinfo?.sex ?? ""

        print(userinfo?.status as Any)
        if gender == "Male" {
            btnMale.setImage(UIImage.init(systemName: "largecircle.fill.circle"), for: .normal)
            btnFemale.setImage(UIImage.init(systemName: "circle"), for: .normal)
        } else {
            btnFemale.setImage(UIImage.init(systemName: "largecircle.fill.circle"), for: .normal)
            btnMale.setImage(UIImage.init(systemName: "circle"), for: .normal)
        }
    }
    
    //MARK: IBAction
    
    @IBAction func btnSubmitClick(_ sender: UIButton) {
        
        if (validateFields())
        {
            let modalInfo = GetuserDetailModal(id: userinfo!.id, lname: txtLastName.text!, fname: txtFirstName.text!, email: txtEmail.text!, phone: txtPhone.text!, dob: txtDOB.text!, country: txtCountry.text!, state: txtState.text!, city: txtCity.text!, address: txtStreetApt.text!, password: txtPassword.text!, sex: gender, status: userinfo!.status, discription: userinfo!.discription)
            print(modalInfo)
           _ = DatabaseManager.getInstance().updateUserProfile(modalInfo)

            showAlertwithOk(self, msg: "Your Profile Has been updatede successfully") { alert in
                self.navigationController?.popViewController(animated: true)
            }
//            print(isSave)
        } else {
            showAlert(self, msg: StringConstants.SOMETHINGWENTWRONG)
        }
    }
    
    @IBAction func btnMaleClick(_ sender: UIButton) {
        btnMale.setImage(UIImage.init(systemName: "largecircle.fill.circle"), for: .normal)
        btnFemale.setImage(UIImage.init(systemName: "circle"), for: .normal)
        gender = "Male"
        
    }
    
    @IBAction func btnFemaleClick(_ sender: UIButton) {
        btnFemale.setImage(UIImage.init(systemName: "largecircle.fill.circle"), for: .normal)
        btnMale.setImage(UIImage.init(systemName: "circle"), for: .normal)
        
        gender = "Female"
    }
    
    @objc func datePickerDone() {
        self.txtDOB.resignFirstResponder()
        let age = calcAge(birthday: "\(datePicker.date.dateStringFromDate("MM/dd/yyyy"))")
        print(age)
        if age <= 18 {
            showAlert(self, msg: StringConstants.AGEVALIDATION)
        } else {
            self.txtDOB.text = "\(datePicker.date.dateStringFromDate("MM/dd/yyyy"))"
        }
    }
    
    @objc func dateChanged() {
        print(datePicker.date)
      //  self.txtDOB.text = "\(datePicker.date.dateStringFromDate("MM/dd/yyyy"))"
        self.txtDOB.text = ""
    }
    
    func setleftpeddding(textfild: UITextField) {
        textfild.setLeftPaddingPoints(10)
    }
    
    func setDatePiker() {
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.maximumDate = Date()
        self.datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        txtDOB.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        txtDOB.inputAccessoryView = toolBar
    }
    
    func validateFields()->Bool{
        
        if (!NullCheck.checkNullNil(txtFirstName.text!))
        {
            showAlert(self, msg: StringConstants.ENTER_FIRSTNAME)
            
            return false
        }
        
        else if (!NullCheck.checkNullNil(txtLastName.text!))
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
        
        else if(!NullCheck.checkNullNil(txtDOB.text!))
        {
            showAlert(self, msg: StringConstants.SELECTDOB)
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
        
        else if(!NullCheck.checkNullNil(txtStreetApt.text!))
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
        
        var arrApprovedUsers:[GetuserDetailModal] = []
        var arrUnApprovedUsers:[GetuserDetailModal] = []

        if "\(Constants.kUserDefaults.value(forKey: "email") ?? "")" == txtEmail.text {
            return true
        } else {
            arrApprovedUsers = DatabaseManager.getInstance().getAllUsers(status: "1")
            if arrApprovedUsers.contains(where: { $0.email == txtEmail.text!}) {
                showAlert(self, msg: StringConstants.USER_EXIST)
                return false
            }
            
            arrUnApprovedUsers = DatabaseManager.getInstance().getAllUsers(status: "0")
            if arrUnApprovedUsers.contains(where: { $0.email == txtEmail.text!}) {
                showAlert(self, msg: StringConstants.USER_EXIST)
                return false
            }
        }

        return true
    }
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }

}
