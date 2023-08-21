//
//  PermissionManager.swift
//  Owori
//
//  Created by 신예진 on 8/21/23.
//

import AVFoundation
import Photos

class PermissionManager : ObservableObject {
    @Published var permissionGranted = false
    @Published var isPermissionDenied = false
    @Published var isPermissionRequested = false
    @Published var isAlbumPermissionDenied = false
    @Published var isAlbumPermissionGranted = false
    
    /**
     * 카메라 권한을 요청합니다.
     */
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("Camera: 권한 허용")
            } else {
                print("Camera: 권한 거부")
            }
        })
    }
    
//    func requestAlbumPermission() {
//        PHPhotoLibrary.requestAuthorization { status in
//            switch status {
//            case .authorized:
//                print("앨범 권한 승인됨")
//            case .denied, .restricted:
//                print("앨범 권한 거부됨")
//            case .notDetermined:
//                print("앨범 권한 미결정")
//            @unknown default:
//                print("알 수 없는 상태")
//            }
//        }
//    }
    
    func requestAlbumPermission() {
            PHPhotoLibrary.requestAuthorization { [weak self] state in
                DispatchQueue.main.async {
                    self?.isPermissionDenied = state == .denied
                    self?.isAlbumPermissionDenied = state == .denied
                    self?.isAlbumPermissionGranted = state == .authorized // Set the album permission granted state
                    self?.permissionGranted = state == .authorized
                }
            }
        }
    
}
