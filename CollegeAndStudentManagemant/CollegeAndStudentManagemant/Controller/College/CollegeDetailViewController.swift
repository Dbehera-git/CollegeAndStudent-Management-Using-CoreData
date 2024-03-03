//
//  CollegeDetailViewController.swift
//  CollegeAndStudentManagemant
//
//  Created by Deepak on 29/02/24.
//

import UIKit

class CollegeDetailViewController: UITableViewController {
    
    
    @IBOutlet weak var lblCollegename: UILabel!
    @IBOutlet weak var lblCollegeAddress: UILabel!
    @IBOutlet weak var lblCollegeCity: UILabel!
    @IBOutlet weak var lblCollegeUniversity: UILabel!
    
    @IBOutlet weak var lblStudents: UILabel!
    var collegeDetail: College?
    var indexRow = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblCollegename.text = collegeDetail?.name ?? ""
        lblCollegeCity.text = collegeDetail?.city ?? ""
        lblCollegeUniversity.text = collegeDetail?.university ?? ""
        lblCollegeAddress.text = collegeDetail?.address ?? ""
        if let students = collegeDetail?.students?.allObjects  as? [Student]{
            lblStudents.text = "\(students.count)"
        }else {
            lblStudents.text = "0"
        }
        
    }
    
    
    @IBAction func btnEditClick(_ sender: UIBarButtonItem) {
        let formVC = self.storyboard?.instantiateViewController(withIdentifier: "CollegeFormViewController") as! CollegeFormViewController
        formVC.isUpadate = true
        formVC.collegeDetails = collegeDetail
        formVC.indexRow = indexRow
        self.navigationController?.pushViewController(formVC, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let studentListVC = storyboard.instantiateViewController(withIdentifier: "StudentListViewController") as! StudentListViewController
            studentListVC.college = collegeDetail
            self.navigationController?.pushViewController(studentListVC, animated: true)
        }
    }

}
