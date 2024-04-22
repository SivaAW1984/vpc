module "aft" {
  source = "git@github.com:aws-ia/terraform-aws-control_tower_account_factory.git"

  # Required Parameters
  ct_management_account_id    = "953758143890"
  log_archive_account_id      = "381492256674"
  audit_account_id            = "975049967591"
  aft_management_account_id   = "975049967591"
  ct_home_region              = "us-east-1"
  tf_backend_secondary_region = "us-west-2"

  # Optional Parameters
  terraform_distribution = "oss"
  vcs_provider           = "codecommit"

  # Optional Feature Flags
  aft_feature_delete_default_vpcs_enabled = false
  aft_feature_cloudtrail_data_events      = false
  aft_feature_enterprise_support          = false
}
