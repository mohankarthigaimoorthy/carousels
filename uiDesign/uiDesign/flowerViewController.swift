//
//  flowerViewController.swift
//  uiDesign
//
//  Created by Imcrinox Mac on 31/05/23.
//

import UIKit

class flowerViewController: UIViewController {

    @IBOutlet weak var flower: UICollectionView!
    @IBOutlet weak var table: UITableView!
    
var  categoary = ["ALL PRODUCTS","FLOWERS","BASKETS","SELF CARE","ALL PRODUCTS","FLOWERS","BASKETS","ALL PRODUCTS","FLOWERS","BASKETS","SELF CARE","ALL PRODUCTS","FLOWERS","BASKETS"]
    var photo = ["image1","image2","image3","image4","image5","image6", "image1","image2","image3","image4","image5","image6"]
var price = ["SR 320","SR 420","SR 360", "SR 460","SR 340","SR 320","SR 420","SR 360", "SR 460","SR 340","SR 320"]
    var dropprice = ["SR 260","SR 360", "SR 300", "SR 400","SR 280","SR 260","SR 360", "SR 300", "SR 400","SR 280", "SR 290"]
    var common =  ["flower1","flower2", "flower3", "flower4", "flower5","flower6","flower7","flower8","flower9","flower10","floweer11"]
    var selectedIndex = 0
    var isselected = 0
    
    
    var rest = [restAPI]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewSetup()
        if let flowlayout = flower?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        
        downloadJSON {
            self.flower.reloadData()
                    self.table.reloadData()
                }
    }
    func tableViewSetup() {
        table.delegate = self
        table.dataSource = self
        flower.delegate = self
        flower.dataSource = self
        DispatchQueue.main.async {
            self.flower.reloadData()
            self.table.reloadData()
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if error == nil {
                do {
                    self.rest = try JSONDecoder().decode([restAPI].self, from: data!)
                    DispatchQueue.main.async {
                        self.flower.reloadData()
                        self.table.reloadData()
                        
                        completed()
                    }
                }
                catch {
                    print("JSON ERROR")
                }
            }
        }
        .resume()
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


extension flowerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flower.dequeueReusableCell(withReuseIdentifier: "flowersCollectionViewCell", for: indexPath) as! flowersCollectionViewCell
        let urlString = "https://api.opendota.com"
        let completeLink = urlString + rest[indexPath.row].img
        
//        cell.topics.text = self.rest[indexPath.item].localized_name
        cell.topics.text = self.categoary[indexPath.item]
        cell.line.isHidden = indexPath.item == selectedIndex ? false : true
        cell.topics.textColor = indexPath.item == isselected ? .red : .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        isselected = indexPath.item
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
extension flowerViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "flowerTableViewCell", for: indexPath) as! flowerTableViewCell
        
        let urlString = "https://api.opendota.com"
        let completeLink = urlString + rest[indexPath.row].img
//        cell.floImg.image = UIImage(named: self.rest[indexPath.row].img) ?? UIImage()
        cell.floImg.image = UIImage(named: self.photo[indexPath.row]) ?? UIImage()
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(rest [indexPath.row].legs)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        cell.tex1.text = self.common[indexPath.row]
        cell.tex2.text = "\(rest[indexPath.row].legs)"
        cell.tex2.attributedText = attributeString
        cell.tex3.text = self.dropprice[indexPath.row]
        return cell
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


