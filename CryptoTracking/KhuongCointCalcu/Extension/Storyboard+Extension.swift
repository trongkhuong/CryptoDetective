//
//  Storyboard+Extension.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/4/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import UIKit
extension UIStoryboard {

    convenience init(storyboard: StoryboardList, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }

    public class func storyboard(_ storyboard: StoryboardList, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }

    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }

        return viewController
    }
}

extension UIViewController: StoryboardIdentifiable {}

// MARK: identifiable

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
