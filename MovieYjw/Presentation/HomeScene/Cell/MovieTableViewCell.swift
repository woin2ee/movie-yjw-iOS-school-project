//
//  MovieTableViewCell.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/05/25.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var audienceCnt: UILabel!
    @IBOutlet weak var audienceAcc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
