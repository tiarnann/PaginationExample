//
//  PostsTableViewCell.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation
import UIKit

class PostsTableViewCell: UITableViewCell {
    let wrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4.0
        view.layer.masksToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.numberOfLines = 0
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.configureViews()
        self.configureAnimationsRecognisers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func configureViews() {
        self.contentView.backgroundColor = .clear
        self.wrapper.backgroundColor = .red
        self.contentView.addSubview(self.wrapper)
    
        NSLayoutConstraint.activate([
            self.wrapper.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: 10.0
            ),
            self.wrapper.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: 20.0
            ),
            self.wrapper.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -20.0
            ),
            self.wrapper.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -10.0
            )
        ])
            
    

        self.wrapper.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(
                equalTo: self.wrapper.topAnchor,
                constant: 20.0
            ),
            self.titleLabel.leadingAnchor.constraint(
                equalTo: self.wrapper.leadingAnchor,
                constant: 20.0
            ),
            self.titleLabel.trailingAnchor.constraint(
                equalTo: self.wrapper.trailingAnchor,
                constant: -20.0
            ),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        self.wrapper.addSubview(bodyLabel)
        NSLayoutConstraint.activate([
            self.bodyLabel.topAnchor.constraint(
                equalTo: self.titleLabel.bottomAnchor,
                constant: 10.0
            ),
            self.bodyLabel.leadingAnchor.constraint(
                equalTo: self.wrapper.leadingAnchor,
                constant: 20.0
            ),
            self.bodyLabel.trailingAnchor.constraint(
                equalTo: self.wrapper.trailingAnchor,
                constant: -20.0
            ),
            self.bodyLabel.bottomAnchor.constraint(
                equalTo: self.wrapper.bottomAnchor,
                constant: -20.0
            )
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    func configureAnimationsRecognisers() {
        let recogniser = UILongPressGestureRecognizer(
            target: self,
            action: #selector(fingerDownAnimationHandler)
        )
        self.wrapper.addGestureRecognizer(recogniser)
    }
    
    var animatingPressDown = false
    
    @objc func fingerDownAnimationHandler(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.handlePressDownStarted()
        case .ended:
            self.handlePressDownEnded()
        default: break
        }
    }
    
    func handlePressDownStarted() {
        if !animatingPressDown {
            self.animatingPressDown = true
            UIView.animate(
                withDuration: 0.12,
                delay: 0, options: UIViewAnimationOptions.curveEaseOut,
                animations: {
                    self.transform = CGAffineTransform(
                        scaleX: 1.06,
                        y: 1.06
                    )
            },
                completion: nil
            )
        }
    }
    
    func handlePressDownEnded() {
        self.animatingPressDown = false
        UIView.animate(
            withDuration: 0.06,
            delay: 0, options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                self.transform = .identity
            },
            completion: nil
        )
    }
}
