//
//  CommunityViewController.swift
//  C
//
//  Created by Joseph William Santoso on 08/12/23.
//

import UIKit
import FirebaseAuth
import AVFoundation

class CommunityViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var chatData: [ChatMessage] = []
    var vm = CommunityViewModel()
    var profileVM = ProfileViewModel()
    var audioRecorder: AVAudioRecorder!
    var audioFilename: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableCell()
        setupAudioRecorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        fetchUserData()
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        if audioRecorder.isRecording {
            // Stop recording
            audioRecorder.stop()
        } else {
            // Start recording
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                audioRecorder.record()
                print("Recording started")
            } catch {
                print("Failed to start recording: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func sendImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func sendChat(_ sender: Any) {
        guard let text = chatField.text, !text.isEmpty else {
            // Handle empty text input
            return
        }
        vm.sendTextMessage(userPicture: "UserPictureURL", text: text)
        chatField.text = ""
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CommunityTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CommunityTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: ImageTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ImageTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: AudioTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AudioTableViewCell.self))
    }
    
    func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        profileVM.fetchUserData(for: userId) { [weak self] result in
            switch result {
            case .success(let userData):
                // Use the user's nickname for sending chat messages
                self?.vm.currentUserNickname = userData.nickname
                // Fetch chat data after fetching user data
                self?.fetchChatData()
            case .failure(let error):
                print("Error fetching user data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchChatData(){
        vm.fetchMessagesFromFirebase { [weak self] messages in
            // Sort the messages based on timestamp
            let sortedMessages = messages.sorted { $0.timestamp < $1.timestamp }
            
            DispatchQueue.main.async {
                self?.chatData = sortedMessages
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupAudioRecorder() {
        // Set up audio recording
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        audioFilename = documentPath.appendingPathComponent("audioRecording.wav")
        
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            print("Audio recorder error: \(error.localizedDescription)")
        }
    }
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatData[indexPath.row]
        
        switch message.contentType {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell", for: indexPath) as! CommunityTableViewCell
            cell.userName.text = message.userName
            cell.userChat.text = message.content.text
            cell.selectionStyle = .none
            return cell
            
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            cell.userName.text = message.userName
            if let imageURL = message.content.imageURL {
                cell.loadImageFromURL(imageURL)
                cell.tapAction = {[weak self] in
                    let vc = PreviewImageViewController()
                    vc.clickedImage = imageURL
                    self?.navigationController?.present(vc, animated: false)
                }
            }
            cell.selectionStyle = .none
            return cell
        case .audio:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AudioTableViewCell", for: indexPath) as! AudioTableViewCell
            cell.userName.text = message.userName
            if let audioURL = message.content.audioURL {
                cell.audioURL = URL(string: audioURL)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = chatData[indexPath.row]
        switch message.contentType{
        case .text:
            return UITableView.automaticDimension
        case .image:
            return 300
        case .audio:
            return UITableView.automaticDimension
        }
    }
}

extension CommunityViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // Upload the selected image to Firebase and get the imageURL
            vm.uploadImageToFirebase(image: selectedImage) { imageURL in
                if let imageURL = imageURL {
                    self.vm.sendImageMessage(userPicture: "UserPictureURL", imageURL: imageURL)
                } else {
                    // Handle the error during image upload
                    print("Error uploading image to Firebase")
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CommunityViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Audio recording finished successfully")
            // Upload the recorded audio to Firebase and get the audioURL
            vm.uploadAudioToFirebase(audioURL: audioFilename) { audioURL in
                if let audioURL = audioURL {
                    self.vm.sendAudioMessage(userPicture: "UserPictureURL", audioURL: audioURL)
                } else {
                    // Handle the error during audio upload
                    print("Error uploading audio to Firebase")
                }
            }
        } else {
            print("Audio recording failed")
        }
    }
}
