//
//  CollegeListViewCell.swift
//  CollegeAndStudentManagemant
//
//  Created by Deepak on 29/02/24.
//

import UIKit

class CollegeListViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCollegeName: UILabel!
    @IBOutlet weak var lblCollegeCity: UILabel!
    @IBOutlet weak var lblCollegeUniversity: UILabel!
    
    var college: College?{
        didSet {
            lblCollegeName.text = "Name: \(college?.name ?? "")"
            lblCollegeCity.text = "City: \(college?.city ?? "")"
            lblCollegeUniversity.text = "University: \(college?.university ?? "")"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
