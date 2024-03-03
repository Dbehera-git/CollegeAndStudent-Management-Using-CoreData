//
//  ViewController.swift
//  CollegeAndStudentManagemant
//
//  Created by Deepak on 29/02/24.
//

import UIKit

class CollegeListViewController: UIViewController {
    
    @IBOutlet weak var collegeListtblView: UITableView!
    @IBOutlet weak var collegeSearchText: UISearchBar!
    
    var arrCollege = [College]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrCollege = DatabaseHelper.shareInstance.getAllCollegeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrCollege = DatabaseHelper.shareInstance.getAllCollegeData()
        self.collegeListtblView.reloadData()
    }

    @IBAction func btnCollegeAddClick(_ sender: UIBarButtonItem) {
        let collegeForm = self.storyboard?.instantiateViewController(withIdentifier: "CollegeFormViewController") as! CollegeFormViewController
        self.navigationController?.pushViewController(collegeForm, animated: true)
    }
}
extension CollegeListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCollege.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeListViewCell", for: indexPath) as! CollegeListViewCell
        cell.college = arrCollege[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collegeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "CollegeDetailViewController") as! CollegeDetailViewController
        collegeDetailVC.collegeDetail = arrCollege[indexPath.row]
        collegeDetailVC.indexRow = indexPath.row
        self.navigationController?.pushViewController(collegeDetailVC, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrCollege = DatabaseHelper.shareInstance.deleteCollegeData(index: indexPath.row)//Mark:- Delete from coredata and array
            self.collegeListtblView.deleteRows(at: [indexPath], with: .automatic)//Mark:- Delete from tableview
        }
    }
}
extension CollegeListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let col = DatabaseHelper()
        if searchText != "" {
            arrCollege = col.fetchCollegeSearchData(cText: searchText)
            collegeListtblView.reloadData()
        }else {
            arrCollege = col.getAllCollegeData()
            collegeListtblView.reloadData()
        }
    }
}

