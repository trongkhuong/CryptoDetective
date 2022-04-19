//
//  AddNewWalletVC.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 6/29/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit

class AddNewWalletVC: UIViewController {
    @IBOutlet weak var addNewWalletBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      //  addNewWalletBtn.rotate360Degrees(60 , completionDelegate: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addNewWallet(_ sender: UIButton) {
        self.dismiss(animated: true, completion: self.removeAnimation)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func removeAnimation() {
        addNewWalletBtn.removeAllAnimation()
    }

}
extension UIView {
    func rotate360Degrees(_ duration: CFTimeInterval = 3.0, completionDelegate: CAAnimationDelegate? = nil) {
        let rotateAnimation         = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue   = 0.0
        rotateAnimation.toValue     = CGFloat.pi
        rotateAnimation.duration    = duration
        rotateAnimation.repeatCount = .infinity

        if let delegate: CAAnimationDelegate = completionDelegate {
            rotateAnimation.delegate = delegate
        }

        self.layer.add(rotateAnimation, forKey: nil)
    }
    func removeAllAnimation() {
        self.layer.removeAllAnimations()
    }

}
