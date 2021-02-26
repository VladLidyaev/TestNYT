//
//  ViewController.swift
//  TestNYT
//
//  Created by Vlad on 26.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    @IBAction func reloadTap(_ sender: UIBarButtonItem) {
        reloadData()
    }
    
    var indicator : loadingIndicator!
    let postProvider = dataProvider()
    var mainData = BehaviorRelay<[Post]>(value: [Post]())
    let DBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = loadingIndicator(view: self.view)
        reloadData()
        
        
        _ = mainData.bind(to: tableView.rx.items(cellIdentifier: "PostCell")) {(row,item,cell) in
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.subsection
        }.disposed(by: DBag)
        
        tableView.rx
            .itemSelected
            .subscribe ( onNext: {
                [self] indexPath in
                guard let url = URL(string: mainData.value[indexPath[1]].url!) else { return }
                let svc = SFSafariViewController(url: url)
                present(svc, animated: true, completion: nil)
                }
            ).disposed(by: DBag)
    }
    
    
    private func reloadData() {
        indicator.startAnimating()
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .background).async { [self] in
            postProvider.getList { [self] (results) in
                switch results {
                case .success(let data):
                    mainData.accept(data)
                    DispatchQueue.main.async {
                        self.navigationItem.title = "Top stories: " + String(mainData.value.count)
                    }
                    semaphore.signal()
                case .failure(_):
                    mainData.accept([Post]())
                    ShowAlert()
                    semaphore.signal()
                }
            }
        }
        semaphore.wait()
        indicator.stopAnimating()
    }
    
    private func configureProperties() {
        let title = "Top stories"
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func ShowAlert(){
        let HoustonMess = "Houston, we have a problem..."
        DispatchQueue.main.async {
            if Reachability.isConnectedToNetwork() {
                let alert = UIAlertController(title: HoustonMess, message: "We have a small problem on the server. We'll fix it soon", preferredStyle: .alert)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: HoustonMess, message: "You have problems connecting to the Internet, check your connection and restart the app.", preferredStyle: .alert)
                self.present(alert, animated: true)
            }
        }
    }
    
}

