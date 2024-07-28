//
//  LikesCollectionViewController.swift
//  Photo search
//
//  Created by Василий Тихонов on 28.07.2024.
//

import UIKit

class LikesCollectionViewController: UICollectionViewController {
    
    var photos = [UnsplashPhoto]()
    private var selectedImages = [UIImage]()

    
    private var numberOfSelectedPhotos: Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
    private lazy var trashBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBarButtonTapped))
    }()
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы еще не добавили картинку..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupEnterLabel()
        setupNavigationBar()
        loadSavedPhotos()
    }
    
    private func loadSavedPhotos() {
           let urls = ImageSaver.loadImageURLs()
           self.photos = urls.map { UnsplashPhoto(width: 0, height: 0, urls: ["regular": $0]) }

           collectionView.reloadData()
       }
    
    
    @objc func trashBarButtonTapped() {
            let alertController = UIAlertController(title: nil, message: "Вы действительно хотите удалить выбранные фото?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
                self?.deleteSelectedPhotos()
            }
            let cancelAction = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
        private func deleteSelectedPhotos() {
            guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
            
            let items = selectedIndexPaths.map { $0.item }.sorted(by: >)
            for item in items {
                photos.remove(at: item)
            }
          
            collectionView.deleteItems(at: selectedIndexPaths)
            selectedImages.removeAll()
            updateNavButtonsState()
            savePhotos()
        }
    
     func savePhotos() {
        let urls = photos.map { $0.urls["regular"]! }
        ImageSaver.saveImageURLs(urls)
        
        // Validate saving
        let savedUrls = ImageSaver.loadImageURLs()
        if savedUrls != urls {
            print("Error: Data was not saved correctly.")
        } else {
            print("Data saved successfully.")
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(LikesCollectionViewCell.self,
                                forCellWithReuseIdentifier: LikesCollectionViewCell.reuseId)

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
    }
    
    private func updateNavButtonsState() {
        trashBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
        
    }
    
    func refresh() {
        self.selectedImages.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
        updateNavButtonsState()
    }
    
    
    // MARK: - Setup UI Elements
    
    private func setupEnterLabel() {
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "FAVOURITES"
        titleLabel.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItem = trashBarButtonItem
        trashBarButtonItem.isEnabled = false
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = photos.count != 0
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCollectionViewCell.reuseId, for: indexPath) as! LikesCollectionViewCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateNavButtonsState()
        let cell = collectionView.cellForItem(at: indexPath) as! LikesCollectionViewCell
        guard let image = cell.myImageView.image else { return }
            selectedImages.append(image)
            savePhotos()

    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateNavButtonsState()
        let cell = collectionView.cellForItem(at: indexPath) as! LikesCollectionViewCell
        guard let image = cell.myImageView.image else { return }
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
        savePhotos()
    }

}

    // MARK: - UICollectionViewDelegateFlowLayout
extension LikesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3 - 1, height: width/3 - 1)
    }
}
