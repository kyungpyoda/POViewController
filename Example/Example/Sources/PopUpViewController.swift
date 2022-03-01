//
//  PopUpViewController.swift
//  Example
//
//  Created by 홍경표 on 2022/02/06.
//

import UIKit

import POViewController

final class PopUpViewController: POViewController {
    
    private let randomText = (0..<(Int.random(in: 1...10))).reduce("\"Fit to dynamic height\"\n", { $0 + "\nline \($1)" })
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(
            direction: .center,
            viewSize: .init(
                width: .absolute(200),
                height: .fit
            ),
            isSwipeEnabled: false
        )
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 15
        
        let emojiLabel = UILabel()
        emojiLabel.font = .systemFont(ofSize: 50)
        emojiLabel.textAlignment = .center
        emojiLabel.text = "🦦"
        
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 16)
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.text = randomText
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.addArrangedSubview(emojiLabel)
        stackView.addArrangedSubview(textLabel)
        
        view.addSubview(stackView)
        view.addSubview(closeButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
}
