//
//  StudentListViewController.swift
//  CollegeAndStudentManagemant
//
//  Created by Deepak on 01/03/24.
//

import UIKit

class StudentListViewController: UIViewController {
    
    @IBOutlet weak var studentTblView: UITableView!
    
    @IBOutlet weak var studentSearchText: UISearchBar!
    
   var studentArr = [Student]()
    var college: College?
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTblView.register(UITableViewCell.self,forCellReuseIdentifier: "studentCell")
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        if college?.students?.allObjects != nil {
            studentArr = college?.students?.allObjects as! [Student]
        }
       // studentArr = DatabaseHelper.shareInstance.getAllStudentData()
        self.studentTblView.reloadData()
    }
    

    @IBAction func btnAddStudentClick(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let studentFormVC = storyboard.instantiateViewController(withIdentifier: "StudentFormViewController") as! StudentFormViewController
        studentFormVC.college = college
        self.navigationController?.pushViewController(studentFormVC, animated: true)
    }
    
}

extension StudentListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        if cell != nil {
            cell = UITableViewCell(style: .value2, reuseIdentifier: "studentCell")
        }
        cell.textLabel?.text = studentArr[indexPath.row].name
        cell.detailTextLabel?.text = studentArr[indexPath.row].phone
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
extension StudentListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         let std = DatabaseHelper()
        if searchText != "" {
            studentArr = std.fetchStudentSearchData(sText: searchText)
            studentTblView.reloadData()
        }else {
            studentArr = std.getAllStudentData()
            studentTblView.reloadData()
        }
    }
}
