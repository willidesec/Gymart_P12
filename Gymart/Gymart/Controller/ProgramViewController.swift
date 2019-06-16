//
//  ProgramViewController.swift
//  Gymart
//
//  Created by William on 16/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var programTableView: UITableView!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        programTableView.delegate = self
        programTableView.dataSource = self
    }

}

extension ProgramViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}

extension ProgramViewController: UITableViewDelegate {
    
}
