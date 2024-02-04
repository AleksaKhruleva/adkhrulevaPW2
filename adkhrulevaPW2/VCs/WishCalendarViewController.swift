//
//  WishCalendarViewController.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 03.02.2024.
//

import UIKit
import CoreData

final class WishCalendarViewController: UIViewController, UICollectionViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var eventArray: [WishEvent] = []
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getWishEvents()
//        deleteWishEvents()
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Vars.backgroundColor
        navigationItem.hidesBackButton = true
        configureBackButton()
        configureAddButton()
        configureCollection()
    }
    
    private func configureAddButton() {
        let largeFont = UIFont.systemFont(ofSize: ConstCalendar.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: ConstCalendar.addButtonImage, withConfiguration: configuration)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Vars.oppositeBackgroundColor
    }
    
    private func configureBackButton() {
        let largeFont = UIFont.systemFont(ofSize: ConstCalendar.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: ConstCalendar.backButtonImage, withConfiguration: configuration)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = Vars.oppositeBackgroundColor
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = .zero
            layout.minimumLineSpacing = .zero
            layout.invalidateLayout()
        }
        
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }
    
    @objc
    private func addButtonTapped() {
        let vc = WishEventCreationView()
        present(vc, animated: true, completion: nil)
        vc.didAddItem = { [weak self] (item) in
            self?.eventArray.append(item)
            self?.eventArray.sort(by: { $0.title! < $1.title! })
            self?.collectionView.reloadData()
        }
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else { return cell }
        wishEventCell.configure(with: eventArray[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = ConstCalendar.collectionSpace
        let width = (Int(collectionView.bounds.width) - ConstCalendar.coef1 * Int(spacing)) / ConstCalendar.coef2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ConstCalendar.collectionSpace
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ConstCalendar.collectionSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: ConstCalendar.edgeInsetsNum, bottom: ConstCalendar.edgeInsetsNum, right: ConstCalendar.edgeInsetsNum)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Cell tapped at index \(indexPath.item)")
    }
}

// MARK: - Core Data Requests
extension WishCalendarViewController {
    func getWishEvents() {
        let fetchRequest: NSFetchRequest<WishEvent> = WishEvent.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \WishEvent.title, ascending: true)]
        do {
            let items = try context.fetch(fetchRequest)
            eventArray = items
        } catch {
            // TODO: show alert here
        }
    }
    
    func deleteWishEvents() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = WishEvent.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            // TODO: show alert here
        }
    }
}
