//
//  HomeCollectionViewCell.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 6/29/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit
import SDWebImage
class HomeCollectionViewCell: BasePageCollectionCell {

    /// Front
    @IBOutlet weak var imgBg:UIImageView!
    @IBOutlet weak var imgLogo:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var detailLbl:UILabel!
    @IBOutlet weak var priceLbl:UILabel!
    @IBOutlet weak var change24hLbl:UILabel!
    @IBOutlet weak var widContraint: NSLayoutConstraint!

    /// Back
    @IBOutlet weak var low24hLbl:UILabel!
    @IBOutlet weak var high24hLbl:UILabel!
    @IBOutlet weak var marketCapLbl:UILabel!
    @IBOutlet weak var volumn24hLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.layer.shadowRadius = 2
        titleLbl.layer.shadowOffset = CGSize(width: 0, height: 3)
        titleLbl.layer.shadowOpacity = 0.2
    }

    func setData(data:MarketDataRepresentable?) {
        guard let marketData = data else {
            return
        }
        self.titleLbl.text = marketData.title
        self.detailLbl.text = marketData.detail
        self.priceLbl.text = marketData.marketPrice
        self.change24hLbl.text = marketData.marketPrice24h
        self.change24hLbl.textColor = marketData.price24hColor
        self.imgBg.image = UIImage.init(named: marketData.imgBgUrl ?? "")
        self.imgLogo.image = UIImage.init(named: marketData.imgLogoUrl)
        
        self.low24hLbl.text = marketData.low24hPrice
        self.high24hLbl.text = marketData.high24hPrice
        self.marketCapLbl.text = marketData.marketCap
        self.volumn24hLbl.text = marketData.volumn24h
    }
    func scaleSmalLogo(isSmall:Bool) {
        if isSmall {
            widContraint.constant = 100
        } else {
            widContraint.constant = 200
        }
    }
}
