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
    private var page: PostsPageResult?
    private var fetching = false
    
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
        self.tableView.register(UITableViewCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setTitlePostsCount() {
        self.title = "Posts (\(self.posts.count))"
    }
    
    func fetch() {
        guard !self.fetching else {
            return
        }
        
        self.viewModel.getPosts(page: self.page) { [weak self] result in
            guard let `self` = self else { return }
            result.map({ (page) -> Void in
                self.page = page
                self.posts.append(contentsOf: page.posts) // this is bad
                DispatchQueue.main.async {
                    self.fetching = false
                    self.setTitlePostsCount()
                    self.tableView.reloadData()
                }
            }).catchError({ (error) in
                // show error in some way
            })
        }
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
    enum PostsTableViewSections: Int {
        case posts
        case loading
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == PostsTableViewSections.posts.rawValue else {
            self.fetch()
            return tableView.dequeueResusableCell(for: indexPath) as UITableViewCell
        }
        
        let row = indexPath.row
        
        assert(row < self.posts.count)
        let model = self.posts[row]
        
        let cell: PostsTableViewCell  = tableView.dequeueResusableCell(for: indexPath)
        cell.titleLabel.text = model.title
        cell.bodyLabel.text = model.body
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == PostsTableViewSections.posts.rawValue else {
            return 1
        }
        
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
