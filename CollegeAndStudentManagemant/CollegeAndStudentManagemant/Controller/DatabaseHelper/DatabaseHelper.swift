//
//  DatabaseHelper.swift
//  CollegeAndStudentManagemant
//
//  Created by Deepak on 29/02/24.
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {
    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveCollegeData(collegeDict: [String:String]){
        let college = NSEntityDescription.insertNewObject(forEntityName: "College", into: context) as! College
        college.name = collegeDict["collegeName"]
        college.address = collegeDict["collegeAddress"]
        college.city = collegeDict["collegeCity"]
        college.university = collegeDict["collegeUniversity"]
        do{
            try context.save()
        }catch  let err{
            print("college save error:- \(err.localizedDescription)")
        }
    }
    
    func getAllCollegeData() -> [College] {
        var arrCollege = [College]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "College")
        do{
            arrCollege = try context.fetch(fetchRequest) as! [College]
        }catch let err {
            print("Error in college fetch:- \(err.localizedDescription)")
        }
        return arrCollege
    }
    
    func deleteCollegeData(index: Int) -> [College] {
        var collegeData = self.getAllCollegeData()//Mark:- GetData
        context.delete(collegeData[index])//Mark:- Remove from core data
        collegeData.remove(at: index)//Mark:-remove in array college
        do{
            try context.save()
        }catch let err{
            print("delete college data:- \(err.localizedDescription)")
        }
        return collegeData
    }
    func editCollegeData(collegeDict: [String : String] , index: Int) {
        let college = self.getAllCollegeData()
        //Mark:- Original Data    //mark:- Edit Data
        college[index].name = collegeDict["collegeName"]
        college[index].address = collegeDict["collegeAddress"]
        college[index].city = collegeDict["collegeCity"]
        college[index].university = collegeDict["collegeUniversity"]
        do {
            try context.save()
        }catch{
            print("Error in Edit Data")
        }
    }
    func saveStudentData(studentDict : [String : String],college : College) {
        let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        student.name = studentDict["studentName"]
        student.email = studentDict["studentEmail"]
        student.phone = studentDict["studentPhone"]
        student.universities = college
        do{
            try context.save()
        }catch let err {
            print("Student save error:- \(err.localizedDescription)")
        }
    }
    
    func getAllStudentData() -> [Student] {
        var arrStudent = [Student]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do{
            arrStudent = try context.fetch(fetchRequest) as! [Student]
        }catch let err {
            print("Error in Student fetch:- \(err.localizedDescription)")
        }
        return arrStudent
    }
    
    func editStudentData(studentDict: [String : String] , index: Int) {
        let student = self.getAllStudentData()
        //Mark:- Original Data    //mark:- Edit Data
        student[index].name = studentDict["studentName"]
        student[index].email = studentDict["studentEmail"]
        student[index].phone = studentDict["studentPhone"]
        do {
            try context.save()
        }catch{
            print("Error in Edit Data")
        }
    }
    
    func fetchCollegeSearchData(cText: String) -> [College] {
        var arrCollege = [College]()
        let predicate = NSPredicate(format: "name contains %@", cText)
        let request: NSFetchRequest = College.fetchRequest()
        request.predicate = predicate
        do {
            arrCollege = try (context.fetch(request))
        }catch {
            print("Error While Fetching College Data")
        }
        return arrCollege
    }
    
    func fetchStudentSearchData(sText: String) -> [Student] {
        var arrStudent = [Student]()
        let predicate = NSPredicate(format: "name contains %@", sText)
        let request: NSFetchRequest = Student.fetchRequest()
        request.predicate = predicate
        do {
            arrStudent = try (context.fetch(request))
        }catch {
            print("Error While Fetching Student Data")
        }
        return arrStudent
    }
    
}
