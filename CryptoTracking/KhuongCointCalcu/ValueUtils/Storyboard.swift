//
//  Storyboard.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/17/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
import UIKit

open class Storyboard {
    
    static let shared:Storyboard = Storyboard()
    private init() {}
    lazy var main : UIStoryboard = { // load lazily from UIStoryboard
        () -> UIStoryboard in
        return UIStoryboard(storyboard: StoryboardList.Main)
    }()
}
