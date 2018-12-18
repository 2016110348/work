import Foundation
print("一：")
var arrayTest : [Int] = [Int]()
var isPreimNum = true//判断是否是素数

for item in 2...10000 {//遍历从1到200 中的任意数字
    
    for j in 2..<item { //判断 item是否是素数
        if item % j == 0 {
            isPreimNum = false
            break
        }
    }
    if isPreimNum {
        arrayTest.append(item)
    }
    isPreimNum = true
}
print(arrayTest)
//方法一
arrayTest.sort(by: {(num1, num2) in
    return num1 > num2
})
print("第一次降序输出:")
print(arrayTest)
//方法二
arrayTest.sort(by: {
    return $0 > $1
})
print("第二次降序输出:")
print(arrayTest)
//方法三
arrayTest.sort(by: {
    $0 > $1
})
print("第三次降序输出:")
print(arrayTest)
//方法四
arrayTest.sort(){
    $0 > $1
}
print("第四次降序输出:")
print(arrayTest)
//方法五
func test(num1: Int, num2: Int) -> Bool {
    return num1 > num2
}
arrayTest.sort(by: test)
print("第五次降序输出:")
print(arrayTest)

print("***************************************")
print("二：")
//性别的枚举类型
enum Gender:String {
    case male
    case female
}
//重载>操作符
func >(lhs: Gender, rhs: Gender) -> Bool {
        return lhs.rawValue < rhs.rawValue
 }
class Person :CustomStringConvertible{
    var firstName : String
    var lastName : String
    var age : Int = 0
    var gender : Gender
    var fullName : String {
        get {
            return firstName+"."+lastName         }
        set (newFullName){
            var name = newFullName.components(separatedBy: ".")
            firstName = name[0]
            lastName = name[1]
        }
    }
    
    init(firstName:String, lastName:String, age:Int,gender:Gender){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    
    convenience init(){
        self.init(firstName:"jiang",lastName:"yang",age:18,gender:Gender.male)
    }
    
    static func == (a:Person,b:Person)->Bool{
        if(a.firstName == b.firstName&&a.lastName == b.lastName){
            return true
        }else{
            return false
        }
    }
    
    var description:String {
        return "firstName=\(firstName),lastName=\(lastName),age=\(age),gender=\(gender)"
    }
}
class Teacher:Person {
    var title : String
    init(firstName:String,lastName:String,age:Int,title:String,gender:Gender){
        self.title = title
        super.init(firstName:firstName,lastName:lastName,age:age,gender:gender)
    }
    override var description:String{
        return "firstName=\(firstName),lastName=\(lastName),age=\(age),gender=\(gender),title=\(title)"
    }
}
class Student:Person {
    var stuNo : Int
    init(firstName:String,lastName:String,age:Int,stuNo:Int,gender:Gender){
        self.stuNo = stuNo
        super.init(firstName:firstName,lastName:lastName,age:age,gender:gender)
    }
    override var description:String{
        return "firstName=\(firstName),lastName=\(lastName),age=\(age),gender=\(gender),stuNo=\(stuNo)"
    }
}
let person1 = Person(firstName:"jun",lastName:"zhang",age:11,gender: Gender.male)
let person2 = Person(firstName:"zhengyu",lastName:"zhang",age:11,gender: Gender.male)
let person3 = Person(firstName:"jun",lastName:"zhang",age:12,gender: Gender.male)
print("person1的信息：")
print(person1)
print("person1与person2比较结果：")
if(person1 == person3){
    print("相等")
}else{
    print("不相等")
}

let teacher1 = Teacher(firstName:"jun",lastName:"zhang",age:11,title:"student", gender:Gender.male)
let teacher2 = Teacher(firstName: "zhengyu", lastName: "zhang", age: 13, title: "student",gender:Gender.male)
let student1 = Student(firstName:"jun",lastName:"zhang",age:11,stuNo:2016110352,gender:Gender.male)
let student2 = Student(firstName: "zhengyu", lastName: "zhang", age: 13, stuNo: 2016110353,gender:Gender.male)
print("测试用例输出：")
print(student1)
print(teacher1)

var personArr = [person1,person2,person3]
var teacherArr = [teacher1,teacher2]
var studentArr = [student1,student2]

var occupation = ["personCount":personArr.count,"teacherCount":studentArr.count,"studentCount":studentArr.count]
print("输出字典中personCount键对应的对象个数：")
print(occupation["personCount"]!)

print("年龄排序结果：")
personArr.sort { return $0.age > $1.age}
print(personArr)

print("姓名排序结果：")
personArr.sort{ return $0.fullName > $1.fullName }
print(personArr)

print("gender+age排序结果：")
personArr.sort{ return ($0.gender > $1.gender) && ($0.age > $1.age) }
print(personArr)
