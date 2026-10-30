class UserProfile {
  final String uid;
  final String fullName;
  final String username;
  final String email;
  final String address;
  final String? photoUrl;

  const UserProfile({
    required this.uid,
    required this.fullName,
    required this.username,
    required this.email,
    required this.address,
    this.photoUrl,
  });

  factory UserProfile.fromMap(String uid, Map<String, dynamic> m) {
    return UserProfile(
      uid: uid,
      fullName: (m['fullName'] ?? '') as String,
      username: (m['username'] ?? '') as String,
      email: (m['email'] ?? '') as String,
      address: (m['address'] ?? '') as String,
      photoUrl: m['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'username': username,
        'email': email,
        'address': address,
        'photoUrl': photoUrl,
      };
}
