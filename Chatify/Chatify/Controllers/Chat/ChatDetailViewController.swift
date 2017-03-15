//
//  ChatDetailViewController.swift
//  Chatify
//
//  Created by Marcel Canhisares on 14/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class ChatDetailViewController: AdjustableKeyboardViewController, UITableViewDelegate, AdjustableKeyboardProtocol {

    var selectedUser: User?
    
    private var firstLoad: Bool = true
    
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
        ChatService.sharedInstance.messages = []
    }
    
    
    @IBAction func sendButtonTouchUpInside(_ sender: Any) {
        guard let message = inputTextField.text, message.characters.count > 0 else {
            return
        }
        
        sendMessage(text: message)
        
        self.inputTextField.text = ""
    }
    
    func setupTableView() {
        self.title = selectedUser!.userName.uppercased()
        tableView.estimatedRowHeight = 88.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func getMessages() {
        ChatService.sharedInstance.fillMessages(uid: FirebaseService.sharedInstance.currentUser!.uid, toId: selectedUser!.uid) { result in
            self.tableView.reloadData()
            self.tableViewScrollToBottom(animated: !self.firstLoad)
            self.firstLoad = false
        }
    }
    
    func sendMessage(text: String) {
        ChatService.sharedInstance.addMessage(text: text, toId: selectedUser!.uid)
    }
    
    override func addObservers() {
        super.addObservers()
        NotificationCenter.default.addObserver(self, selector: #selector(self.scrollToBottom), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
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

extension ChatDetailViewController: UITableViewDataSource {
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ChatService.sharedInstance.messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatDetailCellIdentifier, for: indexPath) as! ChatDetailTableViewCell
        
        cell.display(message: ChatService.sharedInstance.messages[indexPath.row])
        
        cell.messageText!.delegate = self
        cellHeight = Int(cell.messageText!.contentSize.height)
        
        return cell
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
