// resource "google_kms_key_ring" "sops_key_ring" {
//   name     = "sops"
//   location = "global"
//   lifecycle {
//     prevent_destroy = true
//   }
// }
// resource "google_kms_crypto_key" "sops_crypto_key" {
//   name     = "sops-key"
//   key_ring = google_kms_key_ring.sops_key_ring.self_link
//   purpose = "ENCRYPT_DECRYPT"
//   version_template {
//     algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
//   }
//   lifecycle {
//     prevent_destroy = true
//   }
// }
