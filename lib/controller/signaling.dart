import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class SignalingController {
  //stun and turn server configuration
  Map<String, dynamic> configuration = {
    "iceServers": [
      {
        "urls": [
          "stun:stun1.l.google.com:19302",
          "stun:stun2.l.google.com:19302"
        ]
      },
      {
        "urls": 'turn:openrelay.metered.ca:80',
        "username": 'openrelayproject',
        "credentials": 'openrelayproject'
      },
      {
        "url": 'turn:numb.viagenie.ca',
        "credential": 'muazkh',
        "username": 'webrtc@live.com'
      },
      {
        "url": 'turn:192.158.29.39:3478?transport=udp',
        "credential": 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
        "username": '28224511:1379330808'
      },
      {
        "url": 'turn:192.158.29.39:3478?transport=tcp',
        "credential": 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
        "username": '28224511:1379330808'
      },
      {
        "url": 'turn:turn.bistri.com:80',
        "credential": 'homeo',
        "username": 'homeo'
      },
      {
        "url": 'turn:turn.anyfirewall.com:443?transport=tcp',
        "credential": 'webrtc',
        "username": 'webrtc'
      }
    ]
  };

  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createRoom(RTCVideoRenderer remoteRender) async {
    DocumentReference roomRef = _db.collection("rooms").doc();
    print("Print peer connection with configuration: $configuration");
    peerConnection = await createPeerConnection(configuration);
    registerPeerConnectionListeners();
    localStream!.getTracks().forEach((track) {
      peerConnection!.addTrack(track, localStream!);
    });

    //TODO: Code for collecting Ice candidates below
    var callerCandidateConnection = roomRef.collection("callerCandidates");
    peerConnection!.onIceCandidate = (candidate) {
      print("got ice candidate: ${candidate.toMap()}");
      callerCandidateConnection.add(candidate.toMap());
    };

    //TODO: add code for creating a room
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);

    Map<String, dynamic> roomWithOffer = {"offer": offer.toMap()};
    await roomRef.set(roomWithOffer);
    var roomId = roomRef.id;

    peerConnection!.onTrack = (event) {
      print("got remote track: ${event.streams[0]}");
      event.streams[0].getTracks().forEach((track) {
        print("Add a track to the remote stream: $track");
        remoteStream!.addTrack(track);
      });
    };

    //TODO: Listening for remote session Description below
    roomRef.snapshots().listen((snapshot) async {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (peerConnection!.getRemoteDescription() != null &&
          data["answer"] != null) {
        var answer = RTCSessionDescription(
            data["answer"]["sdp"], data["answer"]["type"]);

        await peerConnection!.setRemoteDescription(answer);
      }
    });

    //TODO: Listen for remote ice candidates below
    roomRef
        .collection("receiverCandidate")
        .snapshots()
        .listen((snapshot) async {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
          print("Got new remote ice candidate: ${jsonEncode(data)}");
          peerConnection!.addCandidate(RTCIceCandidate(
              data["candidate"], data["sdpMid"], data["sdpMLineIndex"]));
        }
      });
    });

    return roomId;
  }

  Future<void> joinRoom(String roomId, RTCVideoRenderer remoteVideo) async {
    DocumentReference roomRef = _db.collection("rooms").doc(roomId);
    var roomSnapshot = await roomRef.get();
    print("Got room ${roomSnapshot.exists}");
    if (roomSnapshot.exists) {
      print("Print peer connection with configuration: $configuration");
      peerConnection = await createPeerConnection(configuration);
      registerPeerConnectionListeners();
      localStream!.getTracks().forEach((track) {
        peerConnection!.addTrack(track, localStream!);
      });
      //TODO: Code for collecting Ice candidates below
      var receiverCandidateConnection = roomRef.collection("receiverCandidate");
      peerConnection!.onIceCandidate = (candidate) {
        print("got ice candidate: ${candidate.toMap()}");
        receiverCandidateConnection.add(candidate.toMap());
      };

      peerConnection!.onTrack = (event) {
        print("got remote track: ${event.streams[0]}");
        event.streams[0].getTracks().forEach((track) {
          print("Add a track to the remote stream: $track");
          remoteStream!.addTrack(track);
        });
      };

      //TODO: Code for creating SDP answer below
      var data = roomSnapshot.data() as Map<String, dynamic>;
      var offer = data["offer"];

      await peerConnection!.setRemoteDescription(
          RTCSessionDescription(offer["sdp"], offer["type"]));

      var answer = await peerConnection!.createAnswer();
      await peerConnection!.setLocalDescription(answer);

      Map<String, dynamic> roomWithAnswer = {
        "answer": {"type": answer.type, "sdp": answer.sdp}
      };
      await roomRef.update(roomWithAnswer);

      //TODO: Listening for remote ice candidates below
      roomRef
          .collection("callerCandidates")
          .snapshots()
          .listen((snapshot) async {
        snapshot.docChanges.forEach((change) {
          if (change.type == DocumentChangeType.added) {
            Map<String, dynamic> data =
                change.doc.data() as Map<String, dynamic>;
            print("Got new remote ice candidate: ${jsonEncode(data)}");
            peerConnection!.addCandidate(RTCIceCandidate(
                data["candidate"], data["sdpMid"], data["sdpMLineIndex"]));
          }
        });
      });
    }
  }

  Future<void> openUserMedia(
      RTCVideoRenderer localVideo, RTCVideoRenderer remoteVideo) async {
    try {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        status = await Permission.microphone.request();
        if (status.isGranted) {
          var stream = await navigator.mediaDevices
              .getUserMedia({'video': true, 'audio': true});
          localVideo.srcObject = stream;
          localStream = stream;
          remoteVideo.srcObject = await createLocalMediaStream("key");
        } else {
          print('Microphone permission not granted');
        }
      } else {
        print('Camera permission not granted');
      }
    } catch (e) {
      print('Error opening user media: $e');
    }
  }

  Future<void> hangUP(RTCVideoRenderer localVideo) async {
    List<MediaStreamTrack> tracks = localVideo.srcObject!.getTracks();
    tracks.forEach((track) {
      track.stop();
    });

    if (remoteStream != null) {
      remoteStream!.getTracks().forEach((track) {
        track.stop();
      });
    }
    if (peerConnection != null) {
      peerConnection!.close();
    }
    if (roomId != null) {
      var roomRef = _db.collection("rooms").doc("$roomId");
      var receiverCandidateConnection =
          await roomRef.collection("receiverCandidate").get();
      receiverCandidateConnection.docs.forEach((document) {
        document.reference.delete();
      });
      var callerCandidateConnection =
          await roomRef.collection("callerCandidates").get();
      callerCandidateConnection.docs.forEach((document) {
        document.reference.delete();
      });
      await roomRef.delete();
    }
    localStream!.dispose();
    remoteStream!.dispose();
  }

  void registerPeerConnectionListeners() {
    peerConnection!.onIceGatheringState =
        (state) => print("Ice gathering state change: $state");
    peerConnection!.onSignalingState =
        (state) => print("Signaling state change: $state");
    peerConnection!.onConnectionState =
        (state) => print("Connection state change: $state");

    peerConnection!.onAddStream = (stream) {
      print("Add remote stream");
      onAddRemoteStream!.call(stream);
      remoteStream = stream;
    };
  }
}
