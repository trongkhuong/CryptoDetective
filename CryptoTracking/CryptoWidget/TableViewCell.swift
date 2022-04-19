//
//  TableViewCell.swift
//  CryptoWidget
//
//  Created by Tran Khuong on 2/15/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var priceLbl:UILabel!
    @IBOutlet weak var statusLbl:UILabel!
    @IBOutlet weak var statusBtn:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(data:MarketDataRepresentable?) {
        guard let marketData = data else {
            return
        }
        self.nameLbl.text = marketData.widgetTitle
        
        self.priceLbl.layer.topAnimation(duration: 0.5)
        self.priceLbl.text = marketData.marketPrice
        
        self.statusLbl.layer.topAnimation(duration: 0.5)
        self.statusLbl.text = marketData.widgetMarketPrice24h
        self.statusBtn.backgroundColor = marketData.price24hColor

    }

}
extension CALayer {
    
    func bottomAnimation(duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = duration
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        self.add(animation, forKey: CATransitionType.push.rawValue)
    }
    
    func topAnimation(duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = duration
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromBottom
        self.add(animation, forKey: CATransitionType.push.rawValue)
    }
}
