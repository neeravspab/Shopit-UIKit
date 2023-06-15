//
//  FavouriteVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/23/22.
//

import UIKit

class FavouriteVC: UIViewController {

    @IBOutlet weak var CollectionviewFavouriteProduct: UICollectionView!
    
    var arrFavProducts:[GetAllProductModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userinfo:GetuserDetailModal = DatabaseManager.getInstance().getUserDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")

        arrFavProducts = DatabaseManager.getInstance().getFavouriteProduct(userid: userinfo.id)
        CollectionviewFavouriteProduct.reloadData()
    }
}

//MARK: Collection View Methods

extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFavProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AllProductCollectionviewCell
        
        cell.backgroundViewlayout.layer.cornerRadius = 10
        cell.backgroundViewlayout.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundViewlayout.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.backgroundViewlayout.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundViewlayout.layer.shadowRadius = 3.0
        cell.backgroundViewlayout.layer.shadowOpacity = 1.0
        
        cell.lblProductname.text = arrFavProducts[indexPath.row].p_name
        cell.lblPrice.text = "$" + arrFavProducts[indexPath.row].price

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2-15, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewproductvc  = self.storyboard?.instantiateViewController(withIdentifier: "ViewProductVC") as! ViewProductVC
        viewproductvc.isfrom = "like"
        viewproductvc.productid = Int(arrFavProducts[indexPath.row].product_id)!
            self.navigationController?.pushViewController(viewproductvc, animated: true)
    }
}
