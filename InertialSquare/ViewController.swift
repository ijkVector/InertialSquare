//
//  ViewController.swift
//  InertialSquare
//
//  Created by Иван Дроботов on 18.02.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private let rectangleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        addAnimationGester()
        
    }
    
    private func style() {
        rectangleView.layer.cornerRadius = 8
        rectangleView.backgroundColor = .systemBlue
    }
    
    private func layout() {
        view.addSubview(rectangleView)
        rectangleView.center = view.center
    }
    
    private func addAnimationGester() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGesture)
        
        let collision = UICollisionBehavior(items: [rectangleView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let behavior = UISnapBehavior(item: rectangleView, snapTo: rectangleView.center)
        behavior.damping = 0.6
        animator.addBehavior(behavior)
    }
    
    @objc private func tapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        
        if let behavior = animator.behaviors.first(where: { $0 is UISnapBehavior })   {
            animator.removeBehavior(behavior)
            
            let behavior = UISnapBehavior(item: rectangleView, snapTo: location)
            behavior.damping = 0.6
            animator.addBehavior(behavior)
        }
    }
}

