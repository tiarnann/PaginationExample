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
        self.nextPage()
    }
    
    func setTitlePostsCount() {
        self.title = "Posts (\(self.viewModel.posts.count))"
    }
    
    func nextPage() {
        self.viewModel.nextPage(callback: { [weak self] error in
            guard let `self` = self else { return }
            if let _ = error {
                // show error
                return
            }
            
            DispatchQueue.main.async {
                self.setTitlePostsCount()
                self.tableView.reloadData()
            }
        })
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

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        
        guard selectedIndex < self.viewModel.posts.count else {
            // record error
            return
        }
        
        let post = self.viewModel.posts[selectedIndex]
        self.viewModel.didSelectPost(viewController: self, post: post)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.posts.count - 1) {
            self.nextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        assert(row < self.viewModel.posts.count)
        let model = self.viewModel.posts[row]
        
        let cell: PostsTableViewCell  = tableView.dequeueResusableCell(for: indexPath)
        cell.titleLabel.text = model.title
        cell.bodyLabel.text = model.body
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
