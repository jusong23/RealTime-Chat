//
//  ViewController.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    //MARK: - Propeties
    let safeArea = UIView()
    let signUpButton = UIButton()
    let logInButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    @objc func tappedSignUpButton() {
        print(#function)
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }

    @objc func tappedLogInButton() {
        print(#function)
        let logInViewController = LogInViewController()
        self.navigationController?.pushViewController(logInViewController, animated: true)
    }

    func setUI() {
        view.backgroundColor = .systemBackground
        
        title = "Main"

        [signUpButton, logInButton].forEach {
            view.addSubview($0)
        }

        //MARK: signUpButton
        signUpButton.backgroundColor = .black
        signUpButton.tintColor = .white
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(logInButton.snp.bottom).inset(60)
            make.centerX.equalTo(self.view.snp.centerX)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(30)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(30)
        }

        //MARK: logInButton
        logInButton.backgroundColor = .black
        logInButton.tintColor = .white
        logInButton.setTitle("Log In", for: .normal)
        logInButton.addTarget(self, action: #selector(tappedLogInButton), for: .touchUpInside)
        logInButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(60)
            make.centerX.equalTo(self.view.snp.centerX)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(30)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(30)
        }
    }
}

#if DEBUG
    import SwiftUI

    struct ViewController_Representable: UIViewControllerRepresentable {

        func updateUIViewController(_ uiView: UIViewController, context: Context) {
            // leave this empty
        }
        @available(iOS 13.0.0, *)
        func makeUIViewController(context: Context) -> UIViewController {
            ViewController() // ✅
        }
    }
    @available(iOS 13.0, *)
    struct ViewController_Representable_PreviewProvider: PreviewProvider {
        static var previews: some View {
            Group {
                ViewController_Representable()
                    .ignoresSafeArea()
                    .previewDisplayName("ViewController") // ✅
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro")) // ✅
            }

        }
    }
#endif

