//
//  BaseResponse.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/3/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import ObjectMapper
open class BaseResponse: Mappable {
    required public init?(map: Map) {
    }
    public func mapping(map: Map) {}
    public init() {}
}
