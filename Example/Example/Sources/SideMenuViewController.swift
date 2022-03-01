//
//  SideMenuViewController.swift
//  Example
//
//  Created by 홍경표 on 2022/02/28.
//

import UIKit

import POViewController

final class SideMenuViewController: POViewController {
    
    private let randomWidth: Int = Int.random(in: 100...300)
    
    init() {
        super.init(
            direction: .right,
            viewSize: .init(
                width: .fit,
                height: .full
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
        view.backgroundColor = .systemBackground
        
        let barView = UILabel()
        barView.backgroundColor = .systemOrange
        barView.font = .systemFont(ofSize: 30, weight: .bold)
        barView.adjustsFontSizeToFitWidth = true
        barView.textAlignment = .center
        barView.textColor = .white
        barView.text = "<-\(randomWidth)->"
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        titleLabel.text = "random width"
        
        view.addSubview(barView)
        view.addSubview(titleLabel)
        barView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            barView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            barView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            barView.widthAnchor.constraint(equalToConstant: CGFloat(randomWidth)),
            barView.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: barView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
}
