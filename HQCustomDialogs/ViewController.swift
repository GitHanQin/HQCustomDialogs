//
//  ViewController.swift
//  HQCustomDialogs
//
//  Created by 韩琴 on 2018/7/19.
//  Copyright © 2018年 韩琴. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        private lazy var animatorManager:HQCustomDialogs = {
            let manager = HQCustomDialogs()
            manager.presentFrame = CGRect.init(x:0.5*(UIScreen.main.bounds.width-100), y: 84, width: 100, height: 100)
            manager.prsentDeriction = HQPresentDeriction.Top
            return manager
        }()
        private lazy var bottomanimatorManager:HQCustomDialogs = {
            let manager = HQCustomDialogs()
            manager.presentFrame = CGRect.init(x:0.5*(UIScreen.main.bounds.width-100), y: 84, width: 100, height: 100)
            manager.prsentDeriction = HQPresentDeriction.Bottom
            manager.backGrougdColor = UIColor.red
            return manager
        }()
        private lazy var leftanimatorManager:HQCustomDialogs = {
            let manager = HQCustomDialogs()
            manager.presentFrame = CGRect.init(x:0.5*(UIScreen.main.bounds.width-100), y: 84, width: 100, height: 100)
            manager.prsentDeriction = HQPresentDeriction.Left
            return manager
        }()
        private lazy var rightanimatorManager:HQCustomDialogs = {
            let manager = HQCustomDialogs()
            manager.presentFrame = CGRect.init(x:0.5*(UIScreen.main.bounds.width-100), y: 84, width: 100, height: 100)
            manager.prsentDeriction = HQPresentDeriction.Right
            return manager
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func top(_ sender: Any) {
        let menuView = ExampleViewController()
        menuView.view.backgroundColor = UIColor.white
        menuView.transitioningDelegate = animatorManager
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom
        present(menuView, animated: true, completion: nil)
    }
    
    @IBAction func bottom(_ sender: Any) {
        let menuView = ExampleViewController()
        menuView.view.backgroundColor = UIColor.white
        menuView.transitioningDelegate = bottomanimatorManager
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom
        present(menuView, animated: true, completion: nil)
    }
    @IBAction func left(_ sender: Any) {
        let menuView = ExampleViewController()
        menuView.view.backgroundColor = UIColor.white
        menuView.transitioningDelegate = leftanimatorManager
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom
        present(menuView, animated: true, completion: nil)
    }
    @IBAction func right(_ sender: Any) {
        let menuView = ExampleViewController()
        menuView.view.backgroundColor = UIColor.white
        menuView.transitioningDelegate = rightanimatorManager
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom
        present(menuView, animated: true, completion: nil)
    }

}

