//
//  ChatCell.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit

class ChatCell: UITableViewCell {

    static let identifier = "ChatCell"

    var messageView = UIView()
    var messageLabel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(messageView)
        messageView.addSubview(messageLabel)
        
        messageView.backgroundColor = .lightGray
        messageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        messageLabel.textColor = .black
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }

    }
}
