//
//  Crypto.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/3/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
public struct Crypto : Codable {
    var id : String?
    var name : String?
    var symbol : String?
    var decimal : String?
    var type : String?
    var dictionary : [String: Any] {
        return ["id": id as Any,
                "name" : name as Any,
                "symbol" : symbol as Any,
                "decimal" : decimal as Any,
                "type" : type as Any
        ]
    }
}
extension Crypto {
    init?(dict:[String:Any]) {
        guard let id = dict["id"] as? String,
            let name = dict["name"]  as? String,
            let symbol = dict["symbol"] as? String,
            let decimal = dict["decimal"] as? String,
            let type = dict["type"] as? String
            else { return nil }
        self.init(id: id, name: name, symbol: symbol, decimal: decimal, type: type)
    }
}

class ServiceTesting {

    static func readPlist() {
        var params:NSMutableDictionary = NSMutableDictionary.init()
        let _ = readPlist("params", assignNewData: &params, overwrite: false)
        let test = convertJSonToDict(params["list"] as! String)
        let list:NSArray =   test["data"] as! NSArray
        guard let data = try? JSONSerialization.data(withJSONObject: list, options:[]) else { return }
        let decoder = JSONDecoder()
        let result = try? decoder.decode([Crypto].self, from: data)
        for item:Crypto in result! {
            //            print(item.name!)
            //            print(item.symbol!)
            //            print("//--------------------------------------")
            print("lazy var _\(item.name!):(name:String, symbol:String) = (name: \"\(item.name!)\", symbol: \"\(item.symbol!)\")")
        }
    }
    static func convertJSonToDict(_ text: String) -> [String:AnyObject] {

        //let jsonDic = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: &error) as Dictionary<String, AnyObject>;

        if let data = text.data(using: String.Encoding.utf8) {
            do {
                //return try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
                //return try
                if let result: [String:AnyObject] = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .allowFragments]) as? [String:AnyObject] {
                    return result
                }
                else {
                    return [:]
                }
            }
            catch let error as NSError {
                return [:]
            }
        }
        return [:]
    }

    static func readPlist (_ fileName: String, assignNewData: inout NSMutableDictionary, overwrite: Bool) -> Bool {
        let paths               = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory  = paths[0] as! String
        let path                = documentsDirectory.stringByAppendingPathComponent(fileName + ".plist")
        let fileManager         = FileManager.default

        if(!fileManager.fileExists(atPath: path)) {
            if let bundlePath   = Bundle.main.path(forResource: fileName, ofType: "plist") {
                do {
                    try FileManager.default.copyItem(atPath: bundlePath, toPath: path)

                }
                catch let error as NSError {

                }
            }
            else {

            }
        }
        else {
            if (overwrite) {
                do {
                    try FileManager.default.removeItem(atPath: path)

                    readPlist(fileName, assignNewData: &assignNewData, overwrite: overwrite)
                }
                catch let error as NSError {

                }
            }
        }

        assignNewData = NSMutableDictionary(contentsOfFile: path)!

        return true
    }
}
extension String {
    func stringByAppendingPathComponent(_ pathComponent: String) -> String {
        return (self as NSString).appendingPathComponent(pathComponent)
    }

}

