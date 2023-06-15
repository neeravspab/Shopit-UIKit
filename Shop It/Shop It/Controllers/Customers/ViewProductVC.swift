//
//  ViewProductVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/23/22.
//

import UIKit

class ViewProductVC: UIViewController {

    @IBOutlet weak var imgProductimage: UIImageView!
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtSellingPrice: UITextField!
    @IBOutlet weak var txtdescription: UITextView!
    @IBOutlet weak var txtCategories: UITextField!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    
    var productDetail:GetAllProductModel?
    var isfrom = ""
    var productid = Int()
    let userinfo:GetuserDetailModal = DatabaseManager.getInstance().getUserDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Product Detail"
        getProductDetail()
        txtProductName.setLeftPaddingPoints(10)
        txtPrice.setLeftPaddingPoints(10)
        txtSellingPrice.setLeftPaddingPoints(10)
        txtCategories.setLeftPaddingPoints(10)
        
        if isfrom == "like"{
            btnLike.setTitle("Unlike Product", for: .normal)
        } else {
            btnLike.setTitle("Like Product", for: .normal)
        }
    }

    //MARK: IBAction
    
    @IBAction func btnLikeUnlikeClick(_ sender: Any) {
        
        if isfrom == "like" {
            unlikeProduct()
        } else {
            likeProduct(productid: "\(productid)")
        }
    }
    
    @IBAction func btnBuyClick(_ sender: Any) {
        
        if productDetail?.vendor_id != nil {
            let modalInfo = AddToCartModel(user_id: userinfo.id, order_id: "0", total: txtPrice.text!, product_id: "\(productid)", vendor_id: productDetail!.vendor_id, p_name: productDetail!.p_name, price: productDetail!.price, detail: productDetail!.detail, qty: "1", category: productDetail!.category)
            print(modalInfo)
            let isSave = DatabaseManager.getInstance().addToCartProduct(modalInfo)
            
            if isSave == true
            {
                showAlertwithOk(self, msg: "Your Product added to the cart") { alert in
                    self.navigationController?.popViewController(animated: true)
                }
            }
            print(isSave)
        } else {
            showAlert(self, msg: StringConstants.SOMETHINGWENTWRONG)
        }
    }
    
    //MARK: Methods
    
    func getProductDetail() {
        
        productDetail = DatabaseManager.getInstance().getProductDetail(id: "\(productid)")
        
        txtProductName.text = productDetail?.p_name
        txtPrice.text = productDetail?.price
        txtSellingPrice.text = productDetail?.price
        txtdescription.text = productDetail?.detail
        txtCategories.text = productDetail?.category


    }

    func likeProduct(productid:String) {
        
        _ = DatabaseManager.getInstance().likeProduct(userid: userinfo.id, productid: productid)
        showAlertwithOk(self, msg: "Product Liked Successfully.") { alert in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func unlikeProduct() {
        
        _ = DatabaseManager.getInstance().deleteFavouriteProduct(user_id: userinfo.id, productid: "\(productid)")
        showAlertwithOk(self, msg: "You unliked product successfully.") { alert in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
