//
//  SelectCategoryVC.swift
//  Shop It
//
//  Created by niravkumar patel on 4/21/22.
//

import UIKit

protocol Categoriresdelegate: AnyObject {
    func selectedCategories(category:String)
}

class SelectCategoryVC: UIViewController {

    @IBOutlet weak var tbCategory: UITableView!
    
    weak var delegate:Categoriresdelegate!
    let arrCategory = ["Mobile","Clothes","Laptop","Watch","Headphone","Beauty","Books","Drinks","Bears"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: IBAction
    @IBAction func btnDismissview(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

// MARK: Tableview method

extension SelectCategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        
        cell.lblCaegoriesName.text = arrCategory[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(arrCategory[indexPath.row])
        delegate.selectedCategories(category: arrCategory[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

