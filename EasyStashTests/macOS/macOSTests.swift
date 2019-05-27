//
//  macOSTests
//  EasyStash-iOS
//
//  Created by khoa on 27/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import XCTest
import EasyStash

class macOSTests: XCTestCase {
    var storage: Storage!

    override func setUp() {
        super.setUp()

        var options = Storage.Options()
        options.searchPathDirectory = FileManager.SearchPathDirectory.cachesDirectory
        storage = try! Storage(options: options)
    }

    func testObject() {
        let users = [
            User(city: "Oslo", name: "A"),
            User(city: "Berlin", name: "B"),
            User(city: "New York", name: "C")
        ]

        do {
            try storage.save(object: users, key: "users")
            let loadedUsers = try storage.load(key: "users", as: [User].self)
            XCTAssertEqual(users, loadedUsers)

            try storage.remove(key: "users")
            XCTAssertFalse(storage.exists(key: "users"))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testImage() {
        let image = NSImage(color: NSColor.red, size: CGSize(width: 100, height: 100))

        do {
            try storage.save(object: image, key: "image")
            let loadedImage = try storage.load(key: "image")
            XCTAssertEqual(loadedImage.size, CGSize(width: 100, height: 100))

            try storage.remove(key: "image")
            XCTAssertFalse(storage.exists(key: "image"))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
