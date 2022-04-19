//
//  LoadingView.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/30/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import UIKit
//import NVActivityIndicatorView
class LoadingView: UIView {
//    static let shared:LoadingView = LoadingView()
//    private init ()
//    
    /*
    func initLoadingView(containtView:UIView) {
        
        
        var blurView = UIVisualEffectView.init()
        if #available(iOS 10.0, *) {
            blurView = UIVisualEffectView(effect:  UIBlurEffect(style: .dark))
        } else {
            blurView = UIVisualEffectView(effect:  UIBlurEffect(style: .light))
            // Fallback on earlier versions
        }
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 15
        containtView.addSubview(blurView)
        
        if #available(iOS 9.0, *) {
            blurView.centerXAnchor.constraint(equalTo: containtView.centerXAnchor).isActive = true
            blurView.centerYAnchor.constraint(equalTo: containtView.centerYAnchor).isActive = true
            blurView.widthAnchor.constraint(equalToConstant: 160).isActive = true
            blurView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        } else {
            
        }
        
        let loadingView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: .ballRotateChase, color: .white, padding: 0)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(loadingView)
        if #available(iOS 9.0, *) {
            loadingView.topAnchor.constraint(equalTo: blurView.topAnchor, constant:16).isActive = true
            loadingView.centerXAnchor.constraint(equalTo: blurView.centerXAnchor).isActive = true
            loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            loadingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
        } else {
            // Fallback on earlier versions
        }
        loadingView.startAnimating()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "Loading..."
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.sizeToFit()
        blurView.contentView.addSubview(label)
        if #available(iOS 9.0, *) {
            label.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant:-8).isActive = true
            label.centerXAnchor.constraint(equalTo: blurView.centerXAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: blurView.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: blurView.trailingAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        //startAnimating(size, message: "Loading...", messageFont: nil, type: .ballRotateChase, color: .red, padding: 0, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: .white, fadeInAnimation: nil)
    }
    */
}
