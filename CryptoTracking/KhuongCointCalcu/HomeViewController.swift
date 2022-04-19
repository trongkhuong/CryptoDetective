//
//  ViewController.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/8/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import Pastel
import FirebaseFirestore
class HomeViewController: ExpandingViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var AddNewWalletBtn:UIButton!
    @IBOutlet weak var numberOfCoinLbl:UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    let transition = BubbleTransition()
    fileprivate var cellsIsOpen = [Bool]()
    fileprivate var viewModel: HomeViewModel!

    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var searchTextWidthContraint:NSLayoutConstraint!
    let search = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 460)
        super.viewDidLoad()
        self.setUpBackground()
        viewModel = HomeViewModel()
        viewModel.fetchDataCompletion = {
            DispatchQueue.main.async { [weak self] in
                self?.fillCellIsOpenArray()
                self?.collectionView?.reloadData()
                self?.numberOfCoinLbl.text = self?.viewModel.currentIndexDisplay(index: 0)
            }
        }
        viewModel.query = ["fsyms": "BTC,ETH", "tsyms": FLAT_CURRENCY.USD.rawValue]
        // loading list from database
//        let item0 = HomeViewModel(name:CryptoListing.shared._Ethereum.name, symbol:CryptoListing.shared._Ethereum.symbol, img_bg: "img_ETH_BG", logo: "img_ETH",price:"loading...", currency:"", changed: "loading...")
//        let item1 = HomeViewModel(name:CryptoListing.shared._Bitcoin.name,symbol:CryptoListing.shared._Bitcoin.symbol, img_bg: "img_BTC_BG", logo: "img_BTC",price:"loading...", currency:"", changed: "loading...")
//        list.append(item0)
//        list.append(item1)

        registerCell()
        fillCellIsOpenArray()
        addGesture(to: collectionView!)
        configureNavBar()
        
        //getDataFromFireBase()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.search.searchBar.isHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    // MARK: UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = AddNewWalletBtn.center
        transition.bubbleColor = AddNewWalletBtn.backgroundColor!
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = AddNewWalletBtn.center
        transition.bubbleColor = AddNewWalletBtn.backgroundColor!
        return transition
    }
    @IBAction func AddNewWalletPage(_ sender:UIButton) {
        
    }
}
extension HomeViewController {

    fileprivate func registerCell() {

        let nib = UINib(nibName: String(describing: HomeCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: HomeCollectionViewCell.self))
    }

    fileprivate func fillCellIsOpenArray() {
        cellsIsOpen = Array(repeating: false, count: viewModel.numberOfCoin)
    }

    fileprivate func getViewController() -> ExpandingTableViewController {
        let marketRawExchangeData = viewModel.getMarketInfo(at: self.currentIndex)
        let toViewController: WalletAdressesViewController = Storyboard.shared.main.instantiateViewController()
        toViewController.symbol = marketRawExchangeData?.fromSymbol ?? "ETH"
        return toViewController
    }


    fileprivate func configureNavBar() {
       // self.navigationController?.navigationBar.prefersLargeTitles = true
       // self.navigationItem.largeTitleDisplayMode = .never
        search.searchBar.barTintColor = .white
        search.delegate = self
        search.searchBar.tintColor = .white
        self.navigationItem.searchController = search

       // navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    fileprivate func setUpBackground() {

        let pastelView = PastelView(frame: view.bounds)
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight

        // Custom Duration
        pastelView.animationDuration = 3.0

        // Custom Color
        pastelView.setColors([
            UIColor.hexStringToUIColor(hex: "FCE38A"),
            UIColor.hexStringToUIColor(hex: "F38181"),
            UIColor.hexStringToUIColor(hex: "F54EA2"),
            UIColor.hexStringToUIColor(hex: "FF7676"),
            UIColor.hexStringToUIColor(hex: "17EAD9"),
            UIColor.hexStringToUIColor(hex: "6078EA"),
            UIColor.hexStringToUIColor(hex: "622774"),
            UIColor.hexStringToUIColor(hex: "C53364"),
            UIColor.hexStringToUIColor(hex: "7117EA"),
            UIColor.hexStringToUIColor(hex: "EA6060"),
            UIColor.hexStringToUIColor(hex: "42E695"),
            UIColor.hexStringToUIColor(hex: "3BB2B8"),
            UIColor.hexStringToUIColor(hex: "F02FC2"),
            UIColor.hexStringToUIColor(hex: "6094EA"),
            UIColor.hexStringToUIColor(hex: "65799B"),
            UIColor.hexStringToUIColor(hex: "5E2563"),
            UIColor.hexStringToUIColor(hex: "184E68"),
            UIColor.hexStringToUIColor(hex: "57CA85"),
            UIColor.hexStringToUIColor(hex: "5B247A"),
            UIColor.hexStringToUIColor(hex: "1BCED7")])

        pastelView.alpha = 0.2
        pastelView.startAnimation()
        view.insertSubview(pastelView, belowSubview: blurView)
    }

}
/// MARK: Gesture
extension HomeViewController {

