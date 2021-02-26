//
//  loadingIndicator.swift
//  TestNYT
//
//  Created by Vlad on 26.02.2021.
//

import Foundation
import UIKit

class loadingIndicator{
    
    var X = Double()
    var Y = Double()
    
    var crcl1 = UIView()
    var crcl2 = UIView()
    var crcl3 = UIView()
    
    var isEnable = false
    var mainView = UIView()
    
    init(view : UIView) {
        
        mainView = view
        
        X = Double(mainView.center.x)
        Y = Double(mainView.center.y)
        
        crcl1 = UIView(frame: CGRect(x: X-35, y: Y, width: 20, height: 20))
        crcl1.backgroundColor = UIColor.blue
        crcl1.layer.cornerRadius = 10
        mainView.addSubview(crcl1)
        crcl2 = UIView(frame: CGRect(x: X-10, y: Y, width: 20, height: 20))
        crcl2.backgroundColor = UIColor.blue
        crcl2.layer.cornerRadius = 10
        mainView.addSubview(crcl2)
        crcl3 = UIView(frame: CGRect(x: X+15, y: Y, width: 20, height: 20))
        crcl3.backgroundColor = UIColor.blue
        crcl3.layer.cornerRadius = 10
        mainView.addSubview(crcl3)

        animate()
        
        self.crcl1.isHidden = true
        self.crcl2.isHidden = true
        self.crcl3.isHidden = true
    }
    
    private func animate() {
        UIView.animate(withDuration: 0.39, delay: 0, options: [.repeat,.autoreverse], animations: {
            self.crcl1.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: nil)
        UIView.animate(withDuration: 0.39, delay: 0.13, options: [.repeat,.autoreverse], animations: {
            self.crcl2.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: nil)
        UIView.animate(withDuration: 0.39, delay: 0.26, options: [.repeat,.autoreverse], animations: {
            self.crcl3.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: nil)
    }
    
    func startAnimating(){
        isEnable = true
        self.crcl1.isHidden = false
        self.crcl2.isHidden = false
        self.crcl3.isHidden = false
        self.crcl1.alpha = 0
        self.crcl2.alpha = 0
        self.crcl3.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.mainView.subviews.forEach { (viewS) in
                if !(viewS == self.crcl1 || viewS == self.crcl2 || viewS == self.crcl3){
                viewS.alpha = 0.5
                }}
            self.crcl1.alpha = 1
            self.crcl2.alpha = 1
            self.crcl3.alpha = 1
        }
    }
    
    func stopAnimating(){
        isEnable = false
        UIView.animate(withDuration: 0.5, animations: {
            self.mainView.subviews.forEach { (viewS) in
                viewS.alpha = 1
            }
            self.crcl1.alpha = 0
            self.crcl2.alpha = 0
            self.crcl3.alpha = 0
        }, completion: { (_) in
            self.crcl1.isHidden = true
            self.crcl2.isHidden = true
            self.crcl3.isHidden = true
        })
    }
}
