//
//  ChatBubbleTableViewCell.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/15/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class ChatBubbleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var messageBody: UITextView!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var chatStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupMessageContainer()
    }
    
    func setupMessageContainer() {
        messageContainer.layer.cornerRadius = 10
    }
    
    func setMessageData(message: Message) {
        self.senderName.text = message.senderName
        self.messageBody.text = message.messageBody
    }
    
    enum bubbleType {
        case incoming
        case outgoing
    }
    
    func setBubbleType(type: bubbleType) {
        if type == .incoming {
            chatStackView.alignment = .leading
            messageContainer.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            messageBody.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else if type == .outgoing {
            chatStackView.alignment = .trailing
            messageContainer.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            messageBody.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
