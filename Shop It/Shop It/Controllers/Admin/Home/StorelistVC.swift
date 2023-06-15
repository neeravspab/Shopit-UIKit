//
//  StorelistVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/21/22.
//

import UIKit

class StorelistVC: UIViewController {

    @IBOutlet weak var tableviewVendorList: UITableView!

    var arrVendorList:[GetVendorListModal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrVendorList = DatabaseManager.getInstance().getAllVendors(status: "")
        tableviewVendorList.reloadData()
    }
    
    @objc func btnDisapproveCLick(_ sender: UIButton) {
        print("Disapprove")
        let id:Int = Int(self.arrVendorList[sender.tag].id) ?? 0
        _ = DatabaseManager.getInstance().updateVendorStatus(id: id, status: "2")
        self.arrVendorList.removeAll()
        self.arrVendorList = DatabaseManager.getInstance().getAllVendors(status: "")
        self.tableviewVendorList.reloadData()
    }
}

extension StorelistVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrVendorList.count == 0 {
            self.tableviewVendorList.setEmptyMessage(StringConstants.NODATAAVAILABLE)
        } else {
            self.tableviewVendorList.restore()
        }
        return arrVendorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoreListTableviewCell.identifire, for: indexPath) as? StoreListTableviewCell else { return UITableViewCell() }
        cell.lblStoreName.text = arrVendorList[indexPath.row].storename
        cell.lblStoreId.text = "Store Id: \(arrVendorList[indexPath.row].id)"
        cell.lblCity.text = arrVendorList[indexPath.row].city
        cell.lblCountry.text = arrVendorList[indexPath.row].country
        cell.btnDisapprove.isHidden = false
        if arrVendorList[indexPath.row].status == "0" {
            cell.lblstatus.text = "Pending"
        }  else if arrVendorList[indexPath.row].status == "1" {
            cell.lblstatus.text = "Approved"
        } else {
            cell.lblstatus.text = "Disapproved"
            cell.btnDisapprove.isHidden = true
        }

        cell.btnDisapprove.tag = indexPath.row
        cell.btnDisapprove.addTarget(self, action: #selector(btnDisapproveCLick(_:)), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let approveAction = UIContextualAction(style: .normal, title: "Approve") { (action, view, completion) in
          let id:Int = Int(self.arrVendorList[indexPath.row].id) ?? 0
          _ = DatabaseManager.getInstance().updateVendorStatus(id: id, status: "1")
          self.arrVendorList.removeAll()
          self.arrVendorList = DatabaseManager.getInstance().getAllVendors(status: "")
          self.tableviewVendorList.reloadData()
          print("Approve")
          completion(true)
      }
        approveAction.backgroundColor = UIColor.green

        let DeleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            let id = self.arrVendorList[indexPath.row].id
            _ = DatabaseManager.getInstance().deleteVendor(id)
            self.arrVendorList.removeAll()
            self.arrVendorList = DatabaseManager.getInstance().getAllVendors(status: "")
            self.tableviewVendorList.reloadData()
            print("Approve")
            completion(true)
        }
        DeleteAction.backgroundColor = UIColor.red

        if arrVendorList[indexPath.row].status == "0" || arrVendorList[indexPath.row].status == "2" {
            return UISwipeActionsConfiguration(actions: [approveAction,DeleteAction])
        } else {
            return UISwipeActionsConfiguration(actions: [DeleteAction])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 }
