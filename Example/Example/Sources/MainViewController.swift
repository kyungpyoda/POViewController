//
//  MainViewController.swift
//  Example
//
//  Created by 홍경표 on 2022/02/06.
//

import UIKit

import POViewController

final class MainViewController: UIViewController {
    
    private let showRepositoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("@kyungpyoda/POViewController", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(showRepository), for: .touchUpInside)
        return button
    }()
    private lazy var showBottomSheetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show BottomSheet", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
        return button
    }()
    private lazy var showPopUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show PopUp", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(showPopUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        title = "Example"
        
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .init(systemName: "line.horizontal.3"),
            style: .plain,
            target: self,
            action: #selector(showSideMenu)
        )
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.addArrangedSubview(showRepositoryButton)
        stackView.setCustomSpacing(30, after: showRepositoryButton)
        stackView.addArrangedSubview(showBottomSheetButton)
        stackView.addArrangedSubview(showPopUpButton)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    @objc private func showRepository() {
        guard let url = URL(string: "https://github.com/kyungpyoda/POViewController"),
              UIApplication.shared.canOpenURL(url)
        else {
            fatalError("NO WAY")
        }
        UIApplication.shared.open(url)
    }
    
    @objc private func showSideMenu() {
        let sideMenu = SideMenuViewController()
        present(sideMenu, animated: true, completion: nil)
    }
    
    @objc private func showBottomSheet() {
        let bottomSheet = BottomSheetViewController()
        present(bottomSheet, animated: true, completion: nil)
    }
    
    @objc private func showPopUp() {
        let popUp = PopUpViewController()
        present(popUp, animated: true, completion: nil)
    }
    
}
