import UIKit

final class CartViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let colView = UICollectionView()
        colView.delegate = self
        colView.dataSource = self
        colView.translatesAutoresizingMaskIntoConstraints = false
        
        return colView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}

//MARK: - Private Extensions

private extension CartViewController {
    func setupView() {
        
    }
}


extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
