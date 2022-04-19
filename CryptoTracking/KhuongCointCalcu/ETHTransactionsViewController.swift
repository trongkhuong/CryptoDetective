//
//  TransactionsViewController.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/16/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit
import FoldingCell
import ObjectMapper

class ETHTransactionsViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    enum Const {
        static let closeCellHeight: CGFloat = 173
        static let openCellHeight: CGFloat = 531 //
    }
    fileprivate var cellHeights: [CGFloat] = []
    fileprivate var scrollOffsetY: CGFloat = 0
    var displayType:ETHTransactionType = .Normal
    var viewModel:ETHTranxViewModel!
    var walletInfo:ETHWalletAddress?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        viewModel = ETHTranxViewModel(with: displayType)
        //configureNavBar()
        setup()
        if let walletInfo = self.walletInfo, let address = walletInfo.address {
            getTranx(from: address)
        }
        // Do any additional setup after loading the view.
    }

    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: viewModel.numberOfRowInSection(section: 0))
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 8, right: 0) // 64 + 8
        //        if #available(iOS 10.0, *) {
        //            tableView.refreshControl = UIRefreshControl()
        //            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        //        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension ETHTransactionsViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection(section: section)
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as ETHTransactionViewCell = cell else {
            return
        }

        cell.backgroundColor = .clear

        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }

        //cell.number = indexPath.row
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! ETHTransactionViewCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        let tranx = viewModel.getTranx(at: indexPath.row)
        cell.setData(data: tranx, index: indexPath)
        cell.closeAction = foldCell(_:)
        return cell
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell

        if cell.isAnimating() {
            return
        }
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    func foldCell(_ indexPath:IndexPath) {
        tableView(tableView, didSelectRowAt: indexPath)
    }
}
extension ETHTransactionsViewController {
    //MARK: Get transactionS
    func getTranx(from address:String) {
//        let apiKey = ValuesUtils.shared.ETH_EtherScanAPIKey
//        let url:String = "http://api.etherscan.io/api?module=account&action=txlist&address=\(address)&startblock=0&endblock=999999999&sort=desc&apikey=\(apiKey)"
        viewModel.searchAddress = address
        viewModel.fetchDataCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.cellHeights = Array(repeating: Const.closeCellHeight, count: self?.viewModel.transactions.count ?? 0)
                self?.tableView.reloadData()
            }
        }
    }
    //MARK: GET TOKEN TRANSACTION
}
