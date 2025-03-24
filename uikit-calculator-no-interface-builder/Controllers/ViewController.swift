//
//  ViewController.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 1/18/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    // MARK: - Constants
    private let calcBtnValArr = [
            ["C", "()", "%", "/"],
            ["7", "8", "9", "X"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "+"],
            ["+/-", "0", ".", "="]
        ]
    // add btn color property, ["C", K.btnC.color]
    // TODO: Add operator color to the equation text view
    /*
     - convert the equation text as attributed text and add separate attribute for operators
     */
    
    // MARK: - ViewModel Initialization
    var viewModel = ViewModel()
    var historyTableVC = HistoryTableVC()
    
    // MARK: - Orientaon adjustment props
    var isLandscape: Bool {
        self.view.bounds.width > self.view.bounds.height
    }
    
    var fontSize: CGFloat {
        UIScreen.main.bounds.height > UIScreen.main.bounds.width ? 36 : 24
    }
    
    var currentHStackDistribution: UIStackView.Distribution {
        UIScreen.main.bounds.height > UIScreen.main.bounds.width ? .equalCentering : .fillEqually
    }
    
    var equationViewHeightConstraint = NSLayoutConstraint()
    var preEquationViewHeightConstraint = NSLayoutConstraint()
    var controlsViewHeightConstraint = NSLayoutConstraint()
    // var buttonHoderViewHeightConstraint = NSLayoutConstraint()
    
    
    
    // MARK: - equationView Container Props
    
    private lazy var equationView: (container: UIView, textView: UITextView) = {
        let view = UIView()
        view.backgroundColor = .red
        // let isLandscape = self.view.frame.width > self.view.frame.height
        self.equationViewHeightConstraint = view.heightAnchor.constraint(equalToConstant:  self.view.frame.height * (isLandscape ? 0.24 : 0.15))
        equationViewHeightConstraint.isActive = true
        
        // inner UITextView setup
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .purple
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .right
        textView.textColor = .white
        textView.text = "123,456+301"
        textView.font = .systemFont(ofSize: 40, weight: .bold)
        
        view.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return (view, textView)
    }()
    
    
    // MARK: - preEquationView section
    
    private lazy var preEquationView: (container: UIView, textView: UITextView) = {
        let view = UIView()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.backgroundColor = .lightGray
        self.preEquationViewHeightConstraint =  view.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.10)
        self.preEquationViewHeightConstraint.isActive = true
        
        // inner UITextView setup
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .purple
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .right
        textView.textColor = .lightGray
        textView.text = "123,757"
        textView.font = .systemFont(ofSize: 24, weight: .bold)
        
        view.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return (view, textView)
    }()
    
    
    // MARK: - History View Section
    
    var historyView = UIView()
