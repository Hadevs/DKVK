//
//  PostManager.swift
//  DKVK
//
//  Created by Hadevs on 30/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import Foundation
import Firebase

final class PostManager: FirebaseManager {
	
	private override init() {}
	
	static let shared = PostManager()
	
	func createPost(from user: User, with model: CreatePostModel, completion: @escaping ItemClosure<CreatedPostResult>) {
		guard model.isFilled else {
			completion(.error("Can't create empty post"))
			return
		}
		createPost(from: user, with: model.text, image: model.image, completion: completion)
	}
	
	func createPost(from user: User, with text: String? = nil, image: UIImage? = nil, completion: @escaping ItemClosure<CreatedPostResult>) {
		if let text = text, text.isEmpty, image == nil {
			completion(.error("Can't create empty post"))
			return
		}
		
		let post = Post(text: text, imageData: image?.jpegData(compressionQuality: 0.5))
		
		guard let dictionary = post.dictionary else {
			completion(.error("Post model not dicitionary"))
			return
		}
		
		usersRef.child(user.uid).child(Keys.posts.rawValue).child(post.id).setValue(dictionary) { (error, reference) in
			if let error = error?.localizedDescription {
				completion(.error(error))
				return
			}
			
			completion(.success(post))
		}
	}
	
	func loadingAllPosts(completion: @escaping ItemClosure<LoadedPostsResult>) {
		usersRef.observe(.value) { (snapshot) in
			var result: [Post] = []
			guard let value = snapshot.value as? [String: [AnyHashable: Any]] else {
				completion(.error("Posts not exists"))
				return
			}
			let allKeys = value.keys
			allKeys.forEach({ (key) in
				if let element = value[key], let postsDictionaryArray = (element[Keys.posts.rawValue] as? [String: [AnyHashable: Any]]) {
					let posts = postsDictionaryArray.compactMap { try? Post.init(from: $0.value) }
					result.append(contentsOf: posts)
				}
			})
			
			result.sort(by: { (post1, post2) -> Bool in
				return post1.dateUnix < post2.dateUnix
			})
			
			completion(.success(result))
		}
	}
}

extension PostManager {
	fileprivate enum Keys: String {
		case posts
	}
	
	enum LoadedPostsResult {
		case success([Post])
		case error(String)
	}
	
	enum CreatedPostResult {
		case success(Post)
		case error(String)
	}
}
