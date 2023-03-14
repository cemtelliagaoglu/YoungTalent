//
//  RegisterVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    
}

class RegisterVC: UIViewController{
    //MARK: - Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var interactor: RegisterBusinessLogic?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    //MARK: - Handlers
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupView(){
        // nameTextField
        nameTextField.delegate = self
        // hideKeyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard(){
        nameTextField.endEditing(true)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        router?.routeToHome()
    }
    
    @IBAction func handleBackButtonPressed(_ sender: UIButton) {
        router?.popVC()
    }
    
}
//MARK: - TextFieldDelegate
extension RegisterVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        nextButtonPressed(nextButton)
        return false
    }
}
//MARK: - DisplayLogic
extension RegisterVC: RegisterDisplayLogic{
    
    
}
