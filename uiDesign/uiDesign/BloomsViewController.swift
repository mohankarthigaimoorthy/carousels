//
//  BloomsViewController.swift
//  uiDesign
//
//  Created by Imcrinox Mac on 30/05/23.
//

import UIKit

class BloomsViewController: UIViewController {

    @IBOutlet weak var products: UICollectionView!
    @IBOutlet weak var subproduct: UICollectionView!
  
    var product = ["ALL PRODUCTS","FLOWERS","BASKETS","SELF CARE","ALL PRODUCTS","FLOWERS","BASKETS","ALL PRODUCTS","FLOWERS","BASKETS","SELF CARE","ALL PRODUCTS","FLOWERS","BASKETS"]
    var image = [ "image1","image2","image3","image4","image5","image6", "image1","image2","image3","image4","image5","image6"]
    var rate = ["SR 320","SR 420","SR 360", "SR 460","SR 340","SR 320","SR 420","SR 360", "SR 460","SR 340","SR 320"]
    var price = ["SR 260","SR 360", "SR 300", "SR 400","SR 280","SR 260","SR 360", "SR 300", "SR 400","SR 280", "SR 290"]
    var items =  ["flower1","flower2", "flower3", "flower4", "flower5","flower6","flower7","flower8","flower9","flower10","floweer11"]
    
    var selectedIndex = 0
    var isSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewsetup()
        if let flowLayout = products?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
        // Do any additional setup after loading the view.
        
    }
    
    func collectionviewsetup() {
        products.delegate = self
        products.dataSource = self
        subproduct.delegate = self
        subproduct.dataSource = self
        DispatchQueue.main.async {
            self.products.reloadData()
            self.subproduct.reloadData()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BloomsViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.products.viewWithTag(333){
                return product.count
        }
        else if collectionView == self.subproduct.viewWithTag(444) {
            return items.count
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.products.viewWithTag(333){
            let cell = products.dequeueReusableCell(withReuseIdentifier: "listCollectionViewCell", for: indexPath) as! listCollectionViewCell
            cell.title.text = self.product[indexPath.item]
            cell.dash.isHidden = indexPath.item == selectedIndex ? false : true
            cell.title.textColor = indexPath.item == isSelected ? .red : .black 

            return cell
        }
        else if collectionView == self.subproduct.viewWithTag(444){
            let cells = subproduct.dequeueReusableCell(withReuseIdentifier: "orderCollectionViewCell", for: indexPath) as! orderCollectionViewCell
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(rate[indexPath.row])")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            cells.prodImg.image = UIImage(named: self.image[indexPath.item]) ?? UIImage()
            cells.prod1.text = self.items[indexPath.item]
            cells.prod2.text = self.rate[indexPath.item]
            cells.prod2.attributedText = attributeString
            cells.prod3.text = self.price[indexPath.item]
            return cells
        }
            return UICollectionViewCell()
        
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 333 {
            selectedIndex = indexPath.item
            isSelected = indexPath.item
            collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == self.products.viewWithTag(333){
            return CGSize(width: 1, height: 1)
        }
        else if collectionView == self.subproduct.viewWithTag(444) {
            let size = (collectionView.frame.size.width - 30) / 2
             return CGSize(width: size, height: size)
        }
        return CGSize(width: 100, height: 100)
    }
    
}
