//
//  DatabaseManager.swift
//  Shop It
//
//  Created by niravkumar patel on 3/3/22.
//  Copyright © 2022 niravkumar patel. All rights reserved.
//

import Foundation
var shareInstance = DatabaseManager()
class DatabaseManager :NSObject {
    
    var database:FMDatabase? = nil
    
    class func getInstance()-> DatabaseManager{
        
        if shareInstance.database == nil {
            
            shareInstance.database = FMDatabase(path: Util.getPath("Shopitdb.db"))
        }
        
        return shareInstance
    }
    
   //MARK: ---- Functions -----
    
    func saveData(_ ModalInfo:AdduserDetailModal) -> Bool {

        shareInstance.database?.open()

        let isSave = shareInstance.database?.executeUpdate("INSERT INTO User (fname,lname,email,phone,dob,country,state,city,address,password,sex,status,description) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)", withArgumentsIn: [ModalInfo.fname,ModalInfo.lname,ModalInfo.email,ModalInfo.phone,ModalInfo.dob,ModalInfo.country,ModalInfo.state,ModalInfo.city,ModalInfo.address,ModalInfo.password,ModalInfo.sex,ModalInfo.status,ModalInfo.discription])

        shareInstance.database?.close()

        return isSave!
    }
    
    func getAllUsers(status:String) -> [GetuserDetailModal]
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM User WHERE status = ?", withArgumentsIn: [status])
        
        var iteminfo:[GetuserDetailModal] = []
        
        if (resultSet != nil)
        {
            
            while resultSet.next()
            {
                let items: GetuserDetailModal = GetuserDetailModal(id: resultSet.string(forColumn: "id")!,lname: resultSet.string(forColumn: "lname")!, fname: resultSet.string(forColumn: "fname")!, email: resultSet.string(forColumn: "email")!, phone: resultSet.string(forColumn: "phone")!, dob: resultSet.string(forColumn: "dob")!, country: resultSet.string(forColumn: "country")!, state: resultSet.string(forColumn: "state")!, city: resultSet.string(forColumn: "city")!, address: resultSet.string(forColumn: "address")!, password: resultSet.string(forColumn: "password")!, sex: resultSet.string(forColumn: "sex")!, status: resultSet.string(forColumn: "status")!, discription: resultSet.string(forColumn: "description")!)
                
                iteminfo.append(items)
            }
        }
        
        shareInstance.database?.close()
        
