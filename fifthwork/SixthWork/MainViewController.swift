//
//  MainViewController.swift
//  fifthWork
//
//  Created by student on 2018/10/23.
//  Copyright © 2018年 yupeng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.green
        let helloButton = UIButton(frame: CGRect(x: 100, y: 50, width: 250, height: 50))
        helloButton.setTitle("our all person are xingchu", for: .normal)
        view.addSubview(helloButton) //设置好button的位置以及属性，再添加到子视图中显示
        
        let helloLabel = UILabel(frame: CGRect(x: 125, y: 150, width: 200, height: 20))
        helloLabel.text = "hello,allworld"
        helloLabel.textAlignment = .center
        helloLabel.textColor = UIColor.black
        view.addSubview(helloLabel) //设置好title的位置以及属性，添加到子视图中显示
        
        helloButton.addTarget(self, action: #selector(clickHelloButton), for: .touchUpInside) //添加事件响应
        
        //在程序第一次运行时，将不会显示图片，等到程序第二次运行，将图片目录以及图片下载好之后，才会在界面中显示图片
        let filemanager = FileManager.default
        //文档路径变量
        let docpath = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first
        let document = docpath?.appendingPathComponent("image", isDirectory: true)
        //如果文件夹存在
        if filemanager.fileExists(atPath: (document?.path)!) {
            let file = document?.appendingPathComponent("/111.jpg")
            //如果图片文件存在
            if filemanager.fileExists(atPath: (file?.path)!){
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: (file?.path)!))
                    let img = UIImage(data: data)
                    let imgView = UIImageView(image: img)
                    imgView.frame = CGRect(x: 85, y: 200, width: 280, height: 400)
                    self.view.addSubview(imgView)
                    
                } catch {
                    print(error)
                }
            } else {
                //下载图片放入文件中
                let url = URL(string: "http://img5.duitang.com/uploads/item/201411/07/20141107164412_v284V.jpeg")
                do {
                    let data = try Data(contentsOf: url!)
                    try data.write(to: URL(fileURLWithPath: (file?.path)!), options: .atomicWrite)
                    let img = UIImage(data: data)
                    let imgview = UIImageView(image: img)
                    imgview.frame = CGRect(x: 50, y: 200, width: 280, height: 400)
                    self.view.addSubview(imgview)
                    
                } catch {
                    print(error)
                }
            }
            
        } else {//文件不存在则创建路径
            do {
                try filemanager.createDirectory(at: document!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
        
        let oval = ovalView(frame: CGRect(x: 20, y: 40, width: 100, height: 60)) //ovalView为自定义视图类
        oval.backgroundColor = UIColor.clear
        self.view.addSubview(oval)
    }
    
    //事件处理函数，要用@IBAction修饰
    @IBAction func clickHelloButton() {
        if let label = view.subviews[1] as? UILabel {
            if label.text! == "hello,world" {
                label.text = "hello,yupeng"
            }else{
                label.text = "hello,world"
            }
           
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   

}

//自定义的椭圆视图
class ovalView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        
        UIColor.blue.setStroke()
        path.stroke()
        
        UIColor.yellow.setFill()
        path.fill()
        
    }
}
