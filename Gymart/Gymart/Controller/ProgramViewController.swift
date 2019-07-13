//
//  ProgramViewController.swift
//  Gymart
//
//  Created by William on 16/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import Firebase

class ProgramViewController: UIViewController {
    
    // MARK: - Properties
    var programs = [Program]()
    var db: Firestore!

    // MARK: - IBOutlet
    @IBOutlet weak var programTableView: UITableView!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        programs.removeAll()
        programTableView.reloadData()
        fetchPrograms()
    }
    
    // MAARK: - Methods
    fileprivate func configureTableView() {
        programTableView.delegate = self
        programTableView.dataSource = self
        programTableView.separatorStyle = .none
    }
    
    private func fetchPrograms() {
        db = Firestore.firestore()
        
        guard let currentUser = AuthService.getCurrentUser() else { return }
        
        let userDoc = db.collection("users").document(currentUser.uid)
        
        let programsCollection = userDoc.collection("programs")
        
        programsCollection.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    guard let name = data["name"] as? String else { return }
                    guard let description = data["description"] as? String else { return }
                    let program = Program(name: name, description: description)
                    
                    self.programs.append(program)
                    self.programTableView.reloadData()
                }
            }
            
        }
    }
    
}

// MARK: - Extensions
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
