//
//  LogInViewController.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit
import SnapKit
import FirebaseAuth

class LogInViewController: UIViewController {

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let logInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    //MARK: Log In
    @objc func tappedLoginInButton() {

        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.logInFail(error: error.localizedDescription)
            } else {
                let chatViewController = ChatViewController()
                self.navigationController?.pushViewController(chatViewController, animated: true)
            }
        }
    }
    
    func logInFail(error: String) {
        let complete = UIAlertController(title: "로그인 실패", message: error, preferredStyle: .alert)

        let action = UIAlertAction(title: "확인", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print(self.emailTextField.text!)
            print(self.passwordTextField.text!)
        })
        complete.addAction(action)
        self.present(complete, animated: true, completion: nil)
    }
    
    func setUI() {
        view.backgroundColor = .systemBackground
        title = "Sign Up"
        
        [emailTextField, passwordTextField, logInButton].forEach {
            view.addSubview($0)
        }

        //MARK: emailTextField
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(30)
            make.centerX.equalTo(self.view.snp.centerX)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(30)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(30)
        }

        //MARK: passwordTextField
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.centerX.equalTo(self.view.snp.centerX)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(30)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(30)
        }
        
        //MARK: logInButton
        logInButton.backgroundColor = .black
        logInButton.tintColor = .white
        logInButton.setTitle("Log In", for: .normal)
        logInButton.addTarget(self, action: #selector(tappedLoginInButton), for: .touchUpInside)
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.centerX.equalTo(self.view.snp.centerX)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(30)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(30)
        }
    }

}

#if DEBUG
    import SwiftUI
    struct LogInViewController_Representable: UIViewControllerRepresentable {

        func updateUIViewController(_ uiView: UIViewController, context: Context) {
            // leave this empty
        }
        @available(iOS 13.0.0, *)
        func makeUIViewController(context: Context) -> UIViewController {
            LogInViewController() // ✅
        }
    }
    @available(iOS 13.0, *)
    struct LogInViewController_Representable_PreviewProvider: PreviewProvider {
        static var previews: some View {
            Group {
                LogInViewController_Representable()
                    .ignoresSafeArea()
                    .previewDisplayName("LogInViewController") // ✅
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro")) // ✅
            }

        }
    }#endif
