//
//  WalletAdressesViewController
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/4/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit
import ObjectMapper
import ViewAnimator
class WalletAdressesViewController: ExpandingTableViewController {

    fileprivate var scrollOffsetY: CGFloat = 0
    var viewModel:WalletAddressesViewModel!
    var symbol:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        //self.testData()
        self.testData2()
        
//        let image1 = UIImage(named: "ImgBg")!
//        tableView.backgroundView = UIImageView(image: image1)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func configureNavBar() {
        //navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y < -25 , let navigationController = navigationController {
            // buttonAnimation
            for case let viewController as HomeViewController in navigationController.viewControllers {
                if case let rightButton as AnimatingBarButton = viewController.navigationItem.rightBarButtonItem {
                    rightButton.animationSelected(false)
                }
            }
            popTransitionAnimation()
        }
        scrollOffsetY = scrollView.contentOffset.y
    }
    func fetchDataCompletion()  {
        self.tableView.reloadData()
    }
}

extension WalletAdressesViewController {
    @IBAction func backButtonHandler(_: AnyObject) {
        let viewControllers: [HomeViewController?] = navigationController?.viewControllers.map { $0 as? HomeViewController } ?? []

        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(false)
            }
        }
        popTransitionAnimation()
    }
}
extension WalletAdressesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getViewModel().numberOfSection
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.getViewModel().numberOfRowInSection(section: section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WalletAdressCell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! WalletAdressCell2
        cell.selectionStyle = .none
        cell.setData(walletData: viewModel.getViewModel().getInfoByIndex(indexPath: indexPath), indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tabVC:TabViewController = Storyboard.shared.main.instantiateViewController()
        tabVC.symbol = self.symbol
        tabVC.walletInfo = viewModel.getModel(at: indexPath.row)
        self.navigationController?.show(tabVC, sender: nil)
    }

}
extension WalletAdressesViewController {
//    func testData () {
//        var params:NSMutableDictionary = NSMutableDictionary.init()
//        ServiceTesting.readPlist("params", assignNewData: &params, overwrite: true)
//        let test = params["list"] as! String
//        if let wallet:ETHWalletAddress = Mapper<ETHWalletAddress>().map(JSONString: test) {
//            viewModel = WalletAddressesViewModel(symbol: "ETH", dataSource: [wallet], fetchDataCompletion: self.fetchDataCompletion) //WalletAddressesViewModel(symbol: "ETH", fetchDataCompletion: self.fetchDataCompletion)
//        }
//    }
    func testData2() {
        var wallets:[ETHWalletAddress] = [] // = ETHWalletAddress()
        var params:NSMutableDictionary = NSMutableDictionary.init()
        ServiceTesting.readPlist("params", assignNewData: &params, overwrite: true)
        let test = params["multiAddress"] as! String
        do{
            if let json = test.data(using: String.Encoding.utf8){
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                    let mess = jsonData["message"] as! String
                    if let result = jsonData["result"] as? [Dictionary<String,String>] {
                        result.forEach { dict in
                            let wallet = ETHWalletAddress()
                            wallet.address = dict["account"]
                            let info:EtherInfo = EtherInfo()
                            info.balance = Double(dict["balance"] ?? "0")
                            wallet.eTH = info
                            wallets.append(wallet)
                        }
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        if  wallets.count > 0 {
            viewModel = WalletAddressesViewModel(symbol: self.symbol, dataSource: wallets, fetchDataCompletion: self.fetchDataCompletion)
        }
       
    }
}
