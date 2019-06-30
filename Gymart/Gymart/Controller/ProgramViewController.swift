//
//  ProgramViewController.swift
//  Gymart
//
//  Created by William on 16/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {
    
    // MARK: - Properties
    var programs = [Program]()

    // MARK: - IBOutlet
    @IBOutlet weak var programTableView: UITableView!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        programTableView.delegate = self
        programTableView.dataSource = self
        programTableView.separatorStyle = .none
        
        let program1 = Program(name: "Full Body", description: "December 2018")
        let program2 = Program(name: "Half Body", description: "May 2019")
        
        programs = [program1, program2]
    }
    
    // MARK: - Actions
    @IBAction func addItemDidTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
}

extension ProgramViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath) as? ProgramTableViewCell else { return UITableViewCell() }
        
        cell.program = programs[indexPath.row]
        
        return cell
    }
    
    
}

extension ProgramViewController: UITableViewDelegate {
    
}
