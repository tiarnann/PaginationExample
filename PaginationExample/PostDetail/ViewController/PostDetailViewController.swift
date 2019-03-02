//
//  PostDetailViewController.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 02/03/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation
import UIKit

protocol PostDetailViewModelProtocol {
    var post: PostProtocol { get }
}

class PostDetailViewController: UIViewController {
    private let viewModel: PostDetailViewModelProtocol
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    init(viewModel: PostDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.viewModel.post.title
        self.bodyLabel.text = self.viewModel.post.body
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.bodyLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8.0),
            self.bodyLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
            self.bodyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8.0),
            self.bodyLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8.0)
        ])
    }
}
