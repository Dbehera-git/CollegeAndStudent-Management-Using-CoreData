//
//  CollegeFormViewController.swift
//  CollegeAndStudentManagemant
//
//  Created by Deepak on 29/02/24.
//

import UIKit

class CollegeFormViewController: UIViewController {
    //Mark:-Outlets
    @IBOutlet weak var txtCollegeName: UITextField!
    @IBOutlet weak var txtCollegeAddress: UITextField!
    @IBOutlet weak var txtCollegeCity: UITextField!
    @IBOutlet weak var txtCollegeUniversity: UITextField!
    
    
    @IBOutlet weak var btnSave: UIButton!
    
    var isUpadate = false
    var indexRow = Int()
    var collegeDetails: College?
    
 //Mark:- Viewlifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Update College Detail"
        self.txtCollegeName.text = collegeDetails?.name
        self.txtCollegeCity.text = collegeDetails?.city
        self.txtCollegeAddress.text = collegeDetails?.address
        self.txtCollegeUniversity.text = collegeDetails?.university
    }
    override func viewWillAppear(_ animated: Bool) {
        if isUpadate {
            btnSave.setTitle("Update", for: .normal)
        }else {
            btnSave.setTitle("Save", for: .normal)
        }
    }
    

}
//Mark:- Actions
extension CollegeFormViewController {
    @IBAction func btnCollegeSaveClick(_ sender: UIButton) {
        self.collegeSaveData()
        self.navigationController?.popViewController(animated: true)
        
    }
}
//Mark:- Methods
extension CollegeFormViewController {
    func collegeSaveData(){
        guard let collegeName = txtCollegeName.text else {return}
        guard let collegeAddress = txtCollegeAddress.text else {return}
        guard let collegeCity = txtCollegeCity.text else {return}
        guard let collegeUniversity = txtCollegeUniversity.text else {return}
        
        let collegeDict = [
            "collegeName": collegeName,
            "collegeAddress": collegeAddress,
            "collegeCity": collegeCity,
            "collegeUniversity": collegeUniversity
        ]
        if isUpadate {
            DatabaseHelper.shareInstance.editCollegeData(collegeDict: collegeDict, index: indexRow)
            isUpadate = false
        }else {
            DatabaseHelper.shareInstance.saveCollegeData(collegeDict: collegeDict)
        }
      
    }
}