    fileprivate func addGesture(to view: UIView) {
        let upGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.swipeHandler(_:)))) {
            $0.direction = .up
        }

        let downGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.swipeHandler(_:)))) {
            $0.direction = .down
        }
        view.addGestureRecognizer(upGesture)
        view.addGestureRecognizer(downGesture)
    }

    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) as? HomeCollectionViewCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController())
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }
}

// MARK: UIScrollViewDelegate
extension HomeViewController {

    func scrollViewDidScroll(_: UIScrollView) {
       // pageLabel.text = "\(currentIndex + 1)/\(items.count)"
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let collectionView = self.collectionView else {
            return
        }
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        self.numberOfCoinLbl.text = viewModel.currentIndexDisplay(index: indexPath.row)
    }
}
// MARK: UICollectionViewDataSource & Delegate

extension HomeViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard viewModel != nil else {
            return 0
        }
        return viewModel.numeberOfSection
    }
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        guard viewModel != nil else {
            return 0
        }
        return viewModel.numberOfCoin
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCollectionViewCell.self), for: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? HomeCollectionViewCell else { return }

        let index = indexPath.row
        let info = viewModel.marketInfo(at: index)
        cell.setData(data: info)
//        cell.backgroundImageView?.image = UIImage(named: info.imageName)
//        cell.customTitle.text = info.title
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell
            , currentIndex == indexPath.row else { return }
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
            self.search.searchBar.isHidden = true
            pushToViewController(getViewController())

            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }
}


//MARK: GET DATA FROM API
extension HomeViewController {

    func getDataFromFireBase() {

        //Write table - COIN
//        let collection = Firestore.firestore().collection("Coins")
//        let ethCoin = Crypto(id: "0", name: "Ethereum", symbol: "ETH", decimal: "18", type: "coin")
//        let btcCoin = Crypto(id: "1", name: "Bitcoin", symbol: "BTC", decimal: "8", type: "coin")
//        let neoCoin = Crypto(id: "2", name: "Neo", symbol: "NEO", decimal: "0", type: "coin")
//        collection.addDocument(data: ethCoin.dictionary)
//        collection.addDocument(data: btcCoin.dictionary)
//        collection.addDocument(data: neoCoin.dictionary)
        //Read table COINS
//        let db = Firestore.firestore().collection("Coins")
//        db.getDocuments { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                let models = querySnapshot?.documents.map({ (document) -> Crypto in
//                    if let model = Crypto(dict: document.data()) {
//                        return model
//                    } else {
//                        return Crypto(id: "", name: "", symbol: "", decimal: "", type: "")
//                    }
//                })
//                print(models?.count)
//            }
//        }
        // WRITE TABLE USER ADDRES
//        let ico = UserWalletAddress(nickName: "ICO", address: "0x38006e2fb44627138bE3817FEea44f7D9eBD2E62", coinId: "0", userId: "trongkhuongit91@gmail.com")
//        let airdrop0 = UserWalletAddress(nickName: "Airdrop 0", address: "0xE1531C9c5Eb5C07aF24AA8fb0B1Fe64ab5269bE4", coinId: "0", userId: "trongkhuongit91@gmail.com")
//        let airDrop1 = UserWalletAddress(nickName: "Airdrop 1", address: "0xF334514EBF13f955F49BE5a6F854E0182B271581", coinId: "0", userId: "trongkhuongit91@gmail.com")
//        let airDrop2 = UserWalletAddress(nickName: "Airdrop 2", address: "0x8a96F44549AF526575F8B610d15a12dFDfCE61eD", coinId: "0", userId: "trongkhuongit91@gmail.com")
//        let openPlatform = UserWalletAddress(nickName: "OPEN Flatform Ico", address: "0x0E4F3c96DD254a894A5789c5837FaB9946df4fe2", coinId: "0", userId: "trongkhuongit91@gmail.com")
//
//        let collection = Firestore.firestore().collection("UserWallets")
//        collection.addDocument(data: ico.dictionary)
//        collection.addDocument(data: airdrop0.dictionary)
//        collection.addDocument(data: airDrop1.dictionary)
//        collection.addDocument(data: airDrop2.dictionary)
//        collection.addDocument(data: openPlatform.dictionary)

        //Filter
        let collection = Firestore.firestore().collection("UserWallets").whereField("userId", isEqualTo: "trongkhuongit91@gmail.com")
        collection.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let models = querySnapshot?.documents.map({ (document) -> UserWalletAddress in
                    if let model = UserWalletAddress(dict: document.data()) {
                        return model
                    } else {
                        return UserWalletAddress(nickName: "", address: "", coinId: "", userId: "")
                    }
                })
                print(models?.count)
            }
        }
    }
}

//MARK: SearchBar
extension HomeViewController {

    @IBAction func search(_ sender:UIButton) {
        if searchTextWidthContraint.constant == 44 {
            searchTextWidthContraint.constant = 244
        } else {
            searchTextWidthContraint.constant = 44
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func back(_ sender:AnimatingButton) {
        sender.animationSelected(true)
    }
}
extension HomeViewController: UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Add your search logic here
        print(searchText)
    }
}