//    private var historyViewIsOpen: Bool = false
    private lazy var hiddenHistoryViewPositionAnchor = historyView.trailingAnchor.constraint(equalTo: buttonHolderView.leadingAnchor)
    private lazy var revealedHistoryViewPositionAnchor = historyView.leadingAnchor.constraint(equalTo: buttonHolderView.leadingAnchor)
    
    //TODO: Inner tableView Section
    
    
    // MARK: - Control seciton
    // contains all the stored button to controll the calculator feature
    
    private lazy var historyBtn: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "clock"), for: .normal)
        uiButton.tintColor = .white
        uiButton.addTarget(self, action: #selector(animateHistoryViewToggle), for: .touchUpInside)
        return uiButton
    }()
    
    private lazy var rullerBtn: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "ruler"), for: .normal)
        uiButton.tintColor = .white
        // for now add a new row to the tableview
        uiButton.addTarget(self, action: #selector(addTableViewRow), for: .touchUpInside)
        return uiButton
    }()
    
    // use this to toggle orientaiton
    private lazy var cmdBtn: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "command"), for: .normal)
        uiButton.tintColor = .white
         uiButton.addTarget(self, action: #selector(toggleOrientation), for: .touchUpInside)
        return uiButton
    }()
    
    private lazy var deleteLeft: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "delete.left"), for: .normal)
        uiButton.tintColor = .white
         uiButton.addTarget(self, action: #selector(deleteLeftFn), for: .touchUpInside)
        return uiButton
    }()
    
    private lazy var controlsView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        self.controlsViewHeightConstraint = view.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.10)
        self.controlsViewHeightConstraint.isActive = true
        
        
        // add horizontal UIStackView as container
        // place 2 horizontal UIStackView as containers subView
        // add 3 button containing icons to the left
        // add 1 button containing icon to the right
        
        let leftHStackBtnHolder = UIStackView(arrangedSubviews: [historyBtn, rullerBtn, cmdBtn])
        leftHStackBtnHolder.distribution = .equalSpacing
        //        leftHStackBtnHolder.backgroundColor = .orange
        
        let rightHStackBtnHolder = UIStackView(arrangedSubviews: [deleteLeft])
        //        rightHStackBtnHolder.backgroundColor = .black
        rightHStackBtnHolder.alignment = .trailing
        rightHStackBtnHolder.axis = .vertical
        
        let horizontalStackViewContainer = UIStackView(arrangedSubviews: [leftHStackBtnHolder, rightHStackBtnHolder])
        horizontalStackViewContainer.axis = .horizontal
        horizontalStackViewContainer.distribution = .fillEqually
        horizontalStackViewContainer.directionalLayoutMargins = .init(top: 0, leading: 100, bottom: 0, trailing: 100)
        
        view.addSubview(horizontalStackViewContainer
        )
        
        horizontalStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        horizontalStackViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        horizontalStackViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        horizontalStackViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        
        return view
    }()
    
    // MARK: - input button section | numbers and operators
    // contains all the stored calculator buttons for core calculation UI
    
    private var calcBtnCollection : [UIButton] = []
    private var calcBtnAnchorCollection : [(buttonWidthAnchor:NSLayoutConstraint, buttonHeightAnchor: NSLayoutConstraint)] = []
    private var clacBtnHStackCollection : [UIStackView] = []
    
    private lazy var buttonHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        
        // add a vertical UIStackView as container
        // place 5 horizontal UIStackView as containers subView
        // each horizontal one will hold 4 buttons with icons with proper spacing and styling
        let VStackViewContainer = makeColumns()
        
        view.addSubview(VStackViewContainer)
        VStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        VStackViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        VStackViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        VStackViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        VStackViewContainer.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        VStackViewContainer.isLayoutMarginsRelativeArrangement = true
        
        return view
    }()
    
    
    
    
    
    
}

// MARK: - Lifecycle Methods and Orientation Adjustment Section
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        let isLandscape = size.width > size.height
        equationViewHeightConstraint.constant = isLandscape ? size.height * 0.24 : size.height * 0.15
        preEquationViewHeightConstraint.constant = isLandscape ? size.height * 0.1 : size.height * 0.1
        controlsViewHeightConstraint.constant = isLandscape ? size.height * 0.1 : size.height * 0.1
        //        let stack = buttonHolderView.subviews.first as? UIStackView
        //        stack?.arrangedSubviews.map { $0 as? UIStackView }.forEach({ stack in
        //            stack?.arrangedSubviews.map { $0 as? UIButton }.forEach({ button in
        //
        //            })
        //        })
        //        setFonts()
        clacBtnOrientationAdaptor(size)
        view.layoutIfNeeded() // deffered recomposition
    }
    
    private func setFonts() {
        //        [calcBtn0, calcBtn1, calcBtn2, calcBtn3, calcBtn4, calcBtn5, calcBtn6, calcBtn7].forEach { button in
        //            let title = button.title(for: .normal) ?? ""
        //            button.setAttributedTitle(.init(string: title, attributes: [.font: UIFont.systemFont(ofSize: fontSize)]), for: .normal)
        //        }
    }
    
    private func clacBtnOrientationAdaptor(_ size: CGSize) -> Void {
        for btn in calcBtnCollection {
            btn.titleLabel?.font = .systemFont(ofSize: fontSize)
        }
        
        let isLandscape = size.width > size.height
        if isLandscape {
            for calcBtnAnchor in calcBtnAnchorCollection {
                //                calcBtnAnchor.buttonWidthAnchor.isActive = false
                //                calcBtnAnchor.buttonHeightAnchor.isActive = false
            }
            // adjust HStack
            for calcBtnHStack in clacBtnHStackCollection {
                calcBtnHStack.distribution = currentHStackDistribution
                //                calcBtnHStack.spacing = 100
            }
        } else if !isLandscape {
            for calcBtnAnchor in calcBtnAnchorCollection {
                calcBtnAnchor.buttonHeightAnchor.isActive = true
                calcBtnAnchor.buttonWidthAnchor.isActive = true
            }
            for calcBtnHStack in clacBtnHStackCollection {
                calcBtnHStack.distribution = currentHStackDistribution
                //                calcBtnHStack.spacing = 0
            }
        }
    }
}



