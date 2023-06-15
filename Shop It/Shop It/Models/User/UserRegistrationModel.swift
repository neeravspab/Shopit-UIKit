//
//  UserRegistrationModel.swift
//  Shop It
//
//  Created by niravkumar patel on 4/12/22.
//

import Foundation

struct AdduserDetailModal {
    
//    let id:String
    let lname:String
    let fname:String
    let email:String
    let phone:String
    let dob:String
    let country:String
    let state:String
    let city:String
    let address: String
    let password:String
    let sex:String
    let status: String
    let discription: String
}

struct GetuserDetailModal {
    
    let id:String
    let lname:String
    let fname:String
    let email:String
    let phone:String
    let dob:String
    let country:String
    let state:String
    let city:String
    let address: String
    let password:String
    let sex:String
    let status: String
    let discription: String
}

struct FavouriteProductModel {
    
    let favourte_id:String
    let product_id:String
    let user_id:String
}
