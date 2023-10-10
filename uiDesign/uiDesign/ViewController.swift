//
//  ViewController.swift
//  uiDesign
//
//  Created by Imcrinox Mac on 29/05/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heading: UICollectionView!
    @IBOutlet weak var product: UICollectionView!
    @IBOutlet weak var listofProduct: UITableView!
    
    var item = ["ALL PRODUCTS","FLOWERS","BASKETS","SELF CARE","ALL PRODUCTS","FLOWERS","BASKETS","ALL PRODUCTS","FLOWERS","BASKETS","SELF CARE","ALL PRODUCTS","FLOWERS","BASKETS" ]
    var img = [ "image1","image2","image3","image4","image5","image6", "image1","image2","image3","image4","image5","image6"]
    var data = ["SR 320","SR 420","SR 360", "SR 460","SR 340","SR 320","SR 420","SR 360", "SR 460","SR 340","SR 320"]
    var text = ["SR 260","SR 360", "SR 300", "SR 400","SR 280","SR 260","SR 360", "SR 300", "SR 400","SR 280", "SR 290"]
    var flower = ["flower1","flower2", "flower3", "flower4", "flower5","flower6","flower7","flower8","flower9","flower10","floweer11"]
    var selectedIndex = 0
    var isselected = 0
    var isGrid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionsetup()
        
        if let flowLayout = heading?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
        
     
    }

func collectionsetup()
    {
        listofProduct.delegate = self
        listofProduct.dataSource = self
        heading.delegate = self
        heading.dataSource = self
        product.delegate = self
        product.dataSource = self
        DispatchQueue.main.async {
            self.listofProduct.reloadData()
            self.heading.reloadData()
            self.product.reloadData()
        }
    }
    
    @IBAction func toggleBtn(_ sender: Any) {
        
        isGrid = !isGrid
               
               DispatchQueue.main.async {
                   if self.isGrid == false {
                       self.listofProduct.isHidden = false
                       self.product.isHidden = true
                       self.listofProduct.reloadData()
                   } else {
                       self.product.isHidden = false
                       self.listofProduct.isHidden = true
                       self.product.reloadData()
                   }
                   self.view.layoutIfNeeded()
               }
               
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.heading.viewWithTag(111) {
            return item.count
        }
        else if collectionView == self.product.viewWithTag(222) {
            return data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.heading.viewWithTag(111){
            let cell = heading.dequeueReusableCell(withReuseIdentifier: "titleCollectionViewCell", for: indexPath) as! titleCollectionViewCell
            cell.title.text = self.item[indexPath.item]
            cell.title.textColor = indexPath.item == isselected ? .red : .black
       
            cell.underline.isHidden = indexPath.item == selectedIndex ? false : true
            return cell
        }
        else if collectionView == self.product.viewWithTag(222){
            let cells = product.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! productCollectionViewCell
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(data[indexPath.row])")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            cells.imgView.image = UIImage(named: self.img[indexPath.item]) ?? UIImage()
            cells.text1.text = self.flower[indexPath.item]
            cells.text2.text = self.data[indexPath.item]
            cells.text2.attributedText = attributeString
            cells.text3.text = self.text[indexPath.item]
            return cells
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 111{
            selectedIndex = indexPath.item
            isselected = indexPath.item
          
            collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            if collectionView == self.heading.viewWithTag(111){
                return CGSize(width: 1, height: 1)

            }
            else if collectionView == self.product.viewWithTag(222){
                let size = (collectionView.frame.size.width - 30) / 2
                 return CGSize(width: size, height: size)
            }
                            return CGSize(width: 100.0, height: 400.0)
        }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flower.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listofProduct.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as!
        productTableViewCell
        cell.productImage.image = UIImage(named: self.img[indexPath.row]) ?? UIImage()
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(data[indexPath.row])")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        cell.label1.text = self.flower[indexPath.row]
        cell.label2.text = self.data[indexPath.row]
        cell.label2.attributedText = attributeString
        cell.label3.text = self.text[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
