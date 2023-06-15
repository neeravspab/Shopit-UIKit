//
//  OrderListVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/25/22.
//

import UIKit

class OrderListVC: UIViewController {

    @IBOutlet weak var tableviewOrderList: UITableView!
    
    var isfrom = ""
    var arrOrderList:[GetAllOrderModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Order"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isfrom == "admin" {
            arrOrderList = DatabaseManager.getInstance().getAllOrderList()
            tableviewOrderList.reloadData()
        } else {
            
            let userinfo:GetuserDetailModal = DatabaseManager.getInstance().getUserDetail(email: "\(Constants.kUserDefaults.value(forKey: "email") ?? "")")
            arrOrderList = DatabaseManager.getInstance().getAllOrderByUserIDList(user_id: userinfo.id)
            tableviewOrderList.reloadData()
        }
    }
}

extension OrderListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrOrderList.count == 0 {
            self.tableviewOrderList.setEmptyMessage(StringConstants.NODATAAVAILABLE)
        } else {
            self.tableviewOrderList.restore()
        }
        return arrOrderList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifire, for: indexPath) as? OrderTableViewCell else { return UITableViewCell() }
        cell.lblOrderId.text = "Order No: \(arrOrderList[indexPath.row].order_id)"
        cell.lblDate.text = arrOrderList[indexPath.row].date
        cell.lblPrice.text = "$" + arrOrderList[indexPath.row].total

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