// MARK: - ViewModel Mutations
extension ViewController {
    private func stateCallBack(_ state: ViewModelState) {
        //look at the new state and update the ui
        
        let equation = state.equation
        equationView.textView.text = equation
    }
    

    
    func renderViewState(vmState: ViewModelState) {
        equationView.textView.text = vmState.equation
        preEquationView.textView.text = vmState.result
        toggleHistoryViewAnimation(historyViewIsOpen: vmState.historyViewIsOpen)
    }
}


// MARK: - Layout Generator | Calcuation Buttons Layout Setup

extension ViewController {
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
        
        let stackView = UIStackView(arrangedSubviews: [equationView.container, preEquationView.container, controlsView, buttonHolderView])
        
        stackView.axis = .vertical
        //        stackView.distribution = .fillProportionally
        stackView.autoresizesSubviews = false
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        // MARK: call historyView Slides into buttonHolder's subview
        setupHistoryView()
        
    }
}

// MARK: Layout Genarator Companions
extension ViewController {
    
    
    private func makeColumns()  -> UIStackView {
        //delete previous vertical stack
        
        //make vertial stack
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 10
        verticalStack.backgroundColor = .orange
        
        for row in calcBtnValArr {
            //make horizontal row stack
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            for buttonTitle in row {
                //create calc button
                let button = UIButtonRound()
                button.setTitle(buttonTitle, for: .normal)
                button.setTitleColor(.orange, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: fontSize)
                button.backgroundColor = .darkGray
                button.addTarget(self, action: #selector(ViewController.didSelectCalcButton(_:)), for: .touchUpInside)
                //add button to row
                horizontalStack.addArrangedSubview(button)
                let btnHeightAnchor = button.heightAnchor.constraint(equalTo: horizontalStack.heightAnchor, constant: 0)
                btnHeightAnchor.priority = UILayoutPriority(rawValue: 999)
                btnHeightAnchor.isActive = !isLandscape
                
                let btnWidthAnchor: NSLayoutConstraint = button.widthAnchor.constraint(equalTo: horizontalStack.heightAnchor, constant: 0)
                btnWidthAnchor.priority = UILayoutPriority(rawValue: 999)
                btnWidthAnchor.isActive = !isLandscape
                calcBtnAnchorCollection.append((buttonWidthAnchor: btnWidthAnchor, buttonHeightAnchor: btnHeightAnchor))
                calcBtnCollection.append(button)
                
                //                button.widthAnchor.constraint(equalTo: horizontalStack.heightAnchor, constant: -16).isActive = true
                //                button.heightAnchor.constraint(equalTo: horizontalStack.heightAnchor, constant: -16).isActive = true
            }
            
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = currentHStackDistribution
            // horizontalStack.distribution = .equalCentering
            // .fillEqually for landscape orientation
            horizontalStack.alignment = .center
            horizontalStack.spacing = 12
            horizontalStack.backgroundColor = .red
            
            // popuate clacBtnHStackCollection to fine tune on orientaiton change
            clacBtnHStackCollection.append(horizontalStack)
            
            //Add row to vertical stack
            verticalStack.addArrangedSubview(horizontalStack)
        }
        return verticalStack
    }
}


// MARK: Implement the Sliding `History` Panel
extension ViewController {
    
