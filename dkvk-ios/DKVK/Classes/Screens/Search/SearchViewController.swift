//
//  SearchViewController.swift
//  DKVK
//
//  Created by Ilya Udovenko on 19/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var isSearchActive: Bool = false
    private var users: [DKUser] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var filteredUsers: [DKUser] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegating()
        UserManager.shared.loadingUsers { [weak self] users in
            guard let strongSelf = self else { return }
            strongSelf.users = users
        }
    }
    
    private func delegating() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let currentUser = UserManager.shared.currentUser else {
            return
        }
        
        let user = isSearchActive ? filteredUsers[indexPath.row] : users[indexPath.row]
        let chat = Chat.init(id: UUID().uuidString, users: [currentUser, user])
        ChatManager.shared.startChatIfNeeded(chat: chat) {
            self.showAlert(with: "Готово", and: "Чат создан!")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredUsers.count : users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = isSearchActive ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.textLabel?.text = user.email ?? user.id
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = searchText.count > 0 ? true : false
        filteredUsers = users.filter({ (user) -> Bool in
            return user.email?.contains(searchText) ?? false
        })
    }
}
