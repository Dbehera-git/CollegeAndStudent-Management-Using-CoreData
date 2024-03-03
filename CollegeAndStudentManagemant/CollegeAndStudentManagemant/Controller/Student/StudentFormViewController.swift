//
//  StudentFormViewController.swift
//  CollegeAndStudentManagemant
//
//  Created by Deepak on 01/03/24.
//

import UIKit

class StudentFormViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    var college: College?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Enter Students Detail"
    }
   
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        guard let name = txtName.text else {return}
        guard let email = txtEmail.text else {return}
        guard let phone = txtPhone.text else {return}
        guard let mainCollege = college else {
            return
        }
        let studentDict = [
            "studentName" : name,
            "studentEmail" : email,
            "studentPhone" : phone
         ]
        DatabaseHelper.shareInstance.saveStudentData(studentDict: studentDict, college: mainCollege)
    }
    
}

