//
//  AddProductVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/21/22.
//

import UIKit

class AddProductVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgProductimage: UIImageView!
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtSellingPrice: UITextField!
    @IBOutlet weak var txtdescription: UITextView!
    @IBOutlet weak var txtQty: UITextField!
    @IBOutlet weak var txtCategories: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    var isfrom = ""
    var productid = Int()
    var productDetail:GetAllProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Product"
        txtProductName.setLeftPaddingPoints(10)
        txtPrice.setLeftPaddingPoints(10)
        txtSellingPrice.setLeftPaddingPoints(10)
        txtQty.setLeftPaddingPoints(10)
        txtCategories.setLeftPaddingPoints(10)
        
        txtProductName.isUserInteractionEnabled = true
        txtPrice.isUserInteractionEnabled = true
        txtSellingPrice.isUserInteractionEnabled = true
        txtdescription.isUserInteractionEnabled = true
        txtQty.isUserInteractionEnabled = true
        txtCategories.isUserInteractionEnabled = true
        
        if isfrom == "add" {
            
            btnUpdate.setTitle("Add Product", for: .normal)
            btnDelete.isHidden = true
            
        } else if isfrom == "update" {
            
            btnUpdate.setTitle("Update Product", for: .normal)
            btnDelete.isHidden = false
            getProductDetail()
            
        } else if isfrom == "view" {
            
            btnUpdate.isHidden = true
            btnDelete.isHidden = true
            
            txtProductName.isUserInteractionEnabled = false
            txtPrice.isUserInteractionEnabled = false
            txtSellingPrice.isUserInteractionEnabled = false
            txtdescription.isUserInteractionEnabled = false
            txtQty.isUserInteractionEnabled = false
            txtCategories.isUserInteractionEnabled = false
            
            getProductDetail()
        }
    }
    
    // MARK: IBAction
    
    @IBAction func btnOpencamera(_ sender: Any) {
    }
    
    @IBAction func btnUpdateClick(_ sender: Any) {
        
        let userinfo:GetVendorListModal = DatabaseManager.getInstance().getVendorDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")
        let vendorid = userinfo.id        
        if isfrom == "add" {
            if (validateFields()) {
                let modalInfo = AddProductModel(vendor_id: "\(vendorid)", p_name: txtProductName.text!, price: txtPrice.text!, detail: txtdescription.text!, qty: txtQty.text!, category: txtCategories.text!)
                print(modalInfo)
                let isSave = DatabaseManager.getInstance().addProduct(modalInfo)
                
                if isSave == true {
                    print("Product Add Successfull...😀😀")
                    showAlertwithOk(self, msg: "Your product is added...") { alert in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                print(isSave)
                
            } else {
                showAlert(self, msg: StringConstants.SOMETHINGWENTWRONG)
            }
        } else {
            if (validateFields()) {
                
                let modalInfo = GetAllProductModel(product_id: "\(productid)", vendor_id: "\(vendorid)", p_name: txtProductName.text!, price: txtPrice.text!, detail: txtdescription.text!, qty: txtQty.text!, category: txtCategories.text!)
                print(modalInfo)
                _ = DatabaseManager.getInstance().updateProductDetail(modalInfo)
                
                showAlert(self, msg: "Your Product Has Been Updated.")
                getProductDetail()
            }  else {
                showAlert(self, msg: StringConstants.SOMETHINGWENTWRONG)
            }
        }
    }
    
    @IBAction func btnDeleteClick(_ sender: Any) {
        
        _ = DatabaseManager.getInstance().deleteProduct(productid)
        showAlertwithOk(self, msg: "Your product is Deleted...") { alert in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCategories {
            // self.keyboardHide()
            guard let selectCategories = self.storyboard?.instantiateViewController(withIdentifier: "SelectCategoryVC") as? SelectCategoryVC else {return false}
            selectCategories.modalPresentationStyle = .overFullScreen
            selectCategories.delegate = self
            self.navigationController?.present(selectCategories, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func getProductDetail() {
        
        productDetail = DatabaseManager.getInstance().getProductDetail(id: "\(productid)")
        
        txtProductName.text = productDetail?.p_name
        txtPrice.text = productDetail?.price
        txtSellingPrice.text = productDetail?.price
        txtdescription.text = productDetail?.detail
        txtQty.text = productDetail?.qty
        txtCategories.text = productDetail?.category
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

extension AddProductVC : Categoriresdelegate {
    func selectedCategories(category:String) {
        txtCategories.text = category
    }
}

// MARK: Supported Method

extension AddProductVC {
    
    func validateFields()->Bool{
        
        if (!NullCheck.checkNullNil(txtProductName.text!))
        {
            showAlert(self, msg: "Please Enter Product Name.")
            
            return false
        }
        
        else if (!NullCheck.checkNullNil(txtPrice.text!))
        {
            showAlert(self, msg: "Please Enter Price.")
            
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtSellingPrice.text!))
        {
            showAlert(self, msg: "Please Ente3r Selling Price.")
            
            return false
        }
        
        else if(!NullCheck.checkNullNil(txtdescription.text!))
        {
            showAlert(self, msg: "Please Enter Description.")
            
            return false
        }
        
        else if (!NullCheck.checkNullNil(txtQty.text!))
        {
            showAlert(self, msg: "Please Enter Quentity.")
            return false
        }
        
        else if (!NullCheck.checkNullNil(txtCategories.text!))
        {
            showAlert(self, msg: "Please Select Category.")
            return false
        }
        
        return true
    }
        
}
