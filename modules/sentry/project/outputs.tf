output "public_dsn" {
  # The provider marks the public DSN as sensitive for some reason.
  # It is, however, very much not sensitive given the fact that it is public, hence the need for nonsensitive.
  value = nonsensitive(sentry_key.default.dsn["public"])
}
