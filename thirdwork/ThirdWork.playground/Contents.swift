//
//  main.swift
//  ThirdWork
//
//  Created by apple on 2018/10/6.
//  Copyright © 2018年 yupeng. All rights reserved.
//

import Foundation


func getDate(dateFormatter:DateFormatter,Zone:Int = 0) -> String {
    if Zone >= 0 {
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC+\(Zone):00")
    }else{
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC\(Zone):00")
    }
    let zontDate = dateFormatter.string(from: currentDate)
    return zontDate
}

let currentDate = Date()
var dateFormatter = DateFormatter()
dateFormatter.dateFormat = "xxxx年x月xx日xxxx a hh:mm"
dateFormatter.locale = Locale(identifier: "gh_cn")

let beijingDate = getDate(dateFormatter: dateFormatter, Zone: 8)
print("北京时间：\(beijingDate)")
let tokyoDate = getDate(dateFormatter: dateFormatter, Zone: 9)
print("东京时间：\(tokyoDate)")
let newyorkDate = getDate(dateFormatter: dateFormatter, Zone: -4)
print("纽约时间：\(newyorkDate)")
let londonDate = getDate(dateFormatter: dateFormatter, Zone: 1)
print("伦敦时间：\(londonDate)")


//处理字符串
let originStirng = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS."
let startIndex : String.Index = originStirng.index(originStirng.startIndex, offsetBy: 5)
let endIndex : String.Index = originStirng.index(originStirng.startIndex, offsetBy: 15)
print("最初字符串：\(originStirng)")
let firstSub = originStirng.substring(from: startIndex)
print("第一次截取的子串：\(firstSub)")
let secSub = firstSub.substring(to: endIndex)
print("最终截取的子串：\(secSub)")
let replacedStr = originStirng.replacingOccurrences(of: "OS", with: "")
print("替换后的子串：\(replacedStr)")

//存入字典和沙盒
let timeDic = ["beijing":beijingDate,"tokyo":tokyoDate,"newyork":newyorkDate,"london":londonDate] as AnyObject
print(timeDic)
let strDic = ["origin":originStirng,"firstSub":firstSub,"secSub":secSub,"replaced":replacedStr] as AnyObject
print(strDic)
let defaultPath = FileManager.default
var path = defaultPath.urls(for: .documentDirectory,in: .userDomainMask).first
if path != nil {
    path?.appendPathComponent("test.txt")
    print(timeDic.write(to: path!, atomically: true))
    print(strDic.write(to: path!, atomically: true))
}

//接口操作
let image = try Data(contentsOf: URL(string: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4015787744,1102797590&fm=27&gp=0.jpg")!)
if var url = defaultPath.urls(for: .documentDirectory, in: .userDomainMask).first{
    url.appendPathComponent("image.png")
    try image.write(to: url)
}
let url = URL(string: "http://www.weather.com.cn/data/sk/101270102.html")
let str = try String(contentsOf: url!)
print(str)
let data = try Data(contentsOf: url!)
let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
if let dic = json as? [String:Any]{
    if let weather = dic["weatherinfo"] as? [String:Any]{
        let city = weather["city"]!
        let temp = weather["temp"]!
        let wd = weather["WD"]!
        let ws = weather["WS"]!
        print("city:\(city),tempature:\(temp),wd:\(wd),ws:\(ws)")
    }
}




