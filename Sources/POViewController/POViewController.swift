//
//  PartialViewController.swift
//  
//
//  Created by 홍경표 on 2021/11/16.
//

import UIKit

open class POViewController: UIViewController {
    
    private let direction: POPresentationController.Position
    private let viewSize: POPresentationController.SizePair
    private let isSwipeEnabled: Bool
    
    public init(
        direction: POPresentationController.Position,
        viewSize: POPresentationController.SizePair,
        isSwipeEnabled: Bool = true
    ) {
        self.direction = direction
        self.viewSize = viewSize
        self.isSwipeEnabled = isSwipeEnabled
        
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = self
        
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension POViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        return POPresentationController(
            direction: direction,
            viewSize: viewSize,
            isSwipeEnabled: isSwipeEnabled,
            presentedViewController: presented,
            presenting: presenting
        )
    }
}
