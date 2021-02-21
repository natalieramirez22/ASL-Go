//
//  AlphabetViewController.swift
//  ASL
//
//  Created by Gauri Pala on 2/20/21.
//

import UIKit
import AVKit
import AVFoundation
import Vision

class AlphabetViewController:UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate{
    
    @IBOutlet weak var predLabel: UILabel!
    
    var prediction:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start up the camera
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        //add camera preview layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = UIScreen.main.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        let outputLabel:UIView = predLabel
        view.addSubview(outputLabel)
        
        
        //get each frame
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let model = try? VNCoreMLModel(for: ASL_Classifier().model) else {return}
        let request = VNCoreMLRequest(model: model) { (finishedReq, error) in
            guard let results = finishedReq.results as? [VNRecognizedObjectObservation] else { return }
            
            guard let firstObv = results.first else { return }
           
            
            DispatchQueue.main.async {
                self.predLabel.text = firstObv.labels[0].identifier
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }

}
    
    

