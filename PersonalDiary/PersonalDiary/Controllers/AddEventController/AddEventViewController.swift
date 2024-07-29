//
//  AddEventViewController.swift
//  PersonalDiary
//
//  Created by Cynthia D'Phoenix on 7/26/24.
//

import UIKit
import CoreData

class AddEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let topView = UIView()
    private let pageTitleLabel = UILabel()
    private let addButton = UIButton(type: .system)
    private let clearButton = UIButton(type: .system)
    private let doneButton = UIButton(type: .system)
    private let imageView = UIImageView()
    private let titleTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let descriptionTextView = UITextView()
    private let eventOfDayTextField = UITextField()
    
    var onEventAdded: ((EventsModel) -> Void)?
    private let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        imagePicker.delegate = self
    }

    private func setupViews() {
        view.backgroundColor = .black

        // Top View
        topView.backgroundColor = .systemPink
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)

        // Page Title Label Setup
        pageTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pageTitleLabel.textColor = .white
        pageTitleLabel.numberOfLines = 0
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "Add Event"
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitleLabel)

        // Image View Setup
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Add Tap Gesture to ImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)

        // Title Text Field Setup
        titleTextField.placeholder = "Enter Title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)

        // Date Picker Setup
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)

        // Description Text View Setup
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 4
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)

        // Event of the Day Text Field Setup
        eventOfDayTextField.placeholder = "Event of the Day"
        eventOfDayTextField.borderStyle = .roundedRect
        eventOfDayTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventOfDayTextField)

        // Add Button Setup
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .systemPurple
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 4
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)

        // Clear Button Setup
        clearButton.setTitle("Clear", for: .normal)
        clearButton.backgroundColor = .systemGray
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.layer.cornerRadius = 4
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        view.addSubview(clearButton)

        // Done Button Setup
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 4
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        view.addSubview(doneButton)
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
            imageView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            // Title Text Field Constraints
            titleTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),

            // Date Picker Constraints
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 40),

            // Description Text View Constraints
            descriptionTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),

            // Event of the Day Text Field Constraints
            eventOfDayTextField.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            eventOfDayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventOfDayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            eventOfDayTextField.heightAnchor.constraint(equalToConstant: 40),

            // Add Button Constraints
            addButton.topAnchor.constraint(equalTo: eventOfDayTextField.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 40),

            // Clear Button Constraints
            clearButton.topAnchor.constraint(equalTo: eventOfDayTextField.bottomAnchor, constant: 20),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 100),
            clearButton.heightAnchor.constraint(equalToConstant: 40),

            // Done Button Constraints
            doneButton.topAnchor.constraint(equalTo: eventOfDayTextField.bottomAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.widthAnchor.constraint(equalToConstant: 100),
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func addButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty,
              let eventOfDay = eventOfDayTextField.text, !eventOfDay.isEmpty,
              let imageData = imageView.image?.pngData(),
              let imageName = saveImageToDisk(imageData: imageData) else {
            print("Please fill in all fields")
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newEvent = EventEntity(context: context)
        newEvent.id = UUID()  // Ensure this matches the attribute name in your Core Data model
        newEvent.imageName = imageName
        newEvent.title = title
        newEvent.date = datePicker.date
        newEvent.eventDescription = description

        do {
            try context.save()
            let eventModel = EventsModel(id: newEvent.id ?? UUID(), imageName: imageName, title: title, date: datePicker.date, eventDescription: description)
            onEventAdded?(eventModel)
            clearFields()
        } catch {
            print("Failed to save event: \(error.localizedDescription)")
        }
    }

    @objc private func clearButtonTapped() {
        clearFields()
    }

    @objc private func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    private func clearFields() {
        titleTextField.text = ""
        descriptionTextView.text = ""
        eventOfDayTextField.text = ""
        imageView.image = nil
        datePicker.date = Date()
    }

    @objc private func imageViewTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    private func saveImageToDisk(imageData: Data) -> String? {
        let fileName = UUID().uuidString + ".png"
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = paths[0].appendingPathComponent(fileName)
        do {
            try imageData.write(to: filePath)
            return fileName
        } catch {
            print("Error saving image to disk: \(error.localizedDescription)")
            return nil
        }
    }
}

//    @objc private func imageViewTapped() {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        imagePickerController.sourceType = .photoLibrary
//        present(imagePickerController, animated: true, completion: nil)
//    }
//
//    private func saveImageToDisk(imageData: Data) -> String? {
//        let fileName = UUID().uuidString + ".png"
//        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
//        do {
//            try imageData.write(to: fileURL)
//            return fileName
//        } catch {
//            print("Error saving image: \(error.localizedDescription)")
//            return nil
//        }
//    }

    // UIImagePickerControllerDelegate methods
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[.originalImage] as? UIImage {
//            imageView.image = selectedImage
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//}

