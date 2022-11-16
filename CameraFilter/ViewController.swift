//
//  ViewController.swift
//  CameraFilter
//
//  Created by Konstantin Babushkin on 15.11.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    

    let disposeBug = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
              let photosCVC = navC.viewControllers.first as?
                PhotoCollectionViewController
        else {
            fatalError("Segue destination is not found")
        }
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            
            
        }).disposed(by: disposeBug)
    }
    
    @IBAction func applyButtomPressed(){
        
        guard let sourceImage = photoImageView.image else { return }
        
        FilterService().applyFilter(to: sourceImage) { [weak self ] filteredImage in
            DispatchQueue.main.async {
                self?.photoImageView.image = filteredImage
            }
        }
        
    }
    
    private func updateUI(with image: UIImage){
        photoImageView.image = image
        applyFilterButton.isHidden = false
    
    }


}

