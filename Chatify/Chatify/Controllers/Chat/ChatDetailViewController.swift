//
//  ChatDetailViewController.swift
//  Chatify
//
//  Created by Marcel Canhisares on 14/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class ChatDetailViewController: AdjustableKeyboardViewController, UITableViewDelegate, UITableViewDataSource, AdjustableKeyboardProtocol {

    var selectedUser: User?
    
    var firstLoad: Bool = true
    
    var originalBottomHeight: CGFloat = 8.0
    var cellHeight = 44
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupTableView()
        
        getMessages()
        
        adjustProtocol = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ChatService.Messages = []
    }
    
    func setupTableView() {
        self.title = selectedUser!.userName.uppercased()
        tableView.estimatedRowHeight = 88.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func getMessages() {
        ChatService.FillMessages(uid: FirebaseService.CurrentUser!.uid, toId: selectedUser!.uid) { result in
            self.tableView.reloadData()
            self.tableViewScrollToBottom(animated: !self.firstLoad)
            self.firstLoad = false
        }
    }
    
    func sendMessage(text: String) {
        ChatService.AddMessage(text: text, toId: selectedUser!.uid)
    }
    
    override func addObservers() {
        super.addObservers()
        NotificationCenter.default.addObserver(self, selector: #selector(self.scrollToBottom), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ChatService.Messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatDetailCellIdentifier, for: indexPath) as! ChatDetailTableViewCell
        
        let messageText = cell.messageText!
        messageText.delegate = self
        cellHeight = Int(messageText.contentSize.height)

        let message = ChatService.Messages[indexPath.row]
        
        cell.display(message: message)
        
        return cell
    }
    

    @IBAction func sendButtonTouchUpInside(_ sender: Any) {
        guard let message = inputTextField.text, message.characters.count > 0 else {
            return
        }
        
        sendMessage(text: message)
        
        self.inputTextField.text = ""
    }
    
    func scrollToBottom() {
        tableViewScrollToBottom(animated: true)
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
}

extension ChatDetailViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
}
