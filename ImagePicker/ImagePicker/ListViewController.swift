//
//  ListViewController.swift
//  ImagePicker
//
//  Created by Joe Black on 13/02/2019.
//  Copyright © 2019 iOS Ninja. All rights reserved.
//

import UIKit
import RxSwift


class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var tableDataCollection: [ImageData]?
    
    let selectedImageDataVariable = Variable<ImageData?>(nil)
    var selectedImageData: Observable<ImageData?> {
        return selectedImageDataVariable.asObservable()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupTableDataCollection()
    }
    
    
    func setupTableDataCollection() {
        
        self.tableDataCollection = PickerManager.shared.getCollection()
        self.tableView.reloadData()
    
    }

}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableDataCollection?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        let imageData = self.tableDataCollection![indexPath.row]
        
        cell.bindData(imageData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedImageData = self.tableDataCollection![indexPath.row]
        
        selectedImageDataVariable.value = selectedImageData
        
        self.navigationController?.popViewController(animated: true)
    }
}


class CustomCell: UITableViewCell {
    
    @IBOutlet weak var labelImageNumb: UILabel!
    @IBOutlet weak var labelImageTitle: UILabel!
    @IBOutlet weak var imageViewFigure8: UIImageView!
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func bindData(_ imageData: ImageData) {
        
        self.labelImageNumb.text = imageData.imgNumber
        self.labelImageTitle.text = imageData.imgTitle
        
        DispatchQueue.main.async {
            self.imageViewFigure8.image = UIImage(named: imageData.imgName)
        }
    }
}
