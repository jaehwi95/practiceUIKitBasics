//
//  ItemOneViewController.swift
//  StudyNotificationCenter
//
//  Created by Jaehwi Kim on 2023/12/22.
//

import UIKit

class ItemOneViewController: UIViewController {
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var inputMessage: UILabel!
    
    @IBAction func sendMessage(_ sender: UIButton) {
        // Object에는 어떤것도 들어갈 수 있음
        NotificationCenter.default.post(
            name: Notification.Name("Message"),
            object: nil,
            userInfo: [
                "message": inputMessage.text ?? ""
            ]
        )
        print("message: \(inputMessage.text ?? "") posted!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
