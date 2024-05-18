//
//  AppDelegate.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 17/5/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
        
        let tableNotesListNavigationController = UINavigationController(rootViewController: TableNotesListViewController())
        tableNotesListNavigationController.tabBarItem = UITabBarItem(title: "Notes", image: UIImage(systemName: "note.text"), tag: 0)
        tableNotesListNavigationController.tabBarItem.title = "Notes"
        tableNotesListNavigationController.navigationBar.prefersLargeTitles = true
        tableNotesListNavigationController.navigationItem.largeTitleDisplayMode = .always
        
        let collectionNotesListNavigationController = UINavigationController(rootViewController: CollectionNotesListViewController())
        collectionNotesListNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        collectionNotesListNavigationController.tabBarItem.badgeColor = .red
        collectionNotesListNavigationController.tabBarItem.badgeValue = "new"
        collectionNotesListNavigationController.navigationBar.prefersLargeTitles = true
        collectionNotesListNavigationController.navigationItem.largeTitleDisplayMode = .always
        
        let createNoteNavigationController = UINavigationController(rootViewController: CreateNoteViewController())
        createNoteNavigationController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "text.badge.plus"), tag: 0)
        createNoteNavigationController.tabBarItem.title = "Create New"
        createNoteNavigationController.navigationBar.prefersLargeTitles = true
        createNoteNavigationController.navigationItem.largeTitleDisplayMode = .always

        tabBarController.setViewControllers([tableNotesListNavigationController, collectionNotesListNavigationController, createNoteNavigationController], animated: true)
        tabBarController.selectedViewController = tableNotesListNavigationController
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .systemOrange
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBarAppearance.shadowColor = .black
        
        let navigationBarScrollAppearance = UINavigationBarAppearance()
        navigationBarScrollAppearance.configureWithDefaultBackground()
        navigationBarScrollAppearance.backgroundColor = .systemYellow
        navigationBarScrollAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBarScrollAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBarScrollAppearance.shadowColor = .black
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .systemOrange
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarScrollAppearance
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        return true
    }

}

