//
//  EventDetailViewController.swift
//  PersonalDiary
//
//  Created by Cynthia D'Phoenix on 7/26/24.
//

import UIKit
import CoreData

class EventDetailViewController: UIViewController {

    private let topView = UIView()
    private let pageTitleLabel = UILabel()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    private let editButton = UIButton(type: .system)
    private let doneButton = UIButton(type: .system)
    
    var events: EventsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureView()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        topView.backgroundColor = .systemPink
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)
        
        // Page Title Label Setup
        pageTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pageTitleLabel.textColor = .white
        pageTitleLabel.numberOfLines = 0
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "Event Detail"
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitleLabel)

        // Image View Setup
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Title Label Setup
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Description Label Setup
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

        // Price Label Setup
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .white
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        
        // Buy Button Setup
        editButton.setTitle("Edit", for: .normal)
        editButton.backgroundColor = .systemPink
        editButton.setTitleColor(.white, for: .normal)
        editButton.layer.cornerRadius = 4
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editButton)
        
        // Add to Cart Button Setup
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = .white
        doneButton.setTitleColor(.systemPink, for: .normal)
        doneButton.layer.cornerRadius = 4
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        view.addSubview(doneButton)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Top View Constraints
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),

            // Page Title Label Constraints
            pageTitleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            pageTitleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),

            // Image View Constraints
            imageView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 60),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Description Label Constraints
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Price Label Constraints
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140),

            // Buy Button Constraints
            editButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            editButton.heightAnchor.constraint(equalToConstant: 50),
            editButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 23),

            // Add to Cart Button Constraints
            doneButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30),
            doneButton.leadingAnchor.constraint(equalTo: editButton.trailingAnchor, constant: 10),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 23)
        ])
    }

    private func configureView() {
        guard let event = events else { return }
        imageView.image = UIImage(named: event.imageName)
        titleLabel.text = "Diary: " + event.title
        descriptionLabel.text = event.eventDescription
        dateLabel.text = "\(event.date)"
    }
    
    @objc func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func editButtonTapped() {
        let addEventVC = AddEventViewController()
        addEventVC.modalPresentationStyle = .fullScreen
        present(addEventVC, animated: true, completion: nil)
        
    }
}

