//
//  OrderModel.swift
//  Shop It
//
//  Created by niravkumar patel on 4/24/22.
//

import Foundation

struct AddOrderModel {
    
    let user_id:String
    let total:String
    let date:String

}

struct GetAllOrderModel {
    
    let order_id:String
    let user_id:String
    let total:String
    let date:String    
}
