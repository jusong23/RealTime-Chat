//
//  ViewController.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Propeties
    let safeArea = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    func setUI() {
        title = "회원가입"
        view.backgroundColor = .systemBackground
        view.addSubview(safeArea)

        safeArea.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
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
    }#endif
