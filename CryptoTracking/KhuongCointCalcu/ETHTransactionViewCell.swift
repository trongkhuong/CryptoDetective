//
//  WalletAddressCell.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/4/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit
import FoldingCell

class ETHTransactionViewCell: FoldingCell {

    //ForegroundView
    @IBOutlet weak var leftView:UIView!
    @IBOutlet weak var serialLbl:UILabel!
    @IBOutlet weak var fromAddressLbl:UILabel!
    @IBOutlet weak var toAddressLbl:UILabel!
    @IBOutlet weak var valueLbl:UILabel!
    @IBOutlet weak var txFeeLbl:UILabel!
    @IBOutlet weak var txDate:UILabel!
    @IBOutlet weak var txTime:UILabel!
    //ContainerView
    @IBOutlet weak var topBarView:UIView!
    @IBOutlet weak var con_backgroundImg:UIImageView! // ratio 2:1
    @IBOutlet weak var con_serialLbl:UILabel!
    @IBOutlet weak var statusLbl:UILabel!
    @IBOutlet weak var con_txTime:UILabel!
    @IBOutlet weak var txHashLbl:UILabel!
    @IBOutlet weak var imgLogo:UIImageView!
    @IBOutlet weak var con_fromAddressLbl:CopyableLabel! //
    @IBOutlet weak var con_toAddressLbl:UILabel!
    @IBOutlet weak var con_valueLbl:UILabel!
    @IBOutlet weak var con_txFeeLbl:UILabel!
    @IBOutlet weak var con_gasUsed:UILabel!
    @IBOutlet weak var con_gasPrice:UILabel!
    @IBOutlet weak var closeBtn:UIButton!
    @IBOutlet weak var blockHeight:UILabel!

    var closeAction:((_ indexPath:IndexPath) -> ())?
    var indexPath:IndexPath?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    func setData(data:ETHTransactionRepresentable?,index indexPath:IndexPath) {
        self.indexPath = indexPath
        guard let txInfo = data else { return }
        //set data for ForegroundView
        self.leftView.backgroundColor = txInfo.txBgStatusColor
        self.serialLbl.text = "\(indexPath.row + 1)"
        self.fromAddressLbl.text = txInfo.fromAddress
        self.toAddressLbl.text = txInfo.toAddress
        self.valueLbl.text = txInfo.ethValue
        self.valueLbl.textColor = txInfo.txStatusColor
        self.txFeeLbl.text = txInfo.txFee
        self.txDate.text = txInfo.onlyDate
        self.txTime.text = txInfo.onlyTime

        //set data from ContainerView
       // self.con_backgroundImg.sd_setImage(with: txInfo.imgBgUrl, completed: nil)
        self.topBarView.backgroundColor = txInfo.txBgStatusColor
        self.con_serialLbl.text = "\(indexPath.row + 1)"
        self.statusLbl.text = txInfo.txStatusDisplay
        self.con_txTime.text = txInfo.fullTime
        self.txHashLbl.text = txInfo.txHash
        self.imgLogo.image = UIImage(named: "img_ETH") //sd_setImage(with: txInfo.imgLogoUrl, completed: nil)
        self.con_fromAddressLbl.text = txInfo.fromAddress
        self.con_toAddressLbl.text = txInfo.toAddress
        self.con_valueLbl.text = txInfo.ethValueWithMarketPrice
        self.con_valueLbl.textColor = txInfo.txStatusColor
        self.con_txFeeLbl.text = txInfo.txFee
        self.con_gasUsed.text = txInfo.txGasUsed
        self.con_gasPrice.text = txInfo.txGasPrice
        self.blockHeight.text = "Block Height: " + txInfo.blockHeight
    }
    @IBAction func onClose(_ sender: UIButton) {
        closeAction!(self.indexPath!)
    }
}
