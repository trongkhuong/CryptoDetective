//
//  UserWalletAddress.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/25/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
public struct UserWalletAddress {
    var nickName:String
    var address: String
    var coinId:  String
    var userId:  String // email
    var dictionary: [String: Any] {
        return ["nickName" : nickName,
                "address": address,
                "coinId": coinId,
                "userId": userId
        ]
    }
}
extension UserWalletAddress {

    init?(dict : [String: Any]) {
        guard let nickName = dict["nickName"] as? String,
            let address = dict["address"]  as? String,
            let coinId = dict["coinId"] as? String,
            let userId = dict["userId"] as? String
            else { return nil }
        self.init(nickName: nickName, address: address, coinId: coinId, userId: userId)
    }
}
