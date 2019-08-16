//
//  TrainingTableViewCell.swift
//  Gymart
//
//  Created by William on 15/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class TrainingTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var emptyPreviousView: UIView!
    @IBOutlet weak var previousSetLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var checkedImageView: UIImageView!
    @IBOutlet weak var checkedContainerView: TrainingRegularView!
    @IBOutlet weak var repsContainerView: TrainingRegularView!
    @IBOutlet weak var weightContainerView: TrainingRegularView!
    @IBOutlet weak var setContainerView: TrainingRegularView!
    
    // MARK: - Properties
    
    var isExerciceSetValide = false
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        addTapGestureRecognizer()
    }
    
    // MARK: - Action
    
    @objc func checkedImageDidTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if let weight = weightTextField.text, !weight.isEmpty, let reps = repsTextField.text, !reps.isEmpty {
            isExerciceSetValide ? changeUIForInvalideSet() : changeUIForValideSet()
            pulseAnimation()
        } else {
            changeUIForInvalideSet()
            shakeAnimation()
        }
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        emptyPreviousView.layer.roundedCorner()
        
        checkedImageView.setImageColor(color: UIColor.silver)
    }
    
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkedImageDidTapped(tapGestureRecognizer:)))
        checkedImageView.isUserInteractionEnabled = true
        checkedImageView.addGestureRecognizer(tapGesture)
    }
    
    private func changeUIForValideSet() {
        isExerciceSetValide = true
        checkedContainerView.backgroundColor = UIColor.green
        checkedImageView.setImageColor(color: UIColor.white)
        repsContainerView.backgroundColor = .clear
        weightContainerView.backgroundColor = .clear
        setContainerView.backgroundColor = .clear
        contentView.backgroundColor = UIColor.lightGreen
    }
    
    private func changeUIForInvalideSet() {
        isExerciceSetValide = false
        checkedContainerView.backgroundColor = UIColor.grey
        checkedImageView.setImageColor(color: UIColor.silver)
        repsContainerView.backgroundColor = .grey
        weightContainerView.backgroundColor = .grey
        setContainerView.backgroundColor = .grey
        contentView.backgroundColor = UIColor.clear
    }
    
    private func shakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: checkedContainerView.center.x - 5, y: checkedContainerView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: checkedContainerView.center.x + 5, y: checkedContainerView.center.y))
        
        checkedContainerView.layer.add(animation, forKey: "position")
        Vibration.error.vibrate()
    }
    
    private func pulseAnimation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.checkedContainerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.checkedContainerView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
        Vibration.success.vibrate()
    }
    
}
