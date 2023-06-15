//
//  HomeAdminVC.swift
//  Shop It
//
//  Created by niravkumar patel on 3/25/22.
//

import UIKit

class HomeAdminVC: UIViewController {

    let arrAdminCategoryList = ["Approve Store Manager","Approve Customers","View Products","View Orders", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - collectionView

extension HomeAdminVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAdminCategoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!
        HomeAdminCollectionCell
        cell.lblTitle.text = arrAdminCategoryList[indexPath.row]
        cell.addShadow(offset: CGSize(width: 0, height: 4), color: .systemTeal, radius: 3, opacity: 0.7)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2-25, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if arrAdminCategoryList[indexPath.row] == "Approve Customers" {
            let userRegistration  = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
            self.navigationController?.pushViewController(userRegistration, animated: true)
        }
        
        else if arrAdminCategoryList[indexPath.row] == "Approve Store Manager" {
            let userRegistration  = self.storyboard?.instantiateViewController(withIdentifier: "StorelistVC") as! StorelistVC
            self.navigationController?.pushViewController(userRegistration, animated: true)
        }
        
        else if arrAdminCategoryList[indexPath.row] == "View Products" {
            let viewproduct  = self.storyboard?.instantiateViewController(withIdentifier: "AllProductVC") as! AllProductVC
            viewproduct.isfrom = "admin"
                self.navigationController?.pushViewController(viewproduct, animated: true)
        }

        else if arrAdminCategoryList[indexPath.row] == "View Orders" {
            let orderlist  = self.storyboard?.instantiateViewController(withIdentifier: "OrderListVC") as! OrderListVC
            orderlist.isfrom = "admin"
            self.navigationController?.pushViewController(orderlist, animated: true)
        }
        
        else if arrAdminCategoryList[indexPath.row] == "Logout" {
            
            showAlertLogout(self, msg: "Are you sure you want to logout?") { alert in
                Constants.kSharedAppDelegate?.resetDefaults()
                Constants.kSharedAppDelegate?.StartsScreen()
            }
        }
    }
}


