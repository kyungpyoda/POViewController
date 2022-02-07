//
//  POPresentationController.swift
//  
//
//  Created by 홍경표 on 2021/11/16.
//

import UIKit

public final class POPresentationController: UIPresentationController {
    
    // MARK: Constants
    
    public enum Position {
        case top
        case bottom
        case left
        case right
        case center
        
        var swipeDirection: UISwipeGestureRecognizer.Direction {
            switch self {
            case .top: return .up
            case .bottom: return .down
            case .left: return .left
            case .right: return .right
            case .center: return .init()
            }
        }
    }
    
    public enum SizeType {
        /// full of screen
        case full
        
        /// fit to contentSize
        case fit
        
        /// specific size
        case absolute(CGFloat)
    }
    
    public struct SizePair {
        let width: SizeType
        let height: SizeType
        
        public init(width: SizeType, height: SizeType) {
            self.width = width
            self.height = height
        }
    }
    
    // MARK: Properties
    
    /// anchor position of presentedView
    private let position: Position
    
    /// size of presentedView
    private let viewSize: SizePair
    
    /// preferredContentSize of presentedView
    private var contentSize: CGSize = .zero
    
    /// enable/disable swipe to dismiss
    private let isSwipeEnabled: Bool
    
    /// tapRecognizer of dimmingView
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapBackground))
    
    /// swipe
    private var swipeRecognizer: UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwiped))
        swipe.direction = position.swipeDirection
        return swipe
    }
    
    private lazy var dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.backgroundColor = .black.withAlphaComponent(0.52)
        dimmingView.alpha = 0
        dimmingView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        dimmingView.addGestureRecognizer(tapRecognizer)
        if isSwipeEnabled {
            dimmingView.addGestureRecognizer(swipeRecognizer)
        }
        return dimmingView
    }()
    
    // MARK: Initialize
    
    init(
        direction: Position,
        viewSize: SizePair,
        isSwipeEnabled: Bool = true,
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        presentedViewController.modalPresentationStyle = .custom
        presentedViewController.modalTransitionStyle = .crossDissolve
        self.position = direction
        self.viewSize = viewSize
        self.isSwipeEnabled = isSwipeEnabled
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    /// present 애니메이션
    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView?.addSubview(dimmingView)
        dimmingView.frame.size = containerView?.bounds.size ?? .zero
        
        // container(UITransitionView) 관련 애니메이션
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.dimmingView.alpha = 1
            
            let transform: CGAffineTransform
            switch self?.position {
            case .top:
                transform = .init(translationX: 0, y: self?.presentedView?.frame.height ?? 0)
            case .bottom:
                transform = .init(translationX: 0, y: -(self?.presentedView?.frame.height ?? 0))
            case .left:
                transform = .init(translationX: (self?.presentedView?.frame.width ?? 0), y: 0)
            case .right:
                transform = .init(translationX: -(self?.presentedView?.frame.width ?? 0), y: 0)
            case .center:
                transform = .identity
            case .none:
                transform = .identity
            }
            self?.presentedView?.transform = transform
        }, completion: nil)
        
        // swipe to dismiss
        if isSwipeEnabled {
            presentedView?.addGestureRecognizer(swipeRecognizer)
        }
    }
    
    /// dismiss 애니메이션
    public override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // container(UITransitionView) 관련 애니메이션
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.dimmingView.alpha = 0
            self?.presentedView?.transform = .identity
            if context.transitionDuration <= 0 {
                self?.dimmingView.removeFromSuperview()
            }
        }, completion: { [weak self] _ in
            self?.dimmingView.removeFromSuperview()
        })
    }
    
    /// presentedView frame 계산
    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView,
              let presentedView = presentedView else { return .zero }
        
        let compressedSize = presentedView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .defaultLow,
            verticalFittingPriority: .defaultLow
        )
        
        var frame = containerView.bounds
        
        switch viewSize.width {
        case .full:
            frame.size.width = frame.width
        case .fit:
            frame.size.width = compressedSize.width
        case .absolute(let value):
            frame.size.width = value
        }
        
        switch viewSize.height {
        case .full:
            frame.size.height = frame.height
        case .fit:
            frame.size.height = compressedSize.height
        case .absolute(let value):
            frame.size.height = value
        }
        
        if case .fit = viewSize.width {
            let temp = CGSize(width: UIView.layoutFittingCompressedSize.width, height: frame.size.height)
            frame.size.width = presentedView.systemLayoutSizeFitting(temp, withHorizontalFittingPriority: .defaultLow, verticalFittingPriority: .required).width
        }
        if case .fit = viewSize.height {
            let temp = CGSize(width: frame.size.width, height: UIView.layoutFittingCompressedSize.height)
            frame.size.height = presentedView.systemLayoutSizeFitting(temp, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow).height
        }
        
        switch position {
        case .top:
            frame.origin.y = 0 - frame.height
            frame.origin.x = (containerView.bounds.width - frame.width) / 2
        case .bottom:
            frame.origin.y = containerView.bounds.height - frame.height + frame.height
            frame.origin.x = (containerView.bounds.width - frame.width) / 2
        case .left:
            frame.origin.x = 0 - frame.width
            frame.origin.y = (containerView.bounds.height - frame.height) / 2
        case .right:
            frame.origin.x = containerView.bounds.width - frame.width + frame.width
            frame.origin.y = (containerView.bounds.height - frame.height) / 2
        case .center:
            frame.origin.x = containerView.center.x - frame.width / 2
            frame.origin.y = containerView.center.y - frame.height / 2
        }
        
        return frame
    }
    
    // tap background to dismiss
    @objc private func onTapBackground() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    // swipe to dismiss
    @objc private func onSwiped() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
