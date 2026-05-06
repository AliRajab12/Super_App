import 'dart:convert';
import 'dart:typed_data';
import 'package:asn1lib/asn1lib.dart';
import 'package:crypto/crypto.dart';

///Document for methods to get latest pins https://degreedjira.atlassian.net/wiki/spaces/PROD/pages/5740560451/SSL+PKP+Pinning+in+the+Mobile+Apps
String extractPinSHA256FromCertificate(Uint8List der) {
  final asn1Parser = ASN1Parser(der);
  final signedCert = asn1Parser.nextObject() as ASN1Sequence;
  final cert = signedCert.elements[0] as ASN1Sequence;
  final spki = cert.elements[6] as ASN1Sequence;

  // Calculate SHA-256 hash of the encoded public key
  final spkiDigest = sha256.convert(spki.encodedBytes);

  // Encode the SHA-256 hash to Base64
  String pinSHA256 = base64.encode(spkiDigest.bytes);

  return pinSHA256;
}
