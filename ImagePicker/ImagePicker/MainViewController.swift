//
//  ViewController.swift
//  ImagePicker
//
//  Created by Joe Black on 13/02/2019.
//  Copyright © 2019 iOS Ninja. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var currentImageData: ImageData?
    let disposeBag = DisposeBag()
    var alertTimeout: Timer?
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        randomIt()
    }
    
    
    //MARK: - Custom Methods
    
    func randomIt() {
        DispatchQueue.main.async { [weak self] in
            let imageData = PickerManager.shared.getRandomImageData()
            self?.updateUI(imageData)
        }
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Created by: iOS Ninja", message: "The time now is: \(Date().formattedData())", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok.", style: .destructive, handler: { (action) in
            self.alertTimeout?.invalidate()
        }))
        
        self.alertTimeout = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (timer) in
            alert.dismiss(animated: true)
        }
        
        self.present(alert, animated: true)
        
     
        
    }
    
    
    // MARK: - Actions

    @IBAction func infoAction(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func randomAction(_ sender: UIButton) {
        randomIt()
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ListVC", sender: nil)
    }
    
    
    // MARK: - Rx Hanlder
    
    func rxHanlder(_ observable: Observable<ImageData?>) {
        
        observable.subscribe(onNext: { [weak self] imageData in
            if let image = imageData {
                self?.updateUI(image)
            }
        }).disposed(by: disposeBag)
    }
    
    
    // MARK: - UI Methods
    
    func updateUI(_ imgData: ImageData) {
        self.currentImageData = imgData
        self.textField.text = imgData.imgTitle
        self.imageView.image = UIImage(named: imgData.imgName)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ListVC" {
            let listVC = segue.destination as! ListViewController
            self.rxHanlder(listVC.selectedImageData)
        }
    }
    
}


//MARK: -
extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return print("No text") }
        self.currentImageData?.imgTitle = text
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
