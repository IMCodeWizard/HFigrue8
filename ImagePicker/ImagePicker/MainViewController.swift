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
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // MARK: - Actions
    
    @IBAction func randomAction(_ sender: UIButton) {
        DispatchQueue.main.async { [weak self] in
            let imageData = PickerManager.shared.getRandomImageData()
            self?.updateUI(imageData)
        }
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        
    }
    
    // MARK: - Rx Hanlder
    
    func rxHanlder() {
        
    }
    
    
    // MARK: - UI Methods
    
    func updateUI(_ imgData: ImageData) {
        self.textField.text = imgData.imgTitle
        self.imageView.image = UIImage(named: imgData.imgName)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}

