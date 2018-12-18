//
// ViewController.swift
//  CodeHelloWorld
//
//  Created by student on 2018/10/19.
//  Copyright © 2018年 yupeng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //以下的view指的是当前的controller的属性view，省去了self的修饰
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
        
        let filemanager = FileManager.default
        //文档路径变量
        let docpath = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first
        let document = docpath?.appendingPathComponent("image", isDirectory: true)
        //如果文件夹存在
        if filemanager.fileExists(atPath: (document?.path)!) {
            let file = document?.appendingPathComponent("/lll.jpg")
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
        
        // Do any additional setup after loading the view.
    }
    //事件处理函数，要用@IBAction修饰
    @IBAction func clickHelloButton() {
        if let label = view.subviews[1] as? UILabel {
            if label.text! == "hello,world" {
                label.text = "hello,yangjian"
            }else{
                label.text = "hello,world"
            }
//            label.text = "hello,yangjian"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class ovalView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        
        UIColor.blue.setStroke()
        path.stroke()
        
        UIColor.yellow.setFill()
        path.fill()
        
    }
}
