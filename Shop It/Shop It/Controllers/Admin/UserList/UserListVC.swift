//
//  UserListVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/5/22.
//

import UIKit

class UserListVC: UIViewController {

    @IBOutlet weak var tableviewUserList: UITableView!
    
    var arrUsers:[GetuserDetailModal] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        arrUsers = DatabaseManager.getInstance().getAllUsers(status: "0")
        tableviewUserList.reloadData()
    }
}

// MARK: TableView Methods

extension UserListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrUsers.count == 0 {
            self.tableviewUserList.setEmptyMessage(StringConstants.NODATAAVAILABLE)
        } else {
            self.tableviewUserList.restore()
        }
        return arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.identifire, for: indexPath) as? UserListCell else { return UITableViewCell() }
        cell.userName.text = arrUsers[indexPath.row].fname
        cell.userEmail.text = arrUsers[indexPath.row].email
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let approveAction = UIContextualAction(style: .normal, title: "Approve") { (action, view, completion) in
          let id:Int = Int(self.arrUsers[indexPath.row].id) ?? 0
          _ = DatabaseManager.getInstance().approveUser(id: id, status: "1")
          self.arrUsers.removeAll()
          self.arrUsers = DatabaseManager.getInstance().getAllUsers(status: "0")
          self.tableviewUserList.reloadData()
          print("Approve")
          completion(true)
      }
        approveAction.backgroundColor = UIColor.green
        let disapproveAction = UIContextualAction(style: .normal, title: "Disapprove") { (action, view, completion) in
          print("Disapprove")
          completion(true)
        }

        disapproveAction.backgroundColor = UIColor.red

      return UISwipeActionsConfiguration(actions: [approveAction,disapproveAction])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 }
