//
//  ViewController.swift
//  wheelPicker
//
//  Created by katya on 5.03.23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    var colors: [UIColor] = [.yellow, .red, .purple, .brown, .green, .blue, .lightGray, .black, .systemCyan]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
        imageView.contentMode = .scaleAspectFill
        collectionView!.backgroundView = imageView
        
        setupCollectionView()
        
        
        // создание круга
        let circle = UIView(frame: CGRect(x: (view.frame.width - 420) / 2, y: view.frame.height - 180, width: 420, height: 420))
        circle.layer.cornerRadius = circle.layer.frame.width / 2
        
        // установка цвета
        circle.backgroundColor = UIColor.systemBlue
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
        
        cell.backgroundColor = colors[indexPath.item % colors.count]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(colors[indexPath.item % colors.count])
    }

}

