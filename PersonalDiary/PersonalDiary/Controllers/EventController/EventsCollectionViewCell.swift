//
//  EventsCollectionViewCell.swift
//  PersonalDiary
//
//  Created by Cynthia D'Phoenix on 7/26/24.
//

import UIKit

protocol EventCollectionViewCellDelegate: AnyObject {
    func eventCollectionViewCell(_ cell: EventsCollectionViewCell, didTapDeleteFor event: EventsModel)
}

class EventsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EventsCollectionViewCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let darkOverlayView = UIView()
    private let deleteButton = UIButton(type: .system)
    
    var event: EventsModel?
    weak var delegate: EventCollectionViewCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    private func setupViews() {
        contentView.backgroundColor = .black
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        // Dark Overlay View Setup
        darkOverlayView.translatesAutoresizingMaskIntoConstraints = false
        darkOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        contentView.addSubview(darkOverlayView)

        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        dateLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        dateLabel.textColor = .white
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)

        if let deleteIcon = UIImage(systemName: "trash") {
                    deleteButton.setImage(deleteIcon, for: .normal)
                }
        deleteButton.backgroundColor = .clear
        deleteButton.tintColor = .systemPink
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deleteButton)


        NSLayoutConstraint.activate([
            // Image View Constraints
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // Dark Overlay View Constraints
            darkOverlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            darkOverlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            darkOverlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            darkOverlayView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),

            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: darkOverlayView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: darkOverlayView.leadingAnchor, constant: 8),
            
            // Date Label Constraints
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            dateLabel.leadingAnchor.constraint(equalTo: darkOverlayView.leadingAnchor, constant: 8),

            // Delete Button Constraints
            deleteButton.centerYAnchor.constraint(equalTo: darkOverlayView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: darkOverlayView.trailingAnchor, constant: -8),
            deleteButton.heightAnchor.constraint(equalToConstant: 18),
            deleteButton.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with event: EventsModel) {
        imageView.image = UIImage(named: event.imageName ?? "")
        titleLabel.text = event.title
        dateLabel.text = "\(event.date)"
        self.event = event
    }
    
    @objc func deleteButtonTapped() {
        guard let event = event else { return }
        delegate?.eventCollectionViewCell(self, didTapDeleteFor: event)
    }
}

