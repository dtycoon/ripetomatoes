//
//  MovieCell.swift
//  ripetomatoes
//
//  Created by Deepak Agarwal on 9/14/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit


class MovieCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
