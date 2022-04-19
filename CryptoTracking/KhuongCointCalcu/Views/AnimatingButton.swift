//
//  AnimatingButton.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/18/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit

fileprivate final class CustomView: UIView {
    var onLayoutSubviews: () -> Void = {}

    override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
}

class AnimatingButton: UIButton, Rotatable {

    @IBInspectable var normalImageName: String = ""
    @IBInspectable var selectedImageName: String = ""

    @IBInspectable var duration: Double = 1

    let normalView = UIImageView(frame: .zero)
    let selectedView = UIImageView(frame: .zero)
}

// MARK: life cicle

extension AnimatingButton {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        self.configurateImageViews()
    }
}

// MARK: public

extension AnimatingButton {

    func animationSelected(_ selected: Bool) {
        if selected {
            rotateAnimationFrom(normalView, toItem: selectedView, duration: duration)
        } else {
            rotateAnimationFrom(selectedView, toItem: normalView, duration: duration)
        }
    }
}

// MARK: Create

extension AnimatingButton {

    fileprivate func configurateImageViews() {
        configureImageView(normalView, imageName: normalImageName)
        configureImageView(selectedView, imageName: selectedImageName)

        selectedView.alpha = 0
    }

    fileprivate func configureImageView(_ imageView: UIImageView, imageName: String) {
        guard let image = UIImage(named: imageName)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate) else { return }

        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = tintColor

        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 0.6
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        imageView.layer.shadowOpacity = 0.3

        //let x = (customView.bounds.size.width - image.size.width) / 2 + 12
        //let y = (customView.bounds.size.height - image.size.height) / 2
        //imageView.frame = CGRect(origin: CGPoint(x: x, y: y), size: image.size)
        //customView.addSubview(imageView)
        self.setImage(image, for: .normal)
    }
}
