//
//  ProgramTableViewCell.swift
//  Gymart
//
//  Created by William DESECOT on 24/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var programDescriptionLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    
    // MARK: - Properties
    
    var program: Program? {
        didSet {
            guard let program = program else { return }
            programNameLabel.text = program.name
            programDescriptionLabel.text = program.description
        }
    }
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        self.selectionStyle = .none
        containerView.layer.roundedCorner(10)
        containerView.layer.borderColor = UIColor.silver.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.clipsToBounds = true
        tagView.layer.roundedCorner(10)
    }
    
    
}
