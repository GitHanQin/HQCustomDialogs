//
//  HQCustomDialogs.swift
//  HQDalog
//
//  Created by 韩琴 on 2018/7/18.
//  Copyright © 2018年 韩琴. All rights reserved.
//

import UIKit

//自定义转场
public let HQCustomDialogsDidPresented = "HQCustomDialogsDidPresented"
public let HQCustomDialogsDidDismiss = "HQCustomDialogsDidDismiss"

//转场方向
public enum HQPresentDeriction {
    case Left
    case Right
    case Top
    case Bottom
}
 class HQCustomDialogs: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    //MARK:-UIViewControllerTransitioningDelegate
    
    ///记录当前是展开还是消失
    private var present = false
    //该方法用于返回一个负责转场动画对象的尺寸
    //保存菜单的尺寸
    public var presentFrame = CGRect.zero
    //点击背景是否收回
    public var isCoverEnlable:Bool = true
    //弹出方向
    public var prsentDeriction:HQPresentDeriction = .Top
    //背景颜色
    public var backGrougdColor:UIColor = UIColor.init(white: 0.5, alpha: 0.5)
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = PopoverViewController.init(presentedViewController: presented, presenting: presenting)
        pc.coverButton.isEnabled = isCoverEnlable
        pc.presentFrame =  presentFrame
        pc.coverButton.backgroundColor = backGrougdColor
        return pc
    }
    //该方法用于返回一个负责转场如何出现的对象
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //发送一个通知给按钮状态发生了改变
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: HQCustomDialogsDidPresented), object: self)
        present = true
        return self
    }
    //该方法用于返回一个负责转场如何消失的对象
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        present = false
        //发送一个通知给按钮状态发生了改变
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: HQCustomDialogsDidDismiss), object: self)
        return self
    }
    //MARK: - UIPresentationController
    //告诉系统展现和消失的时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    //告诉该系统是如何展现和消失的，如我实现这个代理方法系统就不会添加默认的动画，所有的动画需要自己实现
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //判断是展现还是消失
        if present == true {
            //viewController
            //        let toView = transitionContext.viewController(forKey: .to)
            //        let froView = transitionContext.viewController(forKey: .from)
            //view
            //取出toView
            guard let toView = transitionContext.view(forKey: .to) else {
                return
            }
            //            HQLog(message: toView)
            //将toView添加到forView
            transitionContext.containerView.addSubview(toView)
            switch prsentDeriction {
            case .Left:
                //为toView设置动画
                toView.transform = CGAffineTransform.init(scaleX: 0.0, y: 1.0)
                //设置锚点
                toView.layer.anchorPoint = CGPoint.init(x: 0.0, y: 0.5)
                break
            case .Right:
                //为toView设置动画
                toView.transform = CGAffineTransform.init(scaleX: 0.0, y: 1.0)
                //设置锚点
                toView.layer.anchorPoint = CGPoint.init(x: 1.0, y:0.5)
                break
            case .Bottom:
                //为toView设置动画
                toView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)
                //设置锚点
                toView.layer.anchorPoint = CGPoint.init(x: 0.5, y: 1)
                break
            default:
                //为toView设置动画
                toView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)
                //设置锚点
                toView.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0)
                break
            }
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.transform = .identity
            }) { (_) in
                //自定义转场动画，在执行完动画执行结束后，一定要告诉程序动画执行完毕
                transitionContext.completeTransition(true)
            }
        } else {
            //取出ForView
            guard let froView = transitionContext.view(forKey: .from) else {
                return
            }
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                switch self.prsentDeriction {
                case .Left,.Right:
                    froView.transform = CGAffineTransform.init(scaleX: 0.0001, y: 1)
                    
                    break
                default:
                    froView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0001)
                    break
                }
                
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
            //            HQLog(message: froView)
        }
    }
}

