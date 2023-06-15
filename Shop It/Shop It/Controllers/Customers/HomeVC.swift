//
//  HomeVC.swift
//  Shop It
//
//  Created by niravkumar patel on 3/3/22.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var bannerColletionView: UICollectionView!
    @IBOutlet weak var trandlistColletionView: UICollectionView!
    @IBOutlet weak var heightCollectionview: NSLayoutConstraint!
    
    var arrProducts:[GetAllProductModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrProducts = DatabaseManager.getInstance().getProduct()
        heightCollectionview.constant = trandlistColletionView.collectionViewLayout.collectionViewContentSize.height
        trandlistColletionView.reloadData()
    }
}

//MARK: Collectionview Methods

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerColletionView {
            return 4
        } else {
            return arrProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bannerColletionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BannerCollectionViewCell
            cell.bannerImage.layer.cornerRadius = 10

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrandingProductCollectionViewCell
            
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == trandlistColletionView {
            let viewproductvc  = self.storyboard?.instantiateViewController(withIdentifier: "ViewProductVC") as! ViewProductVC
            viewproductvc.isfrom = "home"
            viewproductvc.productid = Int(arrProducts[indexPath.row].product_id)!
                self.navigationController?.pushViewController(viewproductvc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerColletionView {
            return CGSize(width: collectionView.layer.bounds.size.width, height: bannerColletionView.layer.bounds.size.height)
        } else {
            //return CGSize(width: 130.5, height: 180)
            return CGSize(width: collectionView.bounds.width/2-15, height: 200)
        }
    }
}