    func setupHistoryView () {
        historyView.backgroundColor = .black
        // let viewToRemove = buttonHolderView.subviews[0]
        // viewToRemove.removeFromSuperview()
        buttonHolderView.addSubview(historyView)
        
        // setup autolayout and constraints
        historyView.translatesAutoresizingMaskIntoConstraints = false
        historyView.topAnchor.constraint(equalTo: buttonHolderView.topAnchor ).isActive = true
        historyView.bottomAnchor.constraint(equalTo: buttonHolderView.bottomAnchor).isActive = true
        // historyView.widthAnchor.constraint(equalTo: buttonHolderView.widthAnchor, constant: -view.systemLayoutSizeFitting(buttonHolderView.bounds.size).width * 0.30).isActive = true
        historyView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        
        // hidden and ready to slide
        hiddenHistoryViewPositionAnchor.isActive = true
        
        
        // revealedHistoryViewPositionAnchor.isActive = true
        
        buttonHolderView.bringSubviewToFront(historyView)
        
        // MARK: - HistoryVC inclusion
        addChild(historyTableVC as UIViewController)
        historyView.addSubview(historyTableVC.tableView)
        
        
        // TODO: Add HistoryViewModel to the HistoryVC
    }
}


// MARK: - Button Press Handler | Controls Section
extension ViewController {
    @objc func didSelectCalcButton(_ sender: UIButton) {
        //        viewModel.didSelectButton(type: sender.title(for: .normal) ?? "", callBack : stateCallBack)
        
//        viewModel.didSelectButton(type: sender.title(for: .normal) ?? "", callBack : {
//            let equation = $0.equation
//            self.equationView.textView.text = equation
//        })
        viewModel.didSelectButton(type: sender.title(for: .normal) ?? "", callBack: renderViewState)
    }
    
    // animate the view
    // inside of the view put a table view with history data
    // the scrolling feature should be chat like
    // most recent will be show at the first
    @objc
    func animateHistoryViewToggle() {
        viewModel.didSelectButton(type: "history-btn", callBack: renderViewState)
        // FIXME: is there any better way to scroll to the last?
        historyTableVC.scrollToLast()
        
        // FIXME: Add Staggering animation history cell aninmation
        
//        completion: { [weak self] complete in
//            print("is complete \(complete)")
//            guard let self = self else { return }
//            toggleHistoryViewAnimation()
//        }

        
        // toggleHistoryViewAnimation()
        // historyViewIsOpen.toggle()
    }
    
    // TODO: (Done) Add UITableView inside historyView
    /*
     - each table cell in the history view should contain as model prop
        1. equation and
        2. result
     - the tableview should be `chat` like scroll interface and the most latest equation should come last
     - there should be a staggering/chaing entrance animation
     */
    
    @objc func toggleOrientation() {
//        guard let windowScene = view.window?.windowScene else { return }
//        let isProtrait = windowScene.interfaceOrientation.isPortrait
//        
//        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: isProtrait ? .landscapeRight : .portrait)) { error in
//            print("Some error wihile changing orientation \(error)")
//        }
        
        viewModel.didSelectButton(type: "rotate-btn", callBack: renderViewState)
    }
    
    /*
     * For testing perpose to insert new row into historyview data,
     * implement this into unit conversion view later
     * Ask the Boss, If we need this
     */
    @objc func addTableViewRow() {
        let newRowData: (String, String) = ("NewRow First", "NewRow Last")
        historyTableVC.historyData.append(newRowData)
        historyTableVC.tableView.reloadData()
        historyTableVC.scrollToLast()
    }
    
    // TODO: - Implement the `Left Deletion` of equationview | callback of the `letDelete` button
    /*
     * instead of custom implementation, use system's keyboard logic
     * enable equationView's editable prop but disable `soft keyboard` popup
     * map the `soft` keyboard's delete-left feature into the `leftDelete` callback
     * so no need to implement cursor navigation on tap
     */
    
    @objc func deleteLeftFn() {
        viewModel.didSelectButton(type: "left-delete-btn", callBack: renderViewState)
    }
}

// MARK: - Helpers of all the Button Press Callbacks
extension ViewController {
    func toggleHistoryViewAnimation(historyViewIsOpen: Bool) {
        
        // change the viewmodel state at the last, or do it from the ViewModel It-self
        //historyViewIsOpen.toggle()
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if (historyViewIsOpen) {
                // hide the view
                self.hiddenHistoryViewPositionAnchor.isActive = false
                self.revealedHistoryViewPositionAnchor.isActive = true
            } else {
                self.revealedHistoryViewPositionAnchor.isActive = false
                self.hiddenHistoryViewPositionAnchor.isActive = true
            }
            
            buttonHolderView.layoutSubviews()
        }
    }
}


// TODO: make function names meaningful
// - for button press callback `didSelect<ButtonName>`
// - read some article aboout ios props and method naming convension
