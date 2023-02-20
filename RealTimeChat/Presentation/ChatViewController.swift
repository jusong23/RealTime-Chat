//
//  ChatViewController.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit

class ChatViewController: UIViewController {

    var messages: [Message] = []
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setNavigationBar()
        setUI()

    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setUI() {
        view.backgroundColor = .systemBackground
        title = "Chat"

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setNavigationBar() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(tappedBackButton))
        self.navigationItem.leftBarButtonItem = leftButton
    }

    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
        return 5
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        
        
        return cell
    }


}
