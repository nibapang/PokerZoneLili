//
//  HistoryVC.swift
//  PokerZoneLili
//
//  Created by PokerZoneLili on 2025/3/7.
//


import UIKit

class LiliHistoryViewController: UIViewController {

    @IBOutlet weak var HistoryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HistoryCollection.dataSource = self
        HistoryCollection.delegate = self
        
        setupCollectionViewLayout()
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10 // Space between cells
        let numberOfColumns: CGFloat = 3 // 3 cells per row
        
        // Calculate cell width
        let totalSpacing = (numberOfColumns - 1) * spacing // Total spacing between cells
        let cellWidth = (HistoryCollection.frame.width - totalSpacing) / numberOfColumns
        let cellHeight: CGFloat = 120 // Fixed height for all cells
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight) // Fixed height
        layout.minimumInteritemSpacing = spacing // Horizontal spacing
        layout.minimumLineSpacing = spacing // Vertical spacing
        layout.scrollDirection = .vertical // Scroll vertically
        
        HistoryCollection.collectionViewLayout = layout
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension LiliHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LiliHIstoryCViewController
        cell.cardImg.image = UIImage(data: arrHistory[indexPath.row])
        return cell
    }
}
