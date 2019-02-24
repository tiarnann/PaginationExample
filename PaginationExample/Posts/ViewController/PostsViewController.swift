//
//  PostsViewController.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation
import UIKit

class PostsViewController: UIViewController {
    private let viewModel: PostsViewModelProtocol
    private var posts: [PostProtocol] = []
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .infinite, style: .plain)
        view.alwaysBounceVertical = true
        view.separatorStyle = .none
        return view
    }()
    
    init(viewModel: PostsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(PostsTableViewCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.getPosts { [weak self] (posts) in
            if let posts = posts {
                self?.posts = posts
                DispatchQueue.main.async {
                    self?.setTitlePosts(number: posts.count)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func setTitlePosts(number: Int) {
        self.title = "Posts (\(number))"
    }
    
    override func loadView() {
        self.title = "Posts"
        self.view = UIView()
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        assert(row < self.posts.count)
        let model = self.posts[row]
        
        let cell: PostsTableViewCell  = tableView.dequeueResusableCell(for: indexPath)
        cell.titleLabel.text = model.title
        cell.bodyLabel.text = model.body
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
