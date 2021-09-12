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
//    func getGeoPoints(centerCoordinate center: CLLocationCoordinate2D,
//                      radius: Double,
//                      result: @escaping(_ points: [Points]) -> Void) {
//        
//        // First elements is added because of unebling to query empty notIt array in some cases.
//        
//        let queries = prepareQuery(forLocation: center, withRadius: radius)
//        
//        for query in queries {
//            query.getDocuments(completion: { (snapshot, error) in
//                guard let documents = snapshot?.documents else {
//                    print("Unable to fetch snapshot data. \(String(describing: error))")
//                    result([])
//                    return
//                }
//                guard documents.count > 0 else {
//                    result([])
//                    return
//                }
//                
//                for document in documents {
//                    DispatchQueue.main.async {
//                        self.coreDatabase.addPoint(latitude: document.data()["lat"] as? Double ?? 0,
//                                                   longitude: document.data()["lng"] as? Double ?? 0,
//                                                   materials: document.data()["trash_types"] as? [Int] ?? [0],
//                                                   geohash: document.data()["geohash"] as? String ?? "",
//                                                   id: document.documentID, result: { (point) in
//                                                    result(point)
//                        })
//                    }
//                }
//            })
//        }
//    }
    
    func getGeoPoints(centerCoordinate center: CLLocationCoordinate2D,
                      radius: Double,
                      result: @escaping(_ points: [Point]) -> Void) {
        
        // First elements is added because of unebling to query empty notIt array in some cases.
        
        let queries = prepareQuery(forLocation: center, withRadius: radius)
        var resultArray: [Point] = []
        
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
                    let point = Point(latitude: document.data()["lat"] as? Double ?? 0,
                                      longitude: document.data()["lng"] as? Double ?? 0,
                                      materials: document.data()["trash_types"] as? [Int] ?? [0],
                                      geohash: document.data()["geohash"] as? String ?? "",
                                      id: document.documentID)
                    resultArray.append(point)
                    result(resultArray)
//                    DispatchQueue.main.async {
//                        self.coreDatabase.addPoint(latitude: document.data()["lat"] as? Double ?? 0,
//                                                   longitude: document.data()["lng"] as? Double ?? 0,
//                                                   materials: document.data()["trash_types"] as? [Int] ?? [0],
//                                                   geohash: document.data()["geohash"] as? String ?? "",
//                                                   id: document.documentID, result: { (point) in
//                                                    result(point)
//                        })
//                    }
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
    
    
    func checkGeoPoints(centerCoordinate center: CLLocationCoordinate2D,
                        radius: Double, result: @escaping(_ points: Bool) -> Void) {
        print("checkGeoPoints")
        let queries = prepareQuery(forLocation: center, withRadius: radius)
        
        for query in queries {
            query.getDocuments(completion: { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Unable to fetch snapshot data. \(String(describing: error))")
                    result(false)
                    return
                }
                guard documents.count > 0 else {
                    result(false)
                    return
                }
                
                print("Gor documents: \(documents)")
                
                result(true)
            })
        }
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
    
    
    func createNewComment(withTitle title: String, text: String, andEmail email: String) {
        let documentData: [String: Any] = [
            "title": title,
            "text": text,
            "date": Date().onlyDate as Any,
            "email": email
        ]
        
        db.collection("comments").addDocument(data: documentData) { (err) in
            guard (err == nil) else { return }
            return 
        }
    }
    
    func createNewAskForPoints(coordinate: CLLocationCoordinate2D, radius: Double) {
        let documentData: [String: Any] = [
            "lat": coordinate.latitude,
            "lng": coordinate.longitude,
            "date": Date().onlyDate as Any,
            "radius": radius
        ]
        
        db.collection("ask_for_points").addDocument(data: documentData) { (err) in
            guard (err == nil) else { return }
            return
        }
    }
}
