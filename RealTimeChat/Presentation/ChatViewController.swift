//
//  ChatViewController.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {

    let database = Firestore.firestore()
    var messages: [Message] = []
    let sendMessage = SendMessage()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    let bottomView = UIView()
    let sendTextField = UITextField()
    let sendButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setNavigationBar()
        setUI()
        loadMessages()
        hideKeyboard()
        addKeyboardNotification()

    }

    //MARK: Load
    func loadMessages() {
        database.collection("messages")
            .order(by: "date")
            .addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    snapshotDocuments.forEach { (doc) in
                        let data = doc.data()
                        if let sender = data["sender"] as? String, let body = data["body"] as? String {

                            self.messages.append(Message(sender: sender, body: body))

                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func postMessage(body: String, title: String) {
        // token: ???????????? ??????
        // body, title : ?????? ?????? ?????????
        sendMessage.sendPostRequest(token: "e_LimR9qX0IrmtxXG3jLAg:APA91bFFBvXgxUu1rO8XRegpky2BuHZ3fHRta2qIKRV_VTahnJf_IdrpIpVheJFQtvZzBNB1DU8ei3mWzPzUqVjlPBGhV4ShoqxPiCMnZJUIbFr4d92BlgL33JYrL8-BqPx86_Q8PVML", body: body, title: title)
    }

    //MARK: Send Up
    @objc func tappedSendUpButton() {
        if let messageBody = sendTextField.text, let messageSender = Auth.auth().currentUser?.email {
            database.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody,
                "date": Date().timeIntervalSince1970
                ]) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success save data")
                    DispatchQueue.main.async {
                        //MARK: FCM ??????
                        self.postMessage(body: messageSender, title: messageBody)
                        self.sendTextField.text = ""
                    }

                }
            }
        }
        hideKeyboard()
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]

        if message.sender == Auth.auth().currentUser?.email {
            cell.messageView.backgroundColor = .red
        } else {
            cell.messageView.backgroundColor = .yellow
        }

        cell.messageLabel.text = messages[indexPath.row].body
        return cell
    }
}

extension ChatViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(ChatViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setNavigationBar() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(tappedBackButton))
        self.navigationItem.leftBarButtonItem = leftButton
    }

    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// UI Configure
    func setUI() {
        view.backgroundColor = .systemBackground
        title = "Chat"

        [tableView, bottomView].forEach {
            view.addSubview($0)
        }

        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(120)
        }

        bottomView.backgroundColor = .lightGray
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        [sendTextField, sendButton].forEach {
            bottomView.addSubview($0)
        }
        sendTextField.placeholder = "Send a Message"
        sendTextField.textColor = .black
        sendTextField.borderStyle = .roundedRect
        sendTextField.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(sendButton.snp.leading).inset(-10)
        }

        sendButton.addTarget(self, action: #selector(tappedSendUpButton), for: .touchUpInside)
        sendButton.setImage(UIImage(systemName: "paperplane.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .light)), for: .normal)
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(sendTextField.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}

#if DEBUG
    import SwiftUI
    struct ChatViewController_Representable: UIViewControllerRepresentable {

        func updateUIViewController(_ uiView: UIViewController, context: Context) {
            // leave this empty
        }
        @available(iOS 13.0.0, *)
        func makeUIViewController(context: Context) -> UIViewController {
            ChatViewController() // ???
        }
    }
    @available(iOS 13.0, *)
    struct ChatViewController_Representable_PreviewProvider: PreviewProvider {
        static var previews: some View {
            Group {
                ChatViewController_Representable()
                    .ignoresSafeArea()
                    .previewDisplayName("ChatViewController") // ???
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro")) // ???
            }

        }
    }#endif

/* iPhone X dwoiuaqu7kNjqsGWONwM9C:APA91bGuqUoul7DF4NHPk6yJeWGOzfUTBUDSjf-_enzzcbBfGl6I4g4Iu5bibWjnJ8v0Ikwdn932FEc0a4cvEYwf9SGqvfUjcmolRICad-McrX5XXSyApfKaiY-203Hqr9M5rhYM5Kcy
 */

/* iPhone 11 Pro Max
e_LimR9qX0IrmtxXG3jLAg:APA91bFFBvXgxUu1rO8XRegpky2BuHZ3fHRta2qIKRV_VTahnJf_IdrpIpVheJFQtvZzBNB1DU8ei3mWzPzUqVjlPBGhV4ShoqxPiCMnZJUIbFr4d92BlgL33JYrL8-BqPx86_Q8PVML
*/
