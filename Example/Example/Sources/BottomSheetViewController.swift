//
//  BottomSheetViewController.swift
//  Example
//
//  Created by 홍경표 on 2022/02/06.
//

import UIKit

import POViewController

final class BottomSheetViewController: POViewController {
    
    init() {
        super.init(
            direction: .bottom,
            viewSize: .init(
                width: .full,
                height: .absolute(300)
            ),
            isSwipeEnabled: true
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
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 10
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        (0..<10).forEach { i in
            let label = UILabel()
            label.text = "Label No.\(i)"
            label.textColor = .white
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .bold)
            stackView.addArrangedSubview(label)
        }
        
        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
}
