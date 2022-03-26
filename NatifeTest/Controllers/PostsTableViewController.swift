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
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    // MARK: - Constants
    private let cellId = "postCell"
    private let segueId = "previewToFullPost"
    private let postsService = PostsService()
    private let dateService = DateService()
    
    // MARK: - Variables
    private var posts = [PreviewPost]()
    private var expandedPostsIds = [Int]()
    private var fullPostForSegue: FullPost?
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchPosts()
    }
    
    // MARK: - Actions
    @IBAction func sortBarButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = createSortingActionSheet()
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Utility
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchPosts() {
        postsService.fetchPosts { [weak self] posts in
            if let posts = posts {
                self?.posts = posts.posts
                
                self?.tableView.reloadData()
            }
        }
    }
    
    private func getSelectedPostId() -> Int? {
        if let indexPath = tableView.indexPathForSelectedRow {
            let postPreview = posts[indexPath.row]
            return postPreview.postId
        }
        return nil
    }
    
    private func createErrorAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        return alert
    }
    
    // MARK: - TableView reload functions
    private func reloadTableViewData() {
        tableView.reloadSections(IndexSet([0]), with: .automatic)
    }
    
    private func reloadTableViewRow(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK: - Sorting
    private func createSortingActionSheet() -> UIAlertController {
        let alertController = UIAlertController(title: "Сортировка:", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let likesSortAction = UIAlertAction(title: "Самые популярные", style: .default) { action in
            self.sortPostsByLikes()
            self.sortButton.title = "Сорт. по популярным"
            self.reloadTableViewData()
        }
        let dateSortAction = UIAlertAction(title: "Самые недавние", style: .default) { action in
            self.sortByNew()
            self.sortButton.title = "Сорт. по недавним"
            self.reloadTableViewData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(likesSortAction)
        alertController.addAction(dateSortAction)
        
        return alertController
    }
    
    private func sortPostsByLikes() {
        posts.sort { $0.likesCount > $1.likesCount }
    }
    
    private func sortByNew() {
        posts.sort { $0.timeshamp > $1.timeshamp }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FullPostViewController {
            if let fullPost = fullPostForSegue {
                vc.post = fullPost
            }
        }
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PostTableViewCell else {return UITableViewCell()}
        
        let post = posts[indexPath.row]
        
        if expandedPostsIds.contains(post.postId) {
            cell.expandSummaryAndHideButton()
        } else {
            cell.collapseSummaryAndShowButton()
        }
        
        cell.titleLabel.text = post.title
        cell.previewTextLabel.text = post.previewText
        cell.likesLabel.text = "\(post.likesCount)"
        
        let diff = dateService.getDifferenceBetween(unixEpoch: post.timeshamp, and: Date())
        if let diffString = dateService.getDateStringFrom(timeInterval: diff) {
            cell.timeLabel.text = "\(diffString) назад"
        } else {
            cell.timeLabel.text = ""
        }
        
        cell.tableView = tableView
        cell.postId = post.postId
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = posts[indexPath.row].postId
        loadingView.isHidden = false
        
        postsService.fetchFullPost(with: postId) { fullPost in
            self.loadingView.isHidden = true
            
            if let fullPost = fullPost {
                self.fullPostForSegue = fullPost
                self.performSegue(withIdentifier: self.segueId, sender: self)
            } else {
                let alert = self.createErrorAlert(title: "Ошибка", message: "Не удалось загрузить пост.")
                self.present(alert, animated: true, completion: nil)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PostsTableViewController: CellExpantionDelegate {
    func cellExpanded(_ postId: Int) {
        expandedPostsIds.append(postId)
        
        if let index = posts.firstIndex(where: { $0.postId == postId }) {
            let indexPath = IndexPath(row: index, section: 0)
            reloadTableViewRow(at: indexPath)
        }
    }
}
