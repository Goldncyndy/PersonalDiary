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
    private let imageView = UIImageView()
    private let titleTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let descriptionTextView = UITextView()
    
    var onEventAdded: ((EventsModel) -> Void)?
    private let imagePicker = UIImagePickerController()
    
    var eventToEdit: EventEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureView()
        setupConstraints()
        imagePicker.delegate = self
        
        setupTapGesture()
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

        // Add Button Setup
        addButton.setTitle("Add Event", for: .normal)
        addButton.backgroundColor = .systemPink
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 4
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)

        // Clear Button Setup
        clearButton.setTitle("Clear", for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitleColor(.systemPink, for: .normal)
        clearButton.layer.cornerRadius = 4
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        view.addSubview(clearButton)

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
            descriptionTextView.heightAnchor.constraint(equalToConstant: 160),

            // Add Button Constraints
            addButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 40),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 23),
            addButton.heightAnchor.constraint(equalToConstant: 50),

            // Clear Button Constraints
            clearButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 40),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 23),
            clearButton.heightAnchor.constraint(equalToConstant: 50),

            
        ])
    }
    
    private func setupTapGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        }
        
        @objc private func dismissKeyboard() {
            view.endEditing(true)
        }

    private func configureView() {
            if let event = eventToEdit {
                // Populate the UI with event data for editing
                titleTextField.text = event.title
                descriptionTextView.text = event.eventDescription
                datePicker.date = event.date ?? Date()
                if let imageName = event.imageName {
                    let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(imageName).path
                    if let imagePath = imagePath, let image = UIImage(contentsOfFile: imagePath) {
                        imageView.image = image
                    }
                }
                pageTitleLabel.text = "Edit Event"
                addButton.setTitle("Update", for: .normal)
            } else {
                pageTitleLabel.text = "Add New Event"
                addButton.setTitle("Add Event", for: .normal)
            }
        }

    @objc private func addButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty,
              let imageData = imageView.image?.pngData(),
              let imageName = saveImageToDisk(imageData: imageData) else {
            print("Please fill in all fields")
            showAlert(message: "Please fill in all fields")
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let event = eventToEdit {
            // Update existing event
            updateEvent(event, withImageName: imageName, title: title, date: datePicker.date, description: description)
        } else {
            // Create new event
            createNewEvent(imageName: imageName, title: title, date: datePicker.date, description: description, context: context)
        }

        do {
            try context.save()
            let eventModel = EventsModel(id: eventToEdit?.id ?? UUID(), imageName: imageName, title: title, date: datePicker.date, eventDescription: description)
            onEventAdded?(eventModel)
            clearFields()
        } catch {
            print("Failed to save event: \(error.localizedDescription)")
        }
    }
    
    private func showAlert(message: String) {
           let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }

    private func updateEvent(_ event: EventEntity, withImageName imageName: String, title: String, date: Date, description: String) {
        event.imageName = imageName
        event.title = title
        event.date = date
        event.eventDescription = description
        
        navigationController?.popViewController(animated: true)
        
    }

    private func createNewEvent(imageName: String, title: String, date: Date, description: String, context: NSManagedObjectContext) {
        let newEvent = EventEntity(context: context)
        newEvent.id = UUID()
        newEvent.imageName = imageName
        newEvent.title = title
        newEvent.date = date
        newEvent.eventDescription = description
        
        navigationController?.popViewController(animated: true)
    }


        @objc private func clearButtonTapped() {
            clearFieldsButtonTapped()
        }

        @objc private func doneButtonTapped() {
            navigationController?.popViewController(animated: true)
        }

        private func clearFields() {
            titleTextField.text = ""
            descriptionTextView.text = ""
            imageView.image = nil
            datePicker.date = Date()
        }
        
        func clearFieldsButtonTapped() {
            // Create the alert controller
            let alertController = UIAlertController(title: "Clear All Fields", message: "Are you sure you want to clear all fields?", preferredStyle: .alert)
            
            // Add the "Yes" action
            let clearAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
                // Proceed to clear the fields
                self?.clearFields()
            }
            
            // Add the "No" action
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            // Add actions to the alert controller
            alertController.addAction(clearAction)
            alertController.addAction(cancelAction)
            
            // Present the alert controller
            present(alertController, animated: true, completion: nil)
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
