//
//  AllProductVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/23/22.
//

import UIKit

class AllProductVC: UIViewController {

    @IBOutlet weak var CollectionviewAllProduct: UICollectionView!
    var arrProducts:[GetAllProductModel] = []

    var isfrom = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "All Products"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isfrom == "admin" {
            arrProducts = DatabaseManager.getInstance().getProduct()
            CollectionviewAllProduct.reloadData()

        } else {
            let userinfo:GetVendorListModal = DatabaseManager.getInstance().getVendorDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")
            let vendorid = userinfo.id
            arrProducts = DatabaseManager.getInstance().getAllProduct(vendorid: vendorid)
            CollectionviewAllProduct.reloadData()
        }
    }
}

// MARK: CollectionView Methods

extension AllProductVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrProducts.count == 0 {
            self.CollectionviewAllProduct.setEmptyMessage(StringConstants.NODATAAVAILABLE)
        } else {
            self.CollectionviewAllProduct.restore()
        }
        return arrProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AllProductCollectionviewCell
        
        cell.backgroundViewlayout.layer.cornerRadius = 10
        cell.backgroundViewlayout.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundViewlayout.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.backgroundViewlayout.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundViewlayout.layer.shadowRadius = 3.0
        cell.backgroundViewlayout.layer.shadowOpacity = 1.0
        
        cell.lblProductname.text = arrProducts[indexPath.row].p_name
        cell.lblPrice.text = "$" + arrProducts[indexPath.row].price
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2-15, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let addproductvc  = self.storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
        addproductvc.isfrom = "view"
        addproductvc.productid = Int(arrProducts[indexPath.row].product_id)!
            self.navigationController?.pushViewController(addproductvc, animated: true)
    }
}
