

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self,
                               action: #selector(addBarButtonTapped))
    }()
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self,
                               action: #selector(actionBarButtonTapped))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        
        collectionView.backgroundColor = .white
        
    }
    // MARK: - NavigationItems Action
    @objc func addBarButtonTapped() {
        print(#function)
    }
    
    @objc func actionBarButtonTapped() {
        print(#function)

    }
    
    
    // MARK: - Setup UI Elements
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")

    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.5742436647, green: 0.5705327392, blue: 0.5704542994, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        navigationItem.rightBarButtonItems = [actionBarButtonItem,addBarButtonItem]

    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
    
    
    
    // MARK: - UICollectionViewDataSourse, UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}



/*
 ты IOS разработчик. У нас в NavigationBar есть слева тайтл, справа две кнопки, а ниже должен быть search Bar, но search Bar появляется только когда мы скролим вниз, а нужно сделать так, чтобы search Bar был всегда на экране.
 
 You are an iOS developer. We have a title in the NavigationBar on the left, two buttons on the right, and there should be a search Bar below, but the search Bar appears only when we scroll down, and we need to make sure that the search Bar is always on the screen.
 Our code:
 
 import UIKit

 class SceneDelegate: UIResponder, UIWindowSceneDelegate {

     var window: UIWindow?


     func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         guard let scene = (scene as? UIWindowScene) else { return }
         window = UIWindow(windowScene: scene)
         window?.rootViewController = MainTabBarController()
         window?.makeKeyAndVisible()
     }
 }
 
 class MainTabBarController: UITabBarController {
     
     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .gray
        
        let photoVC = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

         viewControllers = [
             generateNavigationController(rootViewController: photoVC,
                                                             title: "Photos",
                                                             imageSystemName: "photo.on.rectangle"),
             generateNavigationController(rootViewController: ViewController(),
                                                             title: "Favourites",
                                                             imageSystemName: "heart.fill"),
         
         ]
         
     }
     
     private func generateNavigationController(rootViewController: UIViewController, title: String,imageSystemName: String ) -> UINavigationController {
         let navController = UINavigationController(rootViewController: rootViewController)
         navController.tabBarItem.title = title
         navController.tabBarItem.image = UIImage(systemName: imageSystemName)
         return navController
     }
 }

 class PhotosCollectionViewController: UICollectionViewController {
     
     private lazy var addBarButtonItem: UIBarButtonItem = {
         return UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                action: #selector(addBarButtonTapped))
     }()
     
     private lazy var actionBarButtonItem: UIBarButtonItem = {
         return UIBarButtonItem(barButtonSystemItem: .action, target: self,
                                action: #selector(actionBarButtonTapped))
     }()
     

     override func viewDidLoad() {
         super.viewDidLoad()
         setupCollectionView()
         setupNavigationBar()
         setupSearchBar()
         
         collectionView.backgroundColor = .white
         
     }
     // MARK: - NavigationItems Action
     @objc func addBarButtonTapped() {
         print(#function)
     }
     
     @objc func actionBarButtonTapped() {
         print(#function)

     }
     
     
     // MARK: - Setup UI Elements
     private func setupCollectionView() {
         collectionView.register(UICollectionViewCell.self,
                                 forCellWithReuseIdentifier: "cell")

     }
     
     private func setupNavigationBar() {
         let titleLabel = UILabel()
         titleLabel.text = "PHOTOS"
         titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
         titleLabel.textColor = #colorLiteral(red: 0.5742436647, green: 0.5705327392, blue: 0.5704542994, alpha: 1)
         navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
         
         navigationItem.rightBarButtonItems = [actionBarButtonItem,addBarButtonItem]
     }
     
     private func setupSearchBar() {
         let searchController = UISearchController(searchResultsController: nil)
         navigationItem.searchController = searchController
         searchController.hidesNavigationBarDuringPresentation = false
         searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchBar.delegate = self
     }
     
     
     
     // MARK: - UICollectionViewDataSourse, UICollectionViewDelegate
     
     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 5
     }
     
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
         cell.backgroundColor = .red
         return cell
     }
     
 }
 // MARK: - UISearchBarDelegate

 extension PhotosCollectionViewController: UISearchBarDelegate {
     
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         print(searchText)
     }
 }

 
 
 */
