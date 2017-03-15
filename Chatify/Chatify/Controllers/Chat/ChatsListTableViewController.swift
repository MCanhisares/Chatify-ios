//
//  ChatsListTableViewController.swift
//  Chatify
//
//  Created by Marcel Canhisares on 14/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class ChatsListTableViewController: UITableViewController {
    
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillUsers()
    }
    
    func fillUsers() {
        ProfileService.sharedInstance.fillUsers {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProfileService.sharedInstance.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatListCellIdentifier, for: indexPath) as! ChatListTableViewCell
        
        cell.configure(user: ProfileService.sharedInstance.users[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedUser = ProfileService.sharedInstance.users[indexPath.row]
        self.performSegue(withIdentifier: kChatListToDetails, sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kChatListToDetails, let destinationViewController = segue.destination as? ChatDetailViewController {
            destinationViewController.selectedUser = self.selectedUser
        }
    }

}
