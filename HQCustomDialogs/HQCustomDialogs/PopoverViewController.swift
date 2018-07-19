//
//  PopoverViewController.swift
//  FrisitSwift
//
//  Created by 韩琴 on 2017/12/18.
//  Copyright © 2017年 韩琴. All rights reserved.
//

import UIKit

class PopoverViewController:UIPresentationController  {
    /*
     1.如果不自定义转场modal出来的控制器会移除原有的控制器
     2.如果自定义转场modal出来的控制器不会移除原有的控制器
     3.如果不自定义转场modal出来的控制器的尺寸和屏幕一样
     4.如果自定义转场modal出来的控制器的尺寸我们可以自己在containerViewWillLayoutSubviews方法中控制
     5.containerView 非常重要, 容器视图, 所有modal出来的视图都是添加到containerView上的
     6.presentedView() 非常重要, 通过该方法能够拿到弹出的视图
     */
    var presentFrame = CGRect.zero
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    // 用于布局转场动画弹出的控件
    override func containerViewWillLayoutSubviews()
    {
//        HQLog(message:"")
        // 设置弹出视图的尺寸
        presentedView?.frame = presentFrame
        //添加蒙版
        containerView?.insertSubview(coverButton, at: 0)
        coverButton.addTarget(self, action: #selector(coverButtonClick(_:)), for:.touchUpInside)
    }
    //MARK: - 按钮点击事件
    @objc private func coverButtonClick(_:UIButton) {
//        HQLog(message: presentedViewController)
//        HQLog(message: presentingViewController)
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    //MARK: - 懒加载
    var coverButton:UIButton = {
        let btn = UIButton()
        btn.frame = UIScreen.main.bounds
        btn.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        //闭包里无法添加self是一个强引用
        return btn
    }()
    
}
