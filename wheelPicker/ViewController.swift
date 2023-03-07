//
//  ViewController.swift
//  wheelPicker
//
//  Created by katya on 5.03.23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    let hexColors = ["#FADADD", "#FDD7E4", "#FEC8D8", "#FCD2B7", "#FCE3C2", "#FFF0C9", "#E1F7D5", "#C6EFD9", "#B7E2F5", "#C5D5F5", "#D5C5F5", "#E3C5F5", "#F5C5E8", "#F5C5D2", "#F5D5C5", "#F5E3C5", "#E7F5C5", "#D2F5C5", "#C5F5D5", "#C5F5E3"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
//        imageView.contentMode = .scaleAspectFill
//        collectionView!.backgroundView = imageView
        
        setupCollectionView()
        
        createCircle()
   
    }
    
    private func createCircle() {
        // создание круга
        let circle = UIView(frame: CGRect(x: (view.frame.width - 420) / 2, y: view.frame.height - 90, width: 420, height: 420))
        circle.layer.cornerRadius = circle.layer.frame.width / 2
        
        // установка цвета
        circle.backgroundColor = UIColor.darkGray
        circle.layer.borderWidth = 10
        circle.layer.borderColor = UIColor.white.cgColor
        
        // добавление круга на экран
        view.addSubview(circle)
    }
    
    private func setupCollectionView() {
        let key = CircularCollectionViewCell.reuseIdentifier
        collectionView.register(UINib(nibName: key, bundle: nil), forCellWithReuseIdentifier: key)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircularCollectionViewCell.reuseIdentifier, for: indexPath) as? CircularCollectionViewCell else {
            fatalError()
        }
        

        cell.backgroundColor = UIColor(hex: hexColors[indexPath.item % hexColors.count])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // print(colors[indexPath.item % colors.count])
    }

}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

