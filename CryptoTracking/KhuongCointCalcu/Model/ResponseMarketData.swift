//
//  ResponseMarketData.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/2/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import ObjectMapper
open class ResponseMarketData: BaseResponse {
    var rawObject:ResponseRawObject? // for calcu
    var displayObject:ResponseObject? // for display

    required public init?(map: Map) {
        super.init(map: map)
    }
    override public func mapping(map: Map) {
        self.rawObject <- map["RAW"]
        self.displayObject <- map["DISPLAY"]
        super.mapping(map: map)

    }


}
