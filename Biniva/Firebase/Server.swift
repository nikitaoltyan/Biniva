//
//  File.swift
//  GreenerCo
//
//  Created by Никита Олтян on 23.01.2021.
//

import Foundation
import Firebase
import GeoFire
import CoreLocation

class Server {

    /// Database reference
    let db = Firestore.firestore()
    let storage = Storage.storage(url: "gs://greener-964fe.appspot.com")
    let coreDatabase = DataFunction()

    
    /// - parameter center: the center coordinate of the showen mapView.
    /// - parameter radius: Should be in meters.
    /// - returns: Escaping parameter about function success.
    /// - warning: GeoPoints are stored in Points CoreModel and should be gotten from there.
    func getGeoPoints(centerCoordinate center: CLLocationCoordinate2D,
                      radius: Double,
                      result: @escaping(_ points: [Points]) -> Void) {
        
        // First elements is added because of unebling to query empty notIt array in some cases.
        
        let queries = prepareQuery(forLocation: center, withRadius: radius)
        
        for query in queries {
            query.getDocuments(completion: { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Unable to fetch snapshot data. \(String(describing: error))")
                    result([])
                    return
                }
                guard documents.count > 0 else {
                    result([])
                    return
                }
                
                for document in documents {
                    DispatchQueue.main.async {
                        self.coreDatabase.addPoint(latitude: document.data()["lat"] as? Double ?? 0,
                                                   longitude: document.data()["lng"] as? Double ?? 0,
                                                   materials: document.data()["trash_types"] as? [Int] ?? [0],
                                                   geohash: document.data()["geohash"] as? String ?? "",
                                                   id: document.documentID, result: { (point) in
                                                    result(point)
                        })
                    }
                }
            })
        }
    }
    

    fileprivate
    func prepareQuery(forLocation center: CLLocationCoordinate2D,
                      withRadius radius: Double) -> [Query] {
        let queryBounds = GFUtils.queryBounds(forLocation: center, withRadius: radius)
        
        let queries = queryBounds.map { bound -> Query in
            return db.collection("points")
                .order(by: "geohash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }
        
        return queries
    }
    
    
    /// Function for loading array with images URLs.
    /// - parameter pid: PointID in the server.
    /// - parameter result: escaping property with [String] image URLs.
    func getImagesArray(forPointID pid: String?, result: @escaping(_ images: [String]) -> Void) {
        guard let pid = pid else { return }
        let docRef = db.collection("points").document(pid)

        docRef.getDocument { (document, error) in
            guard (error == nil) else {
                result([])
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let imagesArray = data?["photos"] as? [String] ?? []
                result(imagesArray)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    /// This function is called when user manualy add new Bin Point.
    /// - warning: The data uploading in the separate folder for future administration.
    func createNewPoint(forCoorinate coordinate: CLLocationCoordinate2D,
                        withMaterials materials: [Int],
                        andImages images: [UIImage?]) {
        let hash = GFUtils.geoHash(forLocation: coordinate)

        let documentData: [String: Any] = [
            "geohash": hash,
            "lat": coordinate.latitude,
            "lng": coordinate.longitude,
            "trash_types": materials
        ]

        var ref: DocumentReference? = nil
        ref = db.collection("points_moderation").addDocument(data: documentData) { (err) in
            guard (err == nil) else { return }
            guard (images.count > 0) else { return }
            
            self.addPointImage(forDocumentID: ref!.documentID, images: images, result: { (imageURLs) in
                self.db.collection("points_moderation").document(ref!.documentID).updateData([
                    "photos": imageURLs
                ])
            })
        }
    }
    
    
    private
    func addPointImage(forDocumentID documentID: String, images: [UIImage?], result: @escaping(_ strings: [String]) -> Void) {
        print("addPointImage for documentID: \(documentID)")
        let storageRef = storage.reference()
        var imageURLs: [String] = []
        for image in images {
            
            guard let image = image else { return }
            
            let data = image.jpegData(compressionQuality: 0.1)
            let imageRef = storageRef.child("Points").child(documentID).child("\(NSUUID().uuidString).jpg")
            
            _ = imageRef.putData(data!, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Upload error: \(error.localizedDescription)")
                    return
                }
                
                guard metadata != nil else { return }
                
                imageRef.downloadURL { (url, error) in
                    guard let addURL = url?.absoluteString else { return }
                    
                    imageURLs.append(addURL)
                    
                    if imageURLs.count == images.count {
                        result(imageURLs)
                    }
                }
                
            }
        }
    }

    
    func getArticleText(forArtcileWithID aid: String, completion: @escaping(_ text: String) -> Void) {
//        db.collection("articles").document(aid).getDocument(completion: { (document, error)  in
//            guard error == nil else {
//                completion("")
//                return
//            }
//
//            if let document = document, document.exists {
//                let data = document.data()
//
                do {
//                    let text = try String(contentsOf: URL(string: data?["text"] as? String ?? " ")!, encoding: .utf8) // here should be link on error message?
                    let text = try String(contentsOf: URL(string: "https://firebasestorage.googleapis.com/v0/b/greener-964fe.appspot.com/o/Articles%2Ftest.txt?alt=media&token=20cb70db-f869-497e-ba45-8794735b3886")!, encoding: .utf8)
                    completion(text)
                } catch _ {
                    print("Catch an error")
                    completion("")
                }
//            } else {
//                print("Document does not exist")
//                completion("")
//            }
//        })
    }

    
    func createNewPhotoData(_ image: UIImage, forMaterial material: Int, andWeight weight: Int) {

        let documentData: [String: Any] = [
            "trash_type": material,
            "weight": weight,
            "date": Date().onlyDate as Any
        ]
        
        var ref: DocumentReference? = nil
        ref = db.collection("camera_data").addDocument(data: documentData) { (err) in
            guard (err == nil) else { return }
            
            self.addCameraImage(forDocumentID: ref!.documentID, image: image, result: { (imageURL) in
                self.db.collection("camera_data").document(ref!.documentID).updateData([
                    "photo": imageURL
                ])
            })
        }
        
    }
    
    
    private
    func addCameraImage(forDocumentID documentID: String, image: UIImage, result: @escaping(_ strings: String) -> Void) {
        print("addCameraImage for documentID: \(documentID)")
        let storageRef = storage.reference()

        let data = image.jpegData(compressionQuality: 0.3)
        let imageRef = storageRef.child("Camera Data").child(documentID).child("\(NSUUID().uuidString).jpg")
            
        _ = imageRef.putData(data!, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Upload error: \(error.localizedDescription)")
                return
            }
                
            guard metadata != nil else { return }
                
            imageRef.downloadURL { (url, error) in
                guard let URL = url?.absoluteString else { return }
                    
                result(URL)
            }
        }
    }
    
    
    func createNewComment(withTitle title: String, andText text: String) {
        let documentData: [String: Any] = [
            "title": title,
            "text": text,
            "date": Date().onlyDate as Any
        ]
        
        db.collection("comments").addDocument(data: documentData) { (err) in
            guard (err == nil) else { return }
            return 
        }
    }
}
