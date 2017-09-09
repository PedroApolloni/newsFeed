//
//  FeedTableViewCell.swift
//  newsFeedApp
//
//  Created by Pedro  Apolloni on 31/08/17.
//  Copyright © 2017 Pedro  Apolloni. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

  
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var objetivo: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var calorias: UILabel!
    @IBOutlet weak var dataRefeicao: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
