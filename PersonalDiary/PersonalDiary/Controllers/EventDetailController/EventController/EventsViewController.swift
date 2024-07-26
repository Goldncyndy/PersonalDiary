//
//  EventsViewController.swift
//  PersonalDiary
//
//  Created by Cynthia D'Phoenix on 7/25/24.
//

import UIKit

class EventsViewController: UIViewController {
    
    private let topView = UIView()
    private let pageTitleLabel = UILabel()
    private var collectionView: UICollectionView!
    private let addNewButton = UIButton(type: .system)
    
    var events = [EventsModel]()
    private var viewModel: EventViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        
        // Top View
        topView.backgroundColor = .systemPurple
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)

        // Page Title Label Setup
        pageTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pageTitleLabel.textColor = .black
        pageTitleLabel.numberOfLines = 0
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "Cart"
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitleLabel)

        // Checkout and Buy Button Setup
        addNewButton.setTitle("+ AddNew", for: .normal)
        addNewButton.backgroundColor = .systemPurple
        addNewButton.setTitleColor(.white, for: .normal)
        addNewButton.layer.cornerRadius = 4
        addNewButton.translatesAutoresizingMaskIntoConstraints = false
        addNewButton.addTarget(self, action: #selector(addNewEventButtonTapped), for: .touchUpInside)
        view.addSubview(addNewButton)
        
        // Collection View
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EventsCollectionViewCell.self, forCellWithReuseIdentifier: EventsCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
     
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),

            // Page Title Label Constraints
            pageTitleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            pageTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Buy Button Constraints
            addNewButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            addNewButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            addNewButton.widthAnchor.constraint(equalToConstant: 30),
            addNewButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Collection View Constraints
            collectionView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    
    @objc func addNewEventButtonTapped() {
//        let checkoutVC = CheckoutViewController()
//        checkoutVC.modalPresentationStyle = .fullScreen
//        present(checkoutVC, animated: true, completion: nil)
        
    }
}

extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as? EventsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let event = events[indexPath.row]
        cell.configure(with: event)
        cell.delegate = self
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemWidth = (collectionView.frame.width)
        return CGSize(width: itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
}

extension EventsViewController: EventCollectionViewCellDelegate {
    func eventCollectionViewCell(_ cell: EventsCollectionViewCell, didTapDeleteFor event: EventsModel) {
        print("deleted!!")
    }
    
}
