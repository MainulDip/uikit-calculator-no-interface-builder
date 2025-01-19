//
//  ViewController.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 1/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    var equationViewHeightConstraint = NSLayoutConstraint()
    var preEquationViewHeightConstraint = NSLayoutConstraint()
    var controlsViewHeightConstraint = NSLayoutConstraint()
    // var buttonHoderViewHeightConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
    }
    
    private lazy var equationView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        let isLandscape = self.view.frame.width > self.view.frame.height
        self.equationViewHeightConstraint = view.heightAnchor.constraint(equalToConstant:  self.view.frame.height * 0.15)
        equationViewHeightConstraint.isActive = true
        return view
    }()
    
    private lazy var preEquationView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        self.preEquationViewHeightConstraint =  view.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.1)
        self.preEquationViewHeightConstraint.isActive = true

        return view
    }()
    
    private lazy var controlsView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        self.controlsViewHeightConstraint = view.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.1)
        self.controlsViewHeightConstraint.isActive = true
        return view
    }()
    
    private lazy var buttonHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        let isLandscape = size.width > size.height
        equationViewHeightConstraint.constant = isLandscape ? size.height * 0.24 : size.height * 0.15
        preEquationViewHeightConstraint.constant = isLandscape ? size.height * 0.1 : size.height * 0.1
        controlsViewHeightConstraint.constant = isLandscape ? size.height * 0.1 : size.height * 0.1
        view.layoutIfNeeded()
//        setupLayout()
    }
    
    private func setupLayout() {
        let containerView = UIView()
        view.addSubview(containerView)
        view.backgroundColor = .yellow
        containerView.backgroundColor = .blue
        // containerView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        
        // auto layout impl
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [equationView, preEquationView, controlsView, buttonHolderView])
        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
        stackView.autoresizesSubviews = false
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
    }


}

