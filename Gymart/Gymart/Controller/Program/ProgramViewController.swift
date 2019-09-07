//
//  ProgramViewController.swift
//  Gymart
//
//  Created by William on 16/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
//import FirebaseFirestore

class ProgramViewController: UIViewController {
    
    // MARK: - Properties
    
    var programs = [Program]()
//    var db: Firestore!
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var programTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        configureFirestoreDataBase()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPrograms()
    }
    
    // MARK: - Methods
    
    fileprivate func configureTableView() {
        programTableView.delegate = self
        programTableView.dataSource = self
        programTableView.separatorStyle = .none
    }
    
//    private func configureFirestoreDataBase() {
//        db = Firestore.firestore()
//        let settings = db.settings
//        settings.areTimestampsInSnapshotsEnabled = true
//        db.settings = settings
//    }
    
    private func fetchPrograms() {
        let firestoreService = FirestoreService()
        firestoreService.fetchPrograms { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                self.programs = querySnapshot!.documents.compactMap({Program(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.programTableView.reloadData()
                }
            }
        }
        
//        guard let currentUser = AuthService.getCurrentUser() else { return }
//
//        let programsCollection = db.collection("users/\(currentUser.uid)/programs")
//
//        programsCollection.order(by: "creationDate", descending: true).getDocuments { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err.localizedDescription)")
//            } else {
//                self.programs = querySnapshot!.documents.compactMap({Program(dictionary: $0.data())})
//                DispatchQueue.main.async {
//                    self.programTableView.reloadData()
//                }
//            }
//        }
    }
    
//    private func deleteProgramInFirestore(identifier: String) {
//        guard let currentUser = AuthService.getCurrentUser() else { return }
//
//        let programsCollection = db.collection("users").document(currentUser.uid).collection("programs")
//
//        programsCollection.document(identifier).delete { error in
//            if let error = error {
//                print("Error removing document: \(error)")
//            } else {
//                print("Document successfully removed!")
//            }
//        }
//    }
    
}

// MARK: - Extensions

extension ProgramViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgramTableViewCell.identifier, for: indexPath) as? ProgramTableViewCell else {
            return UITableViewCell()
        }
        
        cell.program = programs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            deleteProgramInFirestore(identifier: programs[indexPath.row].identifier)
//            programs.remove(at: indexPath.row)
//            programTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Training", bundle: nil)
        guard let workoutsVC = storyBoard.instantiateViewController(withIdentifier: WorkoutViewController.identifier) as? WorkoutViewController else { return }
        workoutsVC.programId = programs[indexPath.row].identifier
        navigationController?.pushViewController(workoutsVC, animated: true)
    }
    
}

extension ProgramViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 80
        return heightRow
    }
}
