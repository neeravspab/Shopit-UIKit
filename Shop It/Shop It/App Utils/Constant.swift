//
//  Constant.swift
//  Shop It
//
//  Created by niravkumar patel on 3/22/22.
//

import Foundation
import UIKit

struct Constants {
    // Server URL
    static let kUserDefaults                    = UserDefaults.standard
    static let kSharedAppDelegate               = (UIApplication.shared.delegate as? AppDelegate)
    static let kDateToday                       = Date()
    static let Appname                          = "Shop It"

    static var DB_Path : String                 = ""
    static let screenSize: CGRect = UIScreen.main.bounds

}

public class NullCheck
{
    class func checkNullNil(_ string: String) -> Bool {
        let str = string as? NSString
        if str == NSNull() || string.count == 0 || string == nil || (string == "(null)") || (string == "<null>") || "\(String(describing: str))".trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 || (string == "0.000000") {
            return false
        }
        else {
            return true
        }
    }
    
    class func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    class func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

public func dateformate() -> String {
    
    let date : String
    date = "\(Date())"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // This formate is input formated .
    let formateDate = dateFormatter.date(from:date)!
    dateFormatter.dateFormat = "MM-dd-yyyy" // Output Formated
    dateFormatter.string(from: formateDate)
    return dateFormatter.string(from: formateDate)
}
