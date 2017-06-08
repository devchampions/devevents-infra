
provider "dnsimple" {
  token    = "${var.dnsimple_token}"
  account  = "${var.dnsimple_account_id}"
}

variable "dnsimple_domain" {
  default  = "dev.events"
}

resource "dnsimple_record" "zoho_verify" {
  domain   = "${var.dnsimple_domain}"
  type     = "CNAME"
  name     = "zb14966893"
  value    = "zmverify.zoho.eu"
  ttl      = 60
}

resource "dnsimple_record" "mail1" {
  domain   = "${var.dnsimple_domain}"
  type     = "MX"
  name     = ""
  value    = "mx.zoho.eu"
  priority = 10
  ttl      = 60
}

resource "dnsimple_record" "mail2" {
  domain   = "${var.dnsimple_domain}"
  type     = "MX"
  name     = ""
  value    = "mx2.zoho.eu"
  priority = 20
  ttl      = 60
}

resource "dnsimple_record" "mail3" {
  domain   = "${var.dnsimple_domain}"
  type     = "MX"
  name     = ""
  value    = "mx3.zoho.eu"
  priority = 50
  ttl      = 60
}

resource "dnsimple_record" "zoho_spf" {
  domain   = "${var.dnsimple_domain}"
  type     = "TXT"
  name     = ""
  value    = "v=spf1 include:zoho.com ~all"
  ttl      = 60
}

resource "dnsimple_record" "zoho_dkim" {
  domain   = "${var.dnsimple_domain}"
  type     = "TXT"
  name     = "zoho._domainkey"
  value    = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXvbFJN4nXPZB95Aqr31eJ9hiMNV+d/Qw98b4m7AJo9aipCnLxh4M5Z6orgApDGqNBiUWTphhVHB8xRYFQp5qEtpTfXSqJI6McJ3vCPnC2IcswAu5kwnjuOyOFNM/3g1SIPEH+tLIR70Lt5BF6GlcvYOIa5+QD0rc4QkQ7FGhP0QIDAQAB"
  ttl      = 60
}

resource "dnsimple_record" "api_server" {
  domain   = "${var.dnsimple_domain}"
  type     = "A"
  name     = "api"
  value    = "${aws_instance.dev_events_server.public_ip}"
  ttl      = 60
}

resource "dnsimple_record" "web_cdn" {
  domain   = "${var.dnsimple_domain}"
  type     = "ALIAS"
  name     = ""
  value    = "${aws_cloudfront_distribution.dev_events_cdn_distribution.domain_name}"
  ttl      = 60
}