        return iteminfo
    }
    
    func getUserDetail(email:String) -> GetuserDetailModal
    {
        shareInstance.database?.open()
        
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM User WHERE email = ?", withArgumentsIn: [email])
        
        var iteminfo:GetuserDetailModal?
        
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetuserDetailModal = GetuserDetailModal(id: resultSet.string(forColumn: "id")!,lname: resultSet.string(forColumn: "lname")!, fname: resultSet.string(forColumn: "fname")!, email: resultSet.string(forColumn: "email")!, phone: resultSet.string(forColumn: "phone")!, dob: resultSet.string(forColumn: "dob")!, country: resultSet.string(forColumn: "country")!, state: resultSet.string(forColumn: "state")!, city: resultSet.string(forColumn: "city")!, address: resultSet.string(forColumn: "address")!, password: resultSet.string(forColumn: "password")!, sex: resultSet.string(forColumn: "sex")!, status: resultSet.string(forColumn: "status")!, discription: resultSet.string(forColumn: "description")!)
                
                iteminfo = items
            }
        }
        shareInstance.database?.close()
        
        return iteminfo!
    }
    
    func approveUser(id:Int,status:String) -> [GetuserDetailModal]
    {
        shareInstance.database?.open()
                
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("UPDATE User SET status = ? WHERE id = ?", withArgumentsIn: [status,id])
        
        var iteminfo:[GetuserDetailModal] = []
        
        if (resultSet != nil) {
            while resultSet.next() {
                let items: GetuserDetailModal = GetuserDetailModal(id: resultSet.string(forColumn: "id")!, lname: "", fname: "", email: "", phone: "", dob: "", country: "", state: "", city: "", address: "", password: "", sex: "", status: resultSet.string(forColumn: "status")!, discription: "")
                
                iteminfo.append(items)
            }
        }
        shareInstance.database?.close()
        return iteminfo
    }
    
    func updateUserProfile(_ ModalInfo:GetuserDetailModal) -> [GetuserDetailModal]
    {
        shareInstance.database?.open()
                
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("UPDATE User SET fname = ?, lname = ?, email = ?, phone = ?, dob = ?, country = ?,state = ?,city = ?,address = ?,password = ?,sex = ?,status = ?, description = ? WHERE id = ?", withArgumentsIn: [ModalInfo.fname,ModalInfo.lname,ModalInfo.email,ModalInfo.phone,ModalInfo.dob,ModalInfo.country,ModalInfo.state,ModalInfo.city,ModalInfo.address,ModalInfo.password,ModalInfo.sex,ModalInfo.status,ModalInfo.discription, ModalInfo.id])
        
        var iteminfo:[GetuserDetailModal] = []

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetuserDetailModal = GetuserDetailModal(id: resultSet.string(forColumn: "id")!, lname: resultSet.string(forColumn: "lname")!, fname: resultSet.string(forColumn: "fname")!, email: resultSet.string(forColumn: "email")!, phone: resultSet.string(forColumn: "phone")!, dob: resultSet.string(forColumn: "dob")!, country: resultSet.string(forColumn: "country")!, state: resultSet.string(forColumn: "state")!, city: resultSet.string(forColumn: "city")!, address: resultSet.string(forColumn: "address")!, password: resultSet.string(forColumn: "password")!, sex: resultSet.string(forColumn: "sex")!, status: "", discription: "")
                
                iteminfo.append(items)
            }
        }
        
        shareInstance.database?.close()
        return iteminfo
    }
    
    
    //MARK: ----  Vendor Functions-----
    
    func registerVendor(_ ModalInfo:VendorRegistrationModel) -> Bool {

        shareInstance.database?.open()

        let isSave = shareInstance.database?.executeUpdate("INSERT INTO Vendor (storename,username,email,phone,country,state,city,address,password,status,description) VALUES (?,?,?,?,?,?,?,?,?,?,?)", withArgumentsIn: [ModalInfo.storename,ModalInfo.username,ModalInfo.email,ModalInfo.phone,ModalInfo.country,ModalInfo.state,ModalInfo.city,ModalInfo.address,ModalInfo.password,ModalInfo.status,ModalInfo.discription])

        shareInstance.database?.close()

        return isSave!
    }
    
    func updateVendorStatus(id:Int,status:String) -> [GetVendorListModal]
    {
        shareInstance.database?.open()
                
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("UPDATE Vendor SET status = ? WHERE id = ?", withArgumentsIn: [status,id])
        
        var iteminfo:[GetVendorListModal] = []
        
        if (resultSet != nil)
        {
            
            while resultSet.next()
            {
                let items: GetVendorListModal = GetVendorListModal(id: resultSet.string(forColumn: "id")!, storename: "", username: "", email: "", phone: "", country: "", state: "", city: "", address: "", password: "", status: resultSet.string(forColumn: "status")!, discription: "")
                
                iteminfo.append(items)
            }
        }
        
        shareInstance.database?.close()
        
        return iteminfo
    }

    func getAllVendors(status:String) -> [GetVendorListModal]
    {
        shareInstance.database?.open()
        
                
        var resultSet:FMResultSet!
        
        if status == "" {
            resultSet = shareInstance.database?.executeQuery("SELECT * FROM Vendor", withArgumentsIn: [])
        } else {
            resultSet = shareInstance.database?.executeQuery("SELECT * FROM Vendor WHERE status = ?", withArgumentsIn: [status])
        }
        
        var iteminfo:[GetVendorListModal] = []
        
        if (resultSet != nil)
        {
            
            while resultSet.next()
            {
                let items: GetVendorListModal = GetVendorListModal(id: resultSet.string(forColumn: "id")!,storename: resultSet.string(forColumn: "storename")!, username: resultSet.string(forColumn: "username")!, email: resultSet.string(forColumn: "email")!, phone: resultSet.string(forColumn: "phone")!, country: resultSet.string(forColumn: "country")!, state: resultSet.string(forColumn: "state")!, city: resultSet.string(forColumn: "city")!, address: resultSet.string(forColumn: "address")!, password: resultSet.string(forColumn: "password")!, status: resultSet.string(forColumn: "status")!, discription: resultSet.string(forColumn: "description")!)
                
                iteminfo.append(items)
            }
        }
        
        shareInstance.database?.close()
        
        return iteminfo
    }
    
    func getVendorDetail(email:String) -> GetVendorListModal
    {
        shareInstance.database?.open()
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM Vendor WHERE email = ?", withArgumentsIn: [email])
        
        var iteminfo:GetVendorListModal?
        
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetVendorListModal = GetVendorListModal(id: resultSet.string(forColumn: "id")!,storename: resultSet.string(forColumn: "storename")!, username: resultSet.string(forColumn: "username")!, email: resultSet.string(forColumn: "email")!, phone: resultSet.string(forColumn: "phone")!, country: resultSet.string(forColumn: "country")!, state: resultSet.string(forColumn: "state")!, city: resultSet.string(forColumn: "city")!, address: resultSet.string(forColumn: "address")!, password: resultSet.string(forColumn: "password")!, status: resultSet.string(forColumn: "status")!, discription: resultSet.string(forColumn: "description")!)
                
                iteminfo = items
            }
        }
        shareInstance.database?.close()
        
       return iteminfo!
    }
    
    func updateVendorProfile(_ ModalInfo:GetVendorListModal) -> [GetVendorListModal]
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("UPDATE Vendor SET storename = ?, username = ?, email = ?, phone = ?, country = ?,state = ?,city = ?,address = ?,password = ?,status = ?, description = ? WHERE id = ?", withArgumentsIn: [ModalInfo.storename,ModalInfo.username,ModalInfo.email,ModalInfo.phone,ModalInfo.country,ModalInfo.state,ModalInfo.city,ModalInfo.address,ModalInfo.password,ModalInfo.status,ModalInfo.discription, ModalInfo.id])
        
        var iteminfo:[GetVendorListModal] = []

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetVendorListModal = GetVendorListModal(id: resultSet.string(forColumn: "id")!,storename: resultSet.string(forColumn: "storename")!, username: resultSet.string(forColumn: "username")!, email: resultSet.string(forColumn: "email")!, phone: resultSet.string(forColumn: "phone")!, country: resultSet.string(forColumn: "country")!, state: resultSet.string(forColumn: "state")!, city: resultSet.string(forColumn: "city")!, address: resultSet.string(forColumn: "address")!, password: resultSet.string(forColumn: "password")!, status: "", discription: "")
                
                iteminfo.append(items)
            }
        }
        
        shareInstance.database?.close()
        return iteminfo
    }
    
    func deleteVendor(_ id:String) -> [GetVendorListModal]
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("DELETE FROM Vendor WHERE vendor_id = ?", withArgumentsIn: [id])
        
        
        var iteminfo:[GetVendorListModal] = []

        if (resultSet != nil)
        {
            
            while resultSet.next()
            {
                let items: GetVendorListModal = GetVendorListModal(id: resultSet.string(forColumn: "id")!,storename: resultSet.string(forColumn: "storename")!, username: resultSet.string(forColumn: "username")!, email: resultSet.string(forColumn: "email")!, phone: resultSet.string(forColumn: "phone")!, country: resultSet.string(forColumn: "country")!, state: resultSet.string(forColumn: "state")!, city: resultSet.string(forColumn: "city")!, address: resultSet.string(forColumn: "address")!, password: resultSet.string(forColumn: "password")!, status: resultSet.string(forColumn: "status")!, discription: resultSet.string(forColumn: "description")!)
                
                iteminfo.append(items)
            }
        }
        
        shareInstance.database?.close()
        
        return iteminfo
    }
    
    //MARK: ----  Product Functions-----

    func addProduct(_ ModalInfo:AddProductModel) -> Bool {

        shareInstance.database?.open()

        let isSave = shareInstance.database?.executeUpdate("INSERT INTO Product (vendor_id,p_name,price,detail,qty,category) VALUES (?,?,?,?,?,?)", withArgumentsIn: [ModalInfo.vendor_id,ModalInfo.p_name,ModalInfo.price,ModalInfo.detail,ModalInfo.qty,ModalInfo.category])

        shareInstance.database?.close()

        return isSave!
    }
    
    func getAllProduct(vendorid:String) -> [GetAllProductModel] {

        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM Product WHERE vendor_id = ?", withArgumentsIn: [vendorid])
        
        var iteminfo:[GetAllProductModel] = []
        
        if (resultSet != nil)
        {
            
            while resultSet.next()
            {
                let items: GetAllProductModel = GetAllProductModel(product_id: resultSet.string(forColumn: "product_id")!, vendor_id: resultSet.string(forColumn: "vendor_id")!, p_name: resultSet.string(forColumn: "p_name")!, price: resultSet.string(forColumn: "price")!, detail: resultSet.string(forColumn: "detail")!, qty: resultSet.string(forColumn: "qty")!, category: resultSet.string(forColumn: "category")!)
                iteminfo.append(items)
            }
        }

        shareInstance.database?.close()

        return iteminfo
    }
    
    func getProduct() -> [GetAllProductModel] {

        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM Product", withArgumentsIn: [])
        
        var iteminfo:[GetAllProductModel] = []
        
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllProductModel = GetAllProductModel(product_id: resultSet.string(forColumn: "product_id")!, vendor_id: resultSet.string(forColumn: "vendor_id")!, p_name: resultSet.string(forColumn: "p_name")!, price: resultSet.string(forColumn: "price")!, detail: resultSet.string(forColumn: "detail")!, qty: resultSet.string(forColumn: "qty")!, category: resultSet.string(forColumn: "category")!)
                iteminfo.append(items)
            }
        }

        shareInstance.database?.close()

        return iteminfo
    }
    
    func deleteProduct(_ id:Int) -> [GetAllProductModel]
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("DELETE FROM Product WHERE product_id = ?", withArgumentsIn: [id])
        
        
        var iteminfo:[GetAllProductModel] = []

        if (resultSet != nil)
        {
            
            while resultSet.next()
            {
                let items: GetAllProductModel = GetAllProductModel(product_id: resultSet.string(forColumn: "product_id")!, vendor_id: resultSet.string(forColumn: "vendor_id")!, p_name: resultSet.string(forColumn: "p_name")!, price: resultSet.string(forColumn: "price")!, detail: resultSet.string(forColumn: "detail")!, qty: resultSet.string(forColumn: "qty")!, category: resultSet.string(forColumn: "category")!)
                iteminfo.append(items)
            }
        }
        
        shareInstance.database?.close()
        
        return iteminfo
    }

    func getProductDetail(id:String) -> GetAllProductModel
    {
        shareInstance.database?.open()
                
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM Product WHERE product_id = ?", withArgumentsIn: [id])
        
        var iteminfo:GetAllProductModel?
        
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllProductModel = GetAllProductModel(product_id: resultSet.string(forColumn: "product_id")!, vendor_id: resultSet.string(forColumn: "vendor_id")!, p_name: resultSet.string(forColumn: "p_name")!, price: resultSet.string(forColumn: "price")!, detail: resultSet.string(forColumn: "detail")!, qty: resultSet.string(forColumn: "qty")!, category: resultSet.string(forColumn: "category")!)
                
                iteminfo = items
            }
        }
        shareInstance.database?.close()
        
        return iteminfo!
    }
    
    func updateProductDetail(_ ModalInfo:GetAllProductModel) -> [GetAllProductModel]
    {
        shareInstance.database?.open()
                
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("UPDATE Product SET p_name = ?, price = ?, detail = ?, qty = ?, category = ? WHERE product_id = ?", withArgumentsIn: [ModalInfo.p_name,ModalInfo.price,ModalInfo.detail,ModalInfo.qty,ModalInfo.category, ModalInfo.product_id])
        
        var iteminfo:[GetAllProductModel] = []

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllProductModel = GetAllProductModel(product_id: resultSet.string(forColumn: "product_id")!, vendor_id: resultSet.string(forColumn: "vendor_id")!, p_name: resultSet.string(forColumn: "p_name")!, price: resultSet.string(forColumn: "price")!, detail: resultSet.string(forColumn: "detail")!, qty: resultSet.string(forColumn: "qty")!, category: resultSet.string(forColumn: "category")!)
                
                iteminfo.append(items)
            }
        }
        shareInstance.database?.close()
        return iteminfo
    }
    
    func likeProduct(userid:String,productid:String) -> Bool {

        shareInstance.database?.open()

        let isSave = shareInstance.database?.executeUpdate("INSERT INTO Favourite (user_id,product_id) VALUES (?,?)", withArgumentsIn: [userid,productid])

        shareInstance.database?.close()

        return isSave!
    }
    
    func getFavouriteProduct(userid:String) -> [GetAllProductModel] {

        shareInstance.database?.open()
        
//        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT p.* FROM Favourite f INNER JOIN Product p ON p.product_id ON f.product_id WHERE f.user_id = ?", withArgumentsIn: [userid])
    
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT a.* FROM Product a JOIN Favourite b ON a.product_id = b.product_id WHERE b.user_id = ?", withArgumentsIn: [userid])
        
        var iteminfo:[GetAllProductModel] = []
        
        if (resultSet != nil)
        {
            
            while resultSet.next()
            {
                let items: GetAllProductModel = GetAllProductModel(product_id: resultSet.string(forColumn: "product_id")!, vendor_id: resultSet.string(forColumn: "vendor_id")!, p_name: resultSet.string(forColumn: "p_name")!, price: resultSet.string(forColumn: "price")!, detail: resultSet.string(forColumn: "detail")!, qty: resultSet.string(forColumn: "qty")!, category: resultSet.string(forColumn: "category")!)
                iteminfo.append(items)
            }
        }

        shareInstance.database?.close()

        return iteminfo
    }
    
    func deleteFavouriteProduct(user_id:String, productid:String) -> [FavouriteProductModel]
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("DELETE FROM Favourite WHERE product_id = ? AND user_id = ?", withArgumentsIn: [productid,user_id])
        
        
        var iteminfo:[FavouriteProductModel] = []

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: FavouriteProductModel = FavouriteProductModel(favourte_id: resultSet.string(forColumn: "favourite_id")!, product_id: resultSet.string(forColumn: "product_id")!, user_id: resultSet.string(forColumn: "user_id")!)
                iteminfo.append(items)
            }
        }
        
        shareInstance.database?.close()
        
        return iteminfo
    }
    
    func getproductqty(product_id:String) -> String
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT qty FROM Product WHERE product_id = ?", withArgumentsIn: [product_id])
        
        var quentity = ""

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items = "\(resultSet.string(forColumn: "qty")!)"
                
                quentity = items
            }
        }
        
        shareInstance.database?.close()
        
        return quentity
    }
    
    //MARK: ----  Cart Functions-----

    func addToCartProduct(_ ModalInfo:AddToCartModel) -> Bool {

        shareInstance.database?.open()

        let isSave = shareInstance.database?.executeUpdate("INSERT INTO Cart (user_id,order_id,total,product_id,vendor_id,p_name,price,detail,qty,category) VALUES (?,?,?,?,?,?,?,?,?,?)", withArgumentsIn: [ModalInfo.user_id,ModalInfo.order_id,ModalInfo.total,ModalInfo.product_id, ModalInfo.vendor_id,ModalInfo.p_name,ModalInfo.price,ModalInfo.detail,ModalInfo.qty,ModalInfo.category])

        shareInstance.database?.close()

        return isSave!
    }

    func getAllCartList(user_id:String) -> [GetAllCartProductModel]
    {
        shareInstance.database?.open()
                
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM Cart WHERE order_id = 0 AND user_id = ?", withArgumentsIn: [user_id])
        
        var iteminfo:[GetAllCartProductModel] = []
        
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllCartProductModel = GetAllCartProductModel(cart_id: resultSet.string(forColumn: "cart_id")!, user_id: resultSet.string(forColumn: "user_id")!, order_id: resultSet.string(forColumn: "order_id")!, total: resultSet.string(forColumn: "total")!,product_id: resultSet.string(forColumn: "product_id")!, vendor_id: resultSet.string(forColumn: "vendor_id")!, p_name: resultSet.string(forColumn: "p_name")!, price: resultSet.string(forColumn: "price")!, detail: resultSet.string(forColumn: "detail")!, qty: resultSet.string(forColumn: "qty")!, category: resultSet.string(forColumn: "category")!)
                
                iteminfo.append(items)
            }
        }
        shareInstance.database?.close()
        return iteminfo
    }
    
    func updateCartQty(product_id:String,qty:Int,total:Double) -> [GetAllCartProductModel]
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("UPDATE Cart SET qty = ?, total = ? WHERE product_id = ?", withArgumentsIn: [qty,total,product_id])
        
        var iteminfo:[GetAllCartProductModel] = []

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllCartProductModel = GetAllCartProductModel(cart_id: "", user_id: "", order_id: "", total: resultSet.string(forColumn: "total")!,product_id: resultSet.string(forColumn: "product_id")!, vendor_id: "", p_name: "", price: "", detail: "", qty: resultSet.string(forColumn: "qty")!, category: "")
                
                iteminfo.append(items)
            }
        }
        
        print(iteminfo)
        shareInstance.database?.close()
        
        return iteminfo
    }
    
    func deleteCartProduct(cart_id:String) -> [GetAllCartProductModel]
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("DELETE FROM Cart WHERE cart_id = ?", withArgumentsIn: [cart_id])
        
        var iteminfo:[GetAllCartProductModel] = []

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllCartProductModel = GetAllCartProductModel(cart_id: resultSet.string(forColumn: "cart_id")!, user_id: resultSet.string(forColumn: "user_id")!, order_id: resultSet.string(forColumn: "order_id")!, total: resultSet.string(forColumn: "total")!,product_id: resultSet.string(forColumn: "product_id")!, vendor_id: resultSet.string(forColumn: "vendor_id")!, p_name: resultSet.string(forColumn: "p_name")!, price: resultSet.string(forColumn: "price")!, detail: resultSet.string(forColumn: "detail")!, qty: resultSet.string(forColumn: "qty")!, category: resultSet.string(forColumn: "category")!)
                
                iteminfo.append(items)
            }
        }
        
        print(iteminfo)
        shareInstance.database?.close()
        
        return iteminfo
    }
    
    func gettotalAmountofCart(user_id:String,order_id:String) -> String {
        
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT SUM(total) AS total FROM Cart WHERE user_id = ? AND order_id = ?", withArgumentsIn: [user_id,order_id])
        
        var totalamount = ""

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items = "\(resultSet.string(forColumn: "total")!)"
                
                totalamount = items
            }
        }
        
        shareInstance.database?.close()
        
        return totalamount
    }
    
    //MARK: ----  Order Functions-----

    func placeOrderProduct(_ ModalInfo:AddOrderModel) -> Bool {

        shareInstance.database?.open()

        let isSave = shareInstance.database?.executeUpdate("INSERT INTO tblOrder (user_id,total,date) VALUES (?,?,?)", withArgumentsIn: [ModalInfo.user_id,ModalInfo.total,ModalInfo.date])

        shareInstance.database?.close()

        return isSave!
    }
    
    func getAllOrderList() -> [GetAllOrderModel]
    {
        shareInstance.database?.open()
                
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM tblOrder ORDER BY order_id DESC", withArgumentsIn: [])
        
        var iteminfo:[GetAllOrderModel] = []
        
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllOrderModel = GetAllOrderModel(order_id: resultSet.string(forColumn: "total")!, user_id: resultSet.string(forColumn: "user_id")!, total: resultSet.string(forColumn: "total")!, date: resultSet.string(forColumn: "date")!)
                
                iteminfo.append(items)
            }
        }
        shareInstance.database?.close()
        return iteminfo
    }
    
    func getAllOrderByUserIDList(user_id:String) -> [GetAllOrderModel]
    {
        shareInstance.database?.open()
                
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("SELECT * FROM tblOrder WHERE user_id = ?  ORDER BY order_id DESC", withArgumentsIn: [user_id])
        
        var iteminfo:[GetAllOrderModel] = []
        
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllOrderModel = GetAllOrderModel(order_id: resultSet.string(forColumn: "total")!, user_id: resultSet.string(forColumn: "user_id")!, total: resultSet.string(forColumn: "total")!, date: resultSet.string(forColumn: "date")!)
                
                iteminfo.append(items)
            }
        }
        shareInstance.database?.close()
        return iteminfo
    }
    
    func updateCartAfterOrder(order_id:String,user_id:String) -> [GetAllCartProductModel]
    {
        shareInstance.database?.open()
        
        let resultSet:FMResultSet! = shareInstance.database?.executeQuery("UPDATE Cart SET order_id = ? WHERE user_id = ?", withArgumentsIn: [order_id,user_id])
        
        var iteminfo:[GetAllCartProductModel] = []

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let items: GetAllCartProductModel = GetAllCartProductModel(cart_id: "", user_id: "", order_id: "\(resultSet.string(forColumn: "order_id")!)", total: "",product_id: "", vendor_id: "", p_name: "", price: "", detail: "", qty: "", category: "")

                iteminfo.append(items)
            }
        }
        
        print(iteminfo)
        shareInstance.database?.close()
        
        return iteminfo
    }
}
