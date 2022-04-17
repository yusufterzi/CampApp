//
//  SearchViewController.swift
//  CampApp
//
//  Created by Nurullah Vural on 10.03.2022.
//

import UIKit
import Common
import CoreLocation

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController (_ vc: SearchViewController, didUserSearchWith location: Location)
}
final class SearchViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate?
    public var keyboardWillShowHandler: VoidHandler?
    public var keyboardWillHideHandler: VoidHandler?

    private let label: UILabel = {
        let label = UILabel()
        label.text = StringProvider.searchHeader
        label.font = FontProvider.listMidMedium
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = StringProvider.searchPlaceHodler
        field.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        return field
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableKeyboardOperations()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(label)
        view.addSubview(field)
        view.addSubview(tableView)
        field.delegate = self
        tableView.backgroundColor = .secondarySystemBackground
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 10, width: label.frame.width, height: label.frame.height)
        field.frame = CGRect(x: 10, y: 20 + label.frame.height , width: view.frame.size.width - 20, height: 50)
        
        let tableY: CGFloat = field.frame.origin.y + field.frame.size.height + 5
        tableView.frame = CGRect(x: 0, y: tableY, width: view.frame.size.width, height: view.frame.size.height - tableY)
    }
    
    private func enableKeyboardOperations() {
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        self.keyboardWillShowHandler?()
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        self.keyboardWillHideHandler?()
    }
     
}
extension SearchViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text = field.text, !text.isEmpty {
            LocationManager.shared.findLocation(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }
            }
        }
        
        return true
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = field.text, !text.isEmpty,text.count > 3 {
            LocationManager.shared.findLocation(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }
            }
        }
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as! SearchViewCell
        cell.setup(locations[indexPath.row].address)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        field.resignFirstResponder()
        delegate?.searchViewController(self, didUserSearchWith: locations[indexPath.row])
        
    }
    
}

