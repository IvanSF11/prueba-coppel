//
//  HomeCollectionViewCell.swift
//  prueba-coppel
//
//  Created by Pedro Soriano on 27/09/22.
//

import UIKit

protocol delegateHomeViewCell: AnyObject {
    func imageTaped(index: Int, type: String)
    func imageNotTaped(index: Int, type: String)
}

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    let today = Date()
    var isFavoriteTaped: Bool = false
    var type: String = ""
    
    weak var delegate: delegateHomeViewCell?
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var favImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addfavorite.png", in: Bundle(for: HomeViewController.self), compatibleWith: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelColor
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelColor
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 11.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var averangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelColor
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Init Cell Movies
    func setup(data: Movie?, localData: [MoviesValue]?) {
        type = "movie"
        favImage.isHidden = false
        setViewCell()
        setConstraints()
        addGestureImage()
        guard let movie = data else { return }
        profileImageView.downloaded(from: movie.posterURL, contentMode: .scaleToFill)
        nameLabel.text = movie.title
        dateLabel.text = today.getDate(date: movie.releaseDate)
        averangeLabel.text = movie.voteAveragePercentText
        descriptionLabel.text = movie.overview
        guard let local = localData else { return }
        for dataL in local{
            let id = Int(dataL.id)
            if id == movie.id {
                isFavoriteTaped = true
                favImage.image = UIImage(named: "favorite.png", in: Bundle(for: HomeViewController.self), compatibleWith: nil)
            }
        }
    }
    
    //MARK: Init Cell TV
    func setupTV(data: TV?, localData: [MoviesValue]?) {
        type = "tv"
        favImage.isHidden = false
        setViewCell()
        setConstraints()
        addGestureImage()
        guard let movie = data else { return }
        profileImageView.downloaded(from: movie.posterURL, contentMode: .scaleToFill)
        nameLabel.text = movie.name
        dateLabel.text = today.getDate(date: movie.firstAirDate)
        averangeLabel.text = movie.voteAveragePercentText
        descriptionLabel.text = movie.overview
        guard let local = localData else { return }
        for dataL in local{
            let id = Int(dataL.id)
            if id == movie.id {
                isFavoriteTaped = true
                favImage.image = UIImage(named: "favorite.png", in: Bundle(for: HomeViewController.self), compatibleWith: nil)
            }
        }
    }
    
    //MARK: Init Cell Detail TV
    func setupDetailTV(data: CreatedBy?) {
        favImage.isHidden = true
        setViewCell()
        setConstraints()
        guard let detail = data else { return }
        profileImageView.downloaded(from: detail.posterURL, contentMode: .scaleToFill)
        nameLabel.text = detail.name
        dateLabel.text = detail.creditID
    }
    
    //MARK: Init Cell Detail Movie
    func setupDetailMovie(data: ProductionCompanyMovie?) {
        favImage.isHidden = true
        setViewCell()
        setConstraints()
        guard let detail = data else { return }
        profileImageView.downloaded(from: detail.posterURL, contentMode: .scaleToFill)
        nameLabel.text = detail.name
        dateLabel.text = detail.originCountry
    }
    
    //MARK: Init Cell Profile
    func setupDetailMovie(data: MoviesValue?) {
        favImage.isHidden = true
        setViewCell()
        setConstraints()
        guard let detail = data else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let date = dateFormatter.date(from: detail.releaseDate) ?? Date()
        profileImageView.downloaded(from: detail.posterURL, contentMode: .scaleToFill)
        nameLabel.text = detail.title
        dateLabel.text = today.getDate(date: date)
        descriptionLabel.text = detail.overview
    }
    
    //MARK: Add Gesture Image Favorite
    func addGestureImage(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favImage.isUserInteractionEnabled = true
        favImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if !isFavoriteTaped {
            isFavoriteTaped = true
            favImage.image = UIImage(named: "favorite.png", in: Bundle(for: HomeViewController.self), compatibleWith: nil)
            delegate?.imageTaped(index: favImage.tag, type: type)
        }else {
            isFavoriteTaped = false
            favImage.image = UIImage(named: "addfavorite.png", in: Bundle(for: HomeViewController.self), compatibleWith: nil)
            delegate?.imageNotTaped(index: favImage.tag, type: type)
        }
    }

    
    //MARK: Set View Cell
    private func setViewCell(){
        layer.cornerRadius = 8.0
        backgroundColor = UIColor(red: 0.10, green: 0.15, blue: 0.18, alpha: 1.00)
    }
    
    // MARK: Add Constraints
    private func setConstraints(){
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(averangeLabel)
        addSubview(descriptionLabel)
        addSubview(favImage)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60),
            profileImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            averangeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            averangeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -5)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            favImage.topAnchor.constraint(equalTo: topAnchor),
            favImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            favImage.heightAnchor.constraint(equalToConstant: 40),
            favImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension HomeCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
