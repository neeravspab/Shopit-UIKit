//
//  CartVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/24/22.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var tableviewCart: UITableView!
    @IBOutlet weak var heightTableviewCart: NSLayoutConstraint!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    @IBOutlet weak var btnCheckout: UIButton!
    
    var arrCartProduct:[GetAllCartProductModel] = []
    var userinfo:GetuserDetailModal = DatabaseManager.getInstance().getUserDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")
    var finalAmount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCartdata()
    }
    
    //MARK: IBAction
    
    @IBAction func btnCheckOutClick(_ sender: UIButton) {
        
        let orderDate = dateformate()
        let modalInfo = AddOrderModel(user_id: userinfo.id, total: finalAmount,date: orderDate)
        print(modalInfo)
        let isSave = DatabaseManager.getInstance().placeOrderProduct(modalInfo)
        
        if isSave == true {
            showAlertwithOk(self, msg: "Order Placed Successful.") { alert in
                
                _ = DatabaseManager.getInstance().updateCartAfterOrder(order_id: "1", user_id: self.userinfo.id)
                Constants.kSharedAppDelegate?.userTabScreen()
            }
        }
        print(isSave)
    }
    
    @objc func btnPlusClick(_ sender: UIButton) {
        
        var currentqty:Int = Int(arrCartProduct[sender.tag].qty)!
        currentqty += 1
        let totalqty:Int = Int(DatabaseManager.getInstance().getproductqty(product_id: arrCartProduct[sender.tag].product_id)) ?? 0
        print(totalqty)
        print(currentqty)
        if currentqty <= totalqty {
            
            let total = Double(currentqty)*(Double(arrCartProduct[sender.tag].price) ?? 0.00)
            _ = DatabaseManager.getInstance().updateCartQty(product_id: arrCartProduct[sender.tag].product_id, qty: currentqty, total: total)
            
            arrCartProduct.removeAll()
            getCartdata()
        } else {
            showAlert(self, msg: "You can't add more units of \(arrCartProduct[sender.tag].p_name) to your cart as we don't have that many in stock. Please re-adjust the quantity.")
        }
    }
    
    @objc func btnMinusClick(_ sender: UIButton) {
        
        var currentqty:Int = Int(arrCartProduct[sender.tag].qty)!
        
        if currentqty != 1 {
            currentqty -= 1
            print(currentqty)
            let total = Double(currentqty)*(Double(arrCartProduct[sender.tag].price) ?? 0.00)

            _ = DatabaseManager.getInstance().updateCartQty(product_id: arrCartProduct[sender.tag].product_id, qty: currentqty, total: total)
            
            
            arrCartProduct.removeAll()
            getCartdata()
        }
    }
    
    
    func getCartdata() {
        
        arrCartProduct = DatabaseManager.getInstance().getAllCartList(user_id: userinfo.id)
        print(arrCartProduct.count)
        self.tableviewCart.reloadData()

        if arrCartProduct.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.tableviewCart.reloadData()
                self.heightTableviewCart.constant = self.tableviewCart.contentSize.height
                self.btnCheckout.isHidden = false
                let totalamount = DatabaseManager.getInstance().gettotalAmountofCart(user_id: self.userinfo.id, order_id: "0")
                print(totalamount)
                self.lblTotalPrice.text = "$\(totalamount)"
                self.finalAmount = "\(totalamount)"
            })
        } else {
            DispatchQueue.main.async {
                self.heightTableviewCart.constant = 200
                self.btnCheckout.isHidden = true
            }
        }
    }
}

//MARK: Tableview Methods

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrCartProduct.count == 0 {
            self.tableviewCart.setEmptyMessage(StringConstants.NODATAAVAILABLE)
        } else {
            self.tableviewCart.restore()
        }
        return arrCartProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifire, for: indexPath) as! CartTableViewCell
        cell.lblProductName.text = arrCartProduct[indexPath.row].p_name
        cell.lblPrice.text = "$" + arrCartProduct[indexPath.row].price
        cell.lblQty.text = arrCartProduct[indexPath.row].qty
        cell.btnPlus.tag = indexPath.row
        cell.btnMinus.tag = indexPath.row
        cell.btnPlus.addTarget(self, action: #selector(btnPlusClick(_:)), for: .touchUpInside)
        cell.btnMinus.addTarget(self, action: #selector(btnMinusClick(_:)), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let remove = UIContextualAction(style: .normal, title: "Remove") { (action, view, completion) in
          let id = self.arrCartProduct[indexPath.row].cart_id
          _ = DatabaseManager.getInstance().deleteCartProduct(cart_id: id)
          self.arrCartProduct.removeAll()
          self.tableviewCart.reloadData()
          self.getCartdata()
          completion(true)
      }
        remove.backgroundColor = UIColor.red

      return UISwipeActionsConfiguration(actions: [remove])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
