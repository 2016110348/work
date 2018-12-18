//
//  AppDelegate.swift
//  MyTableView
//
//  Created by student on 2018/11/27.
//  Copyright © 2018年 yupeng. All rights reserved.
//


import UIKit

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var table: UITableView!
    var studentArray = [Student]()
    var teacherArray = [Teacher]()
    var sectionTitle = ["Teacher", "Student"]
    var rightItem: UIBarButtonItem!
    var leftItem: UIBarButtonItem!
    var alert: UIAlertController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Information"
        
        for i in 1...3 {
            let student = Student(stuNo: 20160101 + i, firstName: "喻", lastName: "\(i)", age: 20, gender: .male, department: .one)
            studentArray.append(student)
        }
        
        for i in 1...5 {
            let teacher = Teacher(title: "讲师", firstName: "杨", lastName: "\(i)", age: 34, gender: .male, department: .two)
            teacherArray.append(teacher)
        }
        
        teacherArray.sort { (t1, t2) -> Bool in
            return t1.fullName < t2.fullName
        }
        studentArray.sort { (s1, s2) -> Bool in
            return s1.fullName < s2.fullName
        }
        
        rightItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(edit))
        self.navigationItem.rightBarButtonItem = rightItem
        
        leftItem = UIBarButtonItem(title: "Add Student", style: .plain, target: self, action: #selector(addStudent))
        self.navigationItem.leftBarButtonItem = leftItem
        
        table = UITableView(frame: self.view.bounds)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        
    }
    
    @objc func edit() {
        if table.isEditing {
            rightItem.title = "Edit"
            table.isEditing = false
        } else {
            rightItem.title = "Finish"
            table.isEditing = true
        }
    }
    
    @objc func addStudent() {
        alert = UIAlertController(title: "You can add a student", message: "Input the student's message", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "student number"
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "first name"
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "last name"
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "age"
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "male/female for Gender"
            
        }
        
        let addButton = UIAlertAction(title: "add", style: .default) { (UIAlertAction) in
            self.add()
        }
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func add() {
        let no = Int(alert.textFields![0].text!)
        let firstName = alert.textFields![1].text!
        let lastName = alert.textFields![2].text!
        let gender: Gender
        switch alert.textFields![3].text! {
        case "男":
            gender = .male
        case "女":
            gender = .female
        default:
            gender = .unknow
        }
        let age = Int(alert.textFields![4].text!)!
        let student = Student(stuNo: no!, firstName: firstName, lastName: lastName, age: age, gender: gender)
        studentArray.append(student)
        
        table.reloadData()
    }
    
    // 指明每个section中的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return teacherArray.count
        } else {
            return studentArray.count
        }
    }
    
    // 创建cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = sectionTitle[indexPath.section]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            let style : UITableViewCell.CellStyle = (identifier == "Teacher") ? .subtitle : .default
            cell = UITableViewCell.init(style: style, reuseIdentifier: identifier)
        }
        
        switch identifier {
        case "Teacher":
            cell?.textLabel?.text = teacherArray[indexPath.row].fullName
            cell?.detailTextLabel?.text = teacherArray[indexPath.row].description
            cell?.accessoryType = .disclosureIndicator // 为每个cell添加 > 图标
        case "Student":
            cell?.textLabel?.text = studentArray[indexPath.row].fullName
        default:
            break
        }
        
        return cell!
    }
    
    // 修改每个section的头
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // 指明section的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    // 实现删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if indexPath.section == 0 {
                teacherArray.remove(at: indexPath.row)
            } else {
                studentArray.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
    }
    
    // 实现移动
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section {
            tableView.reloadData()
        } else {
            if sourceIndexPath.section == 0 {
                teacherArray.insert(teacherArray.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            } else {
                studentArray.insert(studentArray.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            }
        }
    }
    
    // 实现显示选择
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectTch: Teacher!
        let selectStu: Student!
        let alert: UIAlertController!
        
        if indexPath.section == 0 {
            selectTch = teacherArray[indexPath.row]
            alert = UIAlertController(title: "More Information", message: selectTch.description, preferredStyle: .alert)
        } else {
            selectStu = studentArray[indexPath.row]
            alert = UIAlertController(title: "More Information", message: selectStu.description, preferredStyle: .alert)
        }
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
