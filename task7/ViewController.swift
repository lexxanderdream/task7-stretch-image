//
//  ViewController.swift
//  task6
//
//  Created by Alexander Zhuchkov on 21.02.2024.
//

import UIKit

class ViewController: UIViewController {

    // MARK: -
    static let headerHeight: CGFloat = 200

    // MARK: - Subviews
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInset.top = ViewController.headerHeight
        scrollView.verticalScrollIndicatorInsets.top = ViewController.headerHeight
        scrollView.delegate = self
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        
        return contentView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: "bg"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var topConstraint: NSLayoutConstraint?
    
    // MARK: - Helper methods
    private func setupView() {
        view.addSubview(scrollView)
        
        // Add Main Content View
        scrollView.addSubview(contentView)
        
        // Add Image
        scrollView.addSubview(imageView)
        
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentGuide.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            
            // Image Width
            contentGuide.widthAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
        
        
        imageView.bottomAnchor.constraint(equalTo: contentGuide.topAnchor).isActive = true
        self.topConstraint = imageView.topAnchor.constraint(equalTo: frameGuide.topAnchor)
        topConstraint?.isActive = true
    }
    
}


extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentInset.top + view.layoutMargins.top + scrollView.contentOffset.y

        if offset < 0 {
            scrollView.verticalScrollIndicatorInsets.top = scrollView.contentInset.top - offset
            topConstraint?.constant = 0
        } else {
            scrollView.verticalScrollIndicatorInsets.top = scrollView.contentInset.top
            topConstraint?.constant = -offset
        }
    }
}
