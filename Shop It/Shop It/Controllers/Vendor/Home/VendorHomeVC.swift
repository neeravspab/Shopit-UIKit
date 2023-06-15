//
//  VendorHomeVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/21/22.
//

import UIKit

class VendorHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnAddProductClick(_ sender: Any) {
        let addproductvc  = self.storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
        addproductvc.isfrom = "add"
            self.navigationController?.pushViewController(addproductvc, animated: true)
    }
    
    @IBAction func btnAllProductCLick(_ sender: Any) {
        let viewproduct  = self.storyboard?.instantiateViewController(withIdentifier: "AllProductVC") as! AllProductVC
        viewproduct.isfrom = "view"
            self.navigationController?.pushViewController(viewproduct, animated: true)
    }
    
    @IBAction func btnUpdateProductCLick(_ sender: Any) {
        let addproductvc  = self.storyboard?.instantiateViewController(withIdentifier: "AllProductVC") as! AllProductVC
        addproductvc.isfrom = "update"
            self.navigationController?.pushViewController(addproductvc, animated: true)

    }
}
