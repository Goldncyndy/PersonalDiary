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
    private let deleteButton = UIButton(type: .system)
    
    var events: EventsModel?
    weak var delegate: EventCollectionViewCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)

        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.backgroundColor = .systemPurple
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.layer.cornerRadius = 4
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 140),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            deleteButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with event: EventsModel) {
        imageView.image = UIImage(named: event.imageName)
        titleLabel.text = event.title
        dateLabel.text = "\(event.date)"
        self.events = event
    }
    
    @objc func deleteButtonTapped() {
        guard let event = events else { return }
        delegate?.eventCollectionViewCell(self, didTapDeleteFor: event)
    }
    
}
