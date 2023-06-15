//
//  CartModel.swift
//  Shop It
//
//  Created by niravkumar patel on 4/24/22.
//

import Foundation

struct AddToCartModel {
    
    let user_id:String
    let order_id:String
    let total:String
    let product_id:String
    let vendor_id:String
    let p_name:String
    let price:String
    let detail:String
    let qty:String
    let category:String
}

struct GetAllCartProductModel {
    
    let cart_id:String
    let user_id:String
    let order_id:String
    let total:String
    let product_id:String
    let vendor_id:String
    let p_name:String
    let price:String
    let detail:String
    let qty:String
    let category:String

}
