//
//  SceneDelegate.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        self.window?.windowScene = windowsScene
        self.window?.makeKeyAndVisible()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 150, height: 160)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        flowLayout.minimumInteritemSpacing = 20
        
        
        let mainViewController = Builder.createAlbumSerachController()
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        self.window?.rootViewController = navigationViewController
    }


}

