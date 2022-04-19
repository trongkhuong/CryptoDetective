//
//  BaseModel.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/22/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
import ObjectMapper
open class BaseModel: Mappable {
    required public init?(map: Map) {}
    init() {}
    public func mapping(map: Map) {}
}
