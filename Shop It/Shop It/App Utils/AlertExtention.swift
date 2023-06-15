//
//  AlertExtention.swift
//  Shop It
//
//  Created by niravkumar patel on 4/19/22.
//

import Foundation
import UIKit

public func showAlertwithOk(_ controller:UIViewController, msg:String, OK:((UIAlertAction?) -> Void)?)
{
    let alertController = UIAlertController(title: Constants.Appname, message: msg, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: OK)
    alertController.addAction(okAction)
    controller.present(alertController, animated: true, completion: nil)
}

public func showAlertLogout(_ controller:UIViewController, msg:String, Yes:((UIAlertAction?) -> Void)?)
{
    let alertController = UIAlertController(title: Constants.Appname, message: msg, preferredStyle: .alert)
    
    let yesAction = UIAlertAction(title: "Yes", style: .default, handler: Yes)
    let noAction = UIAlertAction(title: "No", style: .cancel)
    alertController.addAction(noAction)
    alertController.addAction(yesAction)
    controller.present(alertController, animated: true, completion: nil)
}

public func showAlert(_ controller:UIViewController, msg:String) -> Void
{
    let alertController = UIAlertController(title: Constants.Appname, message: msg, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(okAction)
    controller.present(alertController, animated: true, completion: nil)
}

public func showAlertwithSettingCancel(_ controller:UIViewController, msg:String, Cancel:((UIAlertAction?) -> Void)?, Setting:((UIAlertAction?) -> Void)?)
{
    let alertController = UIAlertController(title: Constants.Appname, message: msg, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Settings", style: .default, handler: Setting)
    
    let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: Cancel)
    
    alertController.addAction(okAction)
    alertController.addAction(CancelAction)
    controller.present(alertController, animated: true, completion: nil)
}

public func InterNetAlert(_ controller:UIViewController) -> Void
{
    let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(okAction)
    controller.present(alertController, animated: true, completion: nil)
}
