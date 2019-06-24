//
//  ProgramTableViewCell.swift
//  Gymart
//
//  Created by William DESECOT on 24/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var program: Program? {
        didSet {
            guard let program = program else { return }
            programNameLabel.text = program.name
            programDescriptionLabel.text = program.description
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var programDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
