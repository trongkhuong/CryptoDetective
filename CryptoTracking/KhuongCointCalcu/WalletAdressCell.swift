//
//  WalletAdressCell.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/5/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit

class WalletAdressCell: UITableViewCell {


    @IBOutlet weak var ordinalLbl:UILabel!
    @IBOutlet weak var walletAddressLbl:UILabel!
    @IBOutlet weak var balanceAdress:UILabel!
    @IBOutlet weak var tokenListAddress:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
//    func setData(walletData:ETHWalletAddressesViewModel?, indexPath:IndexPath) {
//        guard let wallet = walletData else { return }
//        self.ordinalLbl.text = String(indexPath.row + 1)
//        self.walletAddressLbl.text = wallet.address
//        self.balanceAdress.text = wallet.balance
//        self.tokenListAddress.text = wallet.tokenDisplay
//    }

}
class WalletAdressCell2: UITableViewCell {
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var extenView:UIView!
    @IBOutlet weak var ordinalLbl:UILabel!
    @IBOutlet weak var walletAddressLbl:UILabel!
    @IBOutlet weak var balanceAdress:UILabel!
    @IBOutlet weak var valueLbl:UILabel!
    @IBOutlet weak var walletAliasLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setData(walletData: WalletAddressRepresentable?, indexPath:IndexPath) {
        guard let wallet = walletData else { return }
        self.ordinalLbl.text = String(indexPath.row + 1)
        self.walletAddressLbl.text = wallet.addressDisplay
        self.balanceAdress.text = wallet.amount
        self.valueLbl.text = wallet.value
        self.walletAliasLbl.text = wallet.walletAlias
    }

}

