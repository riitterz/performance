//
//  PromiseKitViewController.swift
//  performance-1788
//
//  Created by Macbook on 22.02.2022.
//

import UIKit
import PromiseKit
import Alamofire
import SwiftyJSON

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

enum ApplicationError: Error {
    case noUsers
    case noPosts
    case postsCouldNotBeParsed
}

class PostService {
    
    
    func getAllUsers(completion: @escaping ([User]) -> Void) {
        
        let url = "https://jsonplaceholder.typicode.com/users"
        
        AF.request(url).responseJSON { response in
            
            if let error = response.error {
                //seal.reject(error)
            }
            
            if let data = response.data {
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(users)
                    //seal.fulfill(users)
                } catch {
                    //seal.reject(ApplicationError.noUsers)
                }
            }
        }
    }

    func getAllPosts(for userId: Int, completion: @escaping ([Post]) -> Void) {
        //return Promise<[Post]> {seal in
        
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        AF.request(url).responseJSON { response in
            
            if let error = response.error {
                //seal.reject(error)
            }
            
            if let data = response.data {
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(posts)
                    //seal.fulfill(posts)
                } catch {
                    // seal.reject(ApplicationError.noPosts)
                }
            }
        }
      //}
            
    }

    func getAllUsers() -> Promise<[User]> {
        return Promise<[User]> { seal in
            
            let url = "https://jsonplaceholder.typicode.com/users"
            
            AF.request(url).responseJSON { response in
                
                if let error = response.error {
                    seal.reject(error)
                }
                
                if let data = response.data {
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        seal.fulfill(users)
                    } catch {
                        seal.reject(ApplicationError.noUsers)
                    }
                }
            }
        }
    }

    func getPosts(for userId: Int) -> Promise<[Post]> {
        
        return Promise<[Post]> {seal in
            
            let url = "https://jsonplaceholder.typicode.com/posts"
            
            AF.request(url).responseJSON { response in
                
                if let error = response.error {
                    seal.reject(error)
                }
                
                if let data = response.data {
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: data)
                        seal.fulfill(posts)
                    } catch {
                        seal.reject(ApplicationError.noPosts)
                    }
                }
            }
        }
    }
}

class PromiseKitViewController: UIViewController {
    
    let postService = PostService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postService.getAllUsers { [weak self] users in
            //
            self?.postService.getAllPosts(for: users[0].id) { posts in
                //
                self?.postService.getAllPosts(for: 1) { posts in
                //
                    self?.postService.getAllPosts(for: 1) { posts in
                    //
                        print(posts)
                    }
                }
            }
        }
        
        firstly {
            //Louder started
            postService.getAllUsers()
        }.then { users in
            self.postService.getPosts(for: users[0].id)
        }.then { users in
            self.postService.getPosts(for: 1)
        }.then { users in
            self.postService.getPosts(for: 1)
        }.ensure {
            //Louder finished
        }.done { posts in
            //Paste to UI
            print(posts)
        }.catch { error in
            print(error)
            //
        }
    }
}

