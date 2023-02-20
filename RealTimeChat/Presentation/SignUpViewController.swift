//
//  SignUpViewController.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedSignUpButton() {
        alertAction()
    }
    
    func setNavigationBar() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(tappedBackButton))
        self.navigationItem.rightBarButtonItem = leftButton
    }
    
    func alertAction() {
        let complete = UIAlertController(title: "회원가입 완료", message: "가입된 정보로 로그인하세요.", preferredStyle: .alert)

        let action = UIAlertAction(title: "확인", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print(self.emailTextField.text!)
            print(self.passwordTextField.text!)
            self.navigationController?.popViewController(animated: true)
        })
        complete.addAction(action)
        self.present(complete, animated: true, completion: nil)
    }
    
    func setUI() {
        view.backgroundColor = .systemBackground
        title = "Sign Up"
        
        [emailTextField, passwordTextField, signUpButton].forEach {
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
        
        //MARK: signUpButton
        signUpButton.backgroundColor = .black
        signUpButton.tintColor = .white
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.centerX.equalTo(self.view.snp.centerX)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(30)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(30)
        }
    }
    
}

#if DEBUG
    import SwiftUI
    struct SignUpViewController_Representable: UIViewControllerRepresentable {

        func updateUIViewController(_ uiView: UIViewController, context: Context) {
            // leave this empty
        }
        @available(iOS 13.0.0, *)
        func makeUIViewController(context: Context) -> UIViewController {
            SignUpViewController() // ✅
        }
    }
    @available(iOS 13.0, *)
    struct SignUpViewController_Representable_PreviewProvider: PreviewProvider {
        static var previews: some View {
            Group {
                SignUpViewController_Representable()
                    .ignoresSafeArea()
                    .previewDisplayName("SignUpViewController") // ✅
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro")) // ✅
            }

        }
    }#endif
