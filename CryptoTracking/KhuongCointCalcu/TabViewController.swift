//
//  TabViewController.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/12/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit
import Tabman
import Pageboy
import ObjectMapper
class TabViewController: TabmanViewController {
//    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
//        return TMBarItem(title: "khuongtlt")
//    }
    

    @IBOutlet weak var imgVBg:UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!

    private(set) var viewControllers: [UIViewController]!
    let bar = TMBar.ButtonBar()
    var symbol:String!
    var walletInfo:BaseModel?
    let titles = ["Transactions","Token Txs","Tokens"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupViewByDefaultData()
        
        //SETTING TOP TAB BAR
        self.dataSource = self
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .flat(color: XColors.shared.main)
        bar.buttons.customize { (button) in
          //  button.color = .orange
          //  button.selectedColor = .red
            button.tintColor = .white
            button.selectedTintColor = .white
        }
        bar.indicator.tintColor = .white
        bar.indicator.backgroundColor = .white
        addBar(self.bar, dataSource: self, at: TabmanViewController.BarLocation.top)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupNavBar() {
        //        let bounds = self.navigationController?.navigationBar.bounds as! CGRect
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//        visualEffectView.frame = bounds
//        self.navigationController?.navigationBar.insertSubview(visualEffectView, at: 0)
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        //self.navigationController?.navigationBar.isTranslucent = false
        //self.navigationController?.navigationBar.isHidden = true
        //self.navigationController?.navigationBar.backgroundColor = XColors.shared.main
    }

    @IBAction func onBack(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: titles[index])
    }
    

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
extension TabViewController {
    func setupViewByDefaultData() {
        switch symbol {
        case CryptoListing.shared._Ethereum.symbol:
            setupViewForETH()
            break
        default:
            break
        }
    }
    func setupViewForETH(){
        let storyboard = Storyboard.shared.main
        let vc0:ETHTransactionsViewController = storyboard.instantiateViewController()
        vc0.walletInfo = walletInfo as? ETHWalletAddress
        vc0.displayType = .Normal
        let vc1:ETHTransactionsViewController = storyboard.instantiateViewController()
        vc1.walletInfo = walletInfo as? ETHWalletAddress
        vc1.displayType = .ERC20Tranx
        let vc2:TokenSummaryViewController = storyboard.instantiateViewController()
        viewControllers = [vc0,vc1,vc2]
    }
}
