//
//  AppDelegate.swift
//  MyScrollView
//
//  Created by student on 2018/11/12.
//  Copyright © 2018年 yupeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var scroll : UIScrollView!
    var scroll2 : UIScrollView!
    var page : UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        let width = self.view.bounds.width - 20
        let height = width * 0.78
        
        scroll = UIScrollView(frame: CGRect(x: 10, y: 100, width: width, height: height))
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentSize = CGSize(width: width * 7, height: height) // 总的scrollView大小
        scroll.delegate = self
        self.view.addSubview(scroll)
        
        page = UIPageControl(frame: CGRect(x: 10, y: 100 + height, width: width, height: 30))
        page.numberOfPages = 7
        page.currentPage = 0
        page.pageIndicatorTintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) // pageControl未选中时颜色
        page.currentPageIndicatorTintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) // pageControl选中时的颜色
        page.addTarget(self, action: #selector(pageClicked(page:)), for: .touchUpInside) // 响应pageControll
        self.view.addSubview(page)
        
        for i in 1...7 {
            let image = UIImage(named: "\(i)")
            let imageView = UIImageView(frame: CGRect(x: width*CGFloat(i-1), y: 0, width: width, height: height))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill //  按view大小进行填充
            scroll.addSubview(imageView)
            
        }
        
        scroll2 = UIScrollView(frame: CGRect(x: 10, y: 200+height, width: width, height: height))
        scroll2.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        scroll2.contentSize = CGSize(width: width, height: height)
        scroll2.maximumZoomScale = 5
        scroll2.minimumZoomScale = 0.1
        scroll2.delegate = self
        self.view.addSubview(scroll2)
        
        let img = UIImage(named: "1")
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imgView.contentMode = .scaleAspectFill
        imgView.image = img
        scroll2.addSubview(imgView)
        
        
    }
    
    // 代理自带滚动方法实现，将page的当前页与滚动绑定在一起
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / (self.view.bounds.width - 20))
        page.currentPage = currentPage
    }
    
    // page点击响应函数
    @objc func pageClicked(page: UIPageControl){
        let rect = CGRect(x: scroll.bounds.width*CGFloat(page.currentPage), y: 0, width: scroll.bounds.width, height: scroll.bounds.height)
        scroll.scrollRectToVisible(rect, animated: true)
        
        
    }
    
    // 代理自带缩放方法实现
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scroll2.subviews.first
    }

}

