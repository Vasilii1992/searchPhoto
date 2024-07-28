//
//  LikesCollectionViewCell.swift
//  Photo search
//
//  Created by Василий Тихонов on 28.07.2024.
//

import UIKit
import SDWebImage

class LikesCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "LikesCollectionViewCell"
    
    private let checkmark: UIImageView = {
        let image = UIImage(systemName: "checkmark.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView

    }()
    
    var myImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            myImageView.sd_setImage(with: url)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    private func updateSelectedState() {
        myImageView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateSelectedState()
        setupImageView()
        setupCheckmarkView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageView() {
        contentView.addSubview(myImageView)
        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupCheckmarkView() {
        contentView.addSubview(checkmark)
        checkmark.trailingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: -8).isActive = true
        checkmark.bottomAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: -8).isActive = true
    }
    
    func set(photo: UnsplashPhoto) {
        let photoUrl = photo.urls["full"]
        guard let photoURL = photoUrl, let url = URL(string: photoURL) else { return }
        myImageView.sd_setImage(with: url, completed: nil)
    }
}
