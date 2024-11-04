//
//  CustomerTableViewCell.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var carTableView: UITableView!
    @IBOutlet weak var carTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var editBtn: UIButton!
    
    var car: [Car] = []
    var isExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.carTableView.dataSource = self
        self.carTableView.delegate = self
        
        self.carTableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarTableViewCell")
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CustomerTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return car.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        cell.selectionStyle = .none
        cell.carNumberLb.text = car[indexPath.row].carNumber
        cell.carTypeLb.text = car[indexPath.row].carType
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
