//
//  ViewController.swift
//  PhotoAlbulm
//
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCell = UICollectionViewCell()
    
    let dataCount:Int = 12
    
    var offset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        self.navigationController?.delegate = self
        
        offset = self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.size.height
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath) as! ImageCollectionViewCell
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCell = collectionView.cellForItem(at: indexPath)!
        
        performSegue(withIdentifier: "NewVCSegue", sender: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow:CGFloat = 3
        
        let hardCodedPadding:CGFloat = 2
        
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        
        let itemHeight = itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
        
    }


}

extension ViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
            
        case .push:
            
            let animator = PresentAnimator()
            
            animator.originFrame = selectedCell.frame
            
            animator.offset = offset
            
            return animator
            
        case .pop:
            
            let animator = DismissAnimator()
            
            animator.originFrame = selectedCell.frame
            
            animator.offset = offset
            
            return animator
            
        default:
            
            return nil
            
        }
        
    }
    
    
}

