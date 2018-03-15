//
//  HomeCell.swift
//  XCWeather
//
//  Created by caijinzhu on 2018/3/15.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    
    
    var person: Person?{
        didSet{
            nameLable.text = person?.name
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
