//
//  PhotosCell.swift
//  Photo search
//
//  Created by Василий Тихонов on 27.07.2024.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    static let reuseId = "PhotosCell"
    
    private let checkmark: UIImageView = {
        let image = UIImage(systemName: "checkmark.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView

    }()
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    // когда на ячейку нажимаем
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    private func updateSelectedState() {
        photoImageView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateSelectedState()
        setupPhotoImageView()
        setupCheckmarkView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupPhotoImageView() {
        contentView.addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true

    }
    
    private func setupCheckmarkView() {
        contentView.addSubview(checkmark)
        checkmark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8).isActive = true
        checkmark.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8).isActive = true
    }
    
}
