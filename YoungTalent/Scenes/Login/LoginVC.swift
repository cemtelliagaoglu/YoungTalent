//
//  LoginVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func setupView()
}

class LoginVC: UIViewController{
    
    //MARK: - Properties
    @IBOutlet weak var termsAndConditionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.notifyViewDidLoad()
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
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @objc func handleTermsAndConditionTapped(){
        print("Terms And Condition Tapped")
    }
    
    @objc func dismissKeyboard(){
        phoneNumberTextField.resignFirstResponder()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        router?.routeToOTP()
    }
    
    @IBAction func handleBackButtonTapped(_ sender: UIButton) {
        router?.popVC()
    }
    
}
//MARK: - TextFieldDelegate
extension LoginVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberTextField.resignFirstResponder()
        return false
    }
}

//MARK: - DisplayLogic
extension LoginVC: LoginDisplayLogic{
    func setupView() {
        
        phoneNumberTextField.delegate = self
        
        // hideKeyboard
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTap)
        // setup termsAndConditionLabel
        let attributedText = NSMutableAttributedString(string: "By click continue you are agree with\nour",
                                                attributes: [
                                                    .foregroundColor: UIColor(named: "Blue-Light")!,
                                                    .font: UIFont(name: "Montserrat-Regular", size: 10)!
                                                ])
        attributedText.append(NSAttributedString(string: " Terms and Condition",
                                                 attributes: [
                                                    .foregroundColor: UIColor(named: "Purple-Gradient")!,
                                                    .font: UIFont(name: "Montserrat-Bold", size: 10)!
                                                 ]))
        termsAndConditionLabel.attributedText = attributedText
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(handleTermsAndConditionTapped))
        labelTap.numberOfTapsRequired = 1
        termsAndConditionLabel.addGestureRecognizer(labelTap)
        
    }
}
