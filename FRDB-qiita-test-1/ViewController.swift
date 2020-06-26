//
//  ViewController.swift
//  FRDB-qiita-test-1
//
//  Created by 須藤英隼 on 2020/06/26.
//  Copyright © 2020 Eishun Sudo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameInputView: UITextField!
    @IBOutlet weak var messageInputView: UITextField!
    
    //データ読み込みのための変数宣言
    var databaseRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        下記ではダメか？
//        var databaseRef: DatabaseReference! = Database.database().reference()
        
        databaseRef = Database.database().reference()
        
        databaseRef.observe(.childAdded, with: {
            DataSnapshot in
            if let obj = DataSnapshot.value as? [String: AnyObject], let name = obj["name"] as? String, let message = obj["message"]{
                let currentText = self.textView.text
                self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
            }
        })
        
    }
    
    
    @IBAction func tappedSendButton(_ sender: Any) {
        
        if let name = nameInputView.text, let message = messageInputView.text {
            let messageData = ["name": name, "message": message]
            databaseRef.childByAutoId().setValue(messageData)
            
            messageInputView.text = ""
            
        
    }
    

}

}
