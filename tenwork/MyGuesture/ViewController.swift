//
//  AppDelegate.swift
//  MyGuesture
//
//  Created by student on 2018/11/15.
//  Copyright © 2018年 yupeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Add(_ sender: UIButton) {

        let x = Int(arc4random()) % Int(self.view.bounds.width)
        let y = Int(arc4random()) % Int(self.view.bounds.height - 100)
        
        label = UILabel(frame: CGRect(x: x, y: y, width: 60, height: 40))
        label.text = "haha"
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        // 设置阴影样式
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 10, height: 10)
        label.layer.shadowOpacity = 1
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:))) // 单个label移动手势识别
        label.addGestureRecognizer(panRecognizer) // 为label添加pan移动响应
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:))) // 为label添加tap删除响应
        label.addGestureRecognizer(tapRecognizer)
        tapRecognizer.numberOfTapsRequired = 2 // 设置为双击两次某个label即可消失
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
        label.addGestureRecognizer(pinch) // 为label添加缩放响应
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotation(recognizer:)))
        label.addGestureRecognizer(rotation)
        
        self.view.addSubview(label)
    }
    
    // label块移动函数
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .changed || recognizer.state == .ended {
            let translation = recognizer.translation(in: self.view)
            recognizer.view?.center.x += translation.x
            recognizer.view?.center.y += translation.y
            recognizer.setTranslation(.zero, in: self.view)
            
        }
        
    }
    
    // label块删除函数
    @objc func tap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .recognized {
            recognizer.view?.removeFromSuperview()
        }
    }
    
    // 添加缩放
    @objc func pinch(recognizer: UIPinchGestureRecognizer) {
        let scale = recognizer.scale
        label.transform = label.transform.scaledBy(x: scale, y: scale)
        recognizer.scale = 1 // 重新设置scale
    }
    
    // 添加旋转
    @objc func rotation(recognizer: UIRotationGestureRecognizer) {
        let rotation = recognizer.rotation
        label.transform = label.transform.rotated(by: rotation)
        recognizer.rotation = 0 // 重新设置rotation
    }
    
    @IBAction func Move(_ sender: Any) {
        
        for label in self.view.subviews {
            if label is UILabel {
                // 添加移动动画
                UIView.animate(withDuration: 1) {
                    let x = Int(arc4random()) % Int(self.view.bounds.width)
                    let y = Int(arc4random()) % Int(self.view.bounds.height - 100)
                    label.center = CGPoint(x: x, y: y)
                }
            }
        }
        
    }
    
    @IBAction func Clear(_ sender: Any) {
        for label in self.view.subviews {
            if label is UILabel {
                label.removeFromSuperview()
            }
        }
    }
    
}
