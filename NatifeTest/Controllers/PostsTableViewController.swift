//
//  ViewController.swift
//  NatifeTest
//
//  Created by Mykhailo Petukhov on 25.03.2022.
//

import UIKit

class PostsTableViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Constants
    let cellId = "postCell"
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    @IBAction func sortBarButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Сортировать по", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let likesSortAction = UIAlertAction(title: "Рейтингу", style: .default) { action in
            // func to sort by likes
        }
        let dateSortAction = UIAlertAction(title: "Дате", style: .default) { action in
            // func to sort by date
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(likesSortAction)
        alertController.addAction(dateSortAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate
extension PostsTableViewController: UITableViewDelegate {
}

// MARK: - TableView DataSource
extension PostsTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PostTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
