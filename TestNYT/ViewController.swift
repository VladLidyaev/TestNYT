//
//  ViewController.swift
//  TestNYT
//
//  Created by Vlad on 26.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let postProvider = dataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postProvider.getList { (results) in
            switch results {
            case .success(let data):
                print(data.count)
            case .failure(_):
                print("provider error")
            }
        }
    }
    
    

}

