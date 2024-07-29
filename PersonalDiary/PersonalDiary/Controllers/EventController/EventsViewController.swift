//
//  EventsViewController.swift
//  PersonalDiary
//
//  Created by Cynthia D'Phoenix on 7/25/24.
//
import UIKit
import CoreData

class EventsViewController: UIViewController {

    private let topView = UIView()
    private let pageTitleLabel = UILabel()
    private var collectionView: UICollectionView!
    private let addNewButton = UIButton(type: .system)
    
    var events = [EventsModel]()
    private var viewModel: EventViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        events = EventManager.shared.events
        setupViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateEventCount), name: .eventUpdated, object: nil)
        setupViewModel()
        fetchEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        events = EventManager.shared.events
        fetchEvents()
    }

    
    private func setupViewModel() {
        let event1 = EventsModel(id: UUID(), imageName: "diary1", title: "Diary Test 1", date: Date(), eventDescription: "My Story here 1...")
        let event2 = EventsModel(id: UUID(), imageName: "diary2", title: "Diary Test 2", date: Date().addingTimeInterval(-86400), eventDescription: "My Story here 2...")
        let event3 = EventsModel(id: UUID(), imageName: "diary3", title: "Diary Test 3", date: Date().addingTimeInterval(-172800), eventDescription: "My Story here 3...")

        events = [event1, event2]
        
        viewModel = EventViewModel(events: events)
    }


    private func setupViews() {
        
        // Top View
        topView.backgroundColor = .systemPink
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)

        // Page Title Label Setup
        pageTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pageTitleLabel.textColor = .white
        pageTitleLabel.numberOfLines = 0
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "My Diary"
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(pageTitleLabel)

        // Add New Event Button Setup
        addNewButton.setTitle("+AddNew", for: .normal)
        addNewButton.backgroundColor = .systemPink
        addNewButton.setTitleColor(.white, for: .normal)
        addNewButton.layer.cornerRadius = 4
        addNewButton.translatesAutoresizingMaskIntoConstraints = false
        addNewButton.addTarget(self, action: #selector(addNewEventButtonTapped), for: .touchUpInside)
        topView.addSubview(addNewButton)
        
        // Collection View
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EventsCollectionViewCell.self, forCellWithReuseIdentifier: EventsCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
     
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),

            // Page Title Label Constraints
            pageTitleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            pageTitleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),

            // Add New Event Button Constraints
            addNewButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            addNewButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            addNewButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Collection View Constraints
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }


    @objc private func addNewEventButtonTapped() {
            let addEventVC = AddEventViewController()
            addEventVC.onEventAdded = { [weak self] (event: EventsModel) in
                self?.events.append(event)
                self?.collectionView.reloadData()
            }
        navigationController?.pushViewController(addEventVC, animated: true)
        }
        
        private func fetchEvents() {
            events = EventManager.shared.getEvents()
            events.reverse()
            collectionView.reloadData()
        }


       @objc private func updateEventCount() {
           fetchEvents()
       }

   }

extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items: \(events.count)")
        return events.count
    }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.identifier, for: indexPath) as? EventsCollectionViewCell else {
        fatalError("Unable to dequeue EventsCollectionViewCell")
    }
    
    let event = events[indexPath.row]
    cell.configure(with: event)
    cell.delegate = self
    return cell
}


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemWidth = collectionView.frame.width - padding * 2
        return CGSize(width: itemWidth, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventDetailVC = EventDetailViewController()
        
        // Fetch the selected event
        let selectedEvent = events[indexPath.row] 
        
        // Set the event details in the eventDetailVC
        eventDetailVC.events = selectedEvent
        
        // Push the eventDetailVC to the navigation stack
        navigationController?.pushViewController(eventDetailVC, animated: true)
    }

}

extension EventsViewController: EventCollectionViewCellDelegate {
    func eventCollectionViewCell(_ cell: EventsCollectionViewCell, didTapDeleteFor event: EventsModel) {
        EventManager.shared.removeEvent(event)
        fetchEvents()
        NotificationCenter.default.post(name: .eventUpdated, object: nil)
    }
}
