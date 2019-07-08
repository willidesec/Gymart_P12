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
        
//        let program1 = Program(name: "Full Body", description: "December 2018")
//        let program2 = Program(name: "Half Body", description: "May 2019")
//
//        programs = [program1, program2]
        fetchPrograms()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPrograms()
    }
    
    // MARK: - Actions
    @IBAction func addItemDidTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // MAARK: - Methods
    fileprivate func configureTableView() {
        programTableView.delegate = self
        programTableView.dataSource = self
        programTableView.separatorStyle = .none
    }
    
    private func getCurrentUser() -> User? {
        let currentUser = Auth.auth().currentUser
        
        if let currentUser = currentUser {
            return currentUser
        } else {
            return nil
        }
    }
    
    private func fetchPrograms() {
        db = Firestore.firestore()
        
        guard let currentUser = getCurrentUser() else { return }
        
        let usersCollection = db.collection("users")
        
        let userDoc = usersCollection.document(currentUser.uid)
        
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
