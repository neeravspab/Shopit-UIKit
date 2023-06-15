//
//  Util.swift
//  Shop It
//
//  Created by niravkumar patel on 3/3/22.
//  Copyright © 2022 niravkumar patel. All rights reserved.
//

import Foundation

class Util:NSObject
{
    
    class func getPath(_ filename:String) -> String
    {
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileurl = documentDirectory.appendingPathComponent(filename)
        print("DB Path : \(fileurl.path)")
        Constants.DB_Path = "\(fileurl.path)"
        return fileurl.path
    }
    
    class func copyDatabase(_ filename: String) {
        
        let dbPath = getPath("Shopitdb.db")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath) {
            
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(filename)
            var error:NSError?
            
            do {
                try fileManager.copyItem(atPath: ((file?.path)!), toPath: dbPath)
                
            }catch let error1 as NSError{
                error = error1
            }
            
            if error == nil {
                print("error in db")
            }else {
                print("yehh!!")
            }
        }
    }
}
