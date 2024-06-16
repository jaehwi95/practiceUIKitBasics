//
//  ItemTwoViewController.swift
//  StudyNotificationCenter
//
//  Created by Jaehwi Kim on 2023/12/22.
//

import UIKit

class ItemTwoViewController: UIViewController {
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setReceivedMessage(_:)),
            name: Notification.Name("Message"),
            object: nil
        )
    }
    
    @objc func setReceivedMessage(_ notification: NSNotification) {
        let receivedMessage: String = (notification.userInfo?["message"] as? String) ?? ""
        message.text = receivedMessage
    }
}
