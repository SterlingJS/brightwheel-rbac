# Brightwheel RBAC Exercise

This project uses terraform to provide an RBAC solution for CloudFront, EKS and Redshift resources.

# Overview

This solution first divides the three environments into two categories: Nonprod and Production. I classified both 'dev' and 'qa' as Nonprod while 'prod' was designated Production. I then created two IAM Groups for each Engineering team (other than the SREs) that mapped to Nonprod and Prod respectively. Nonprod and Prod were seperated to allow new team members access to lower environment resources during an initial learning period before enabling full production access. Contractors or junior team members may only require access to the lower environments, so their access can be tailored accordingly using the Nonprod groups. I also enabled global service events to allow Cloudtrail to capture IAM event logs.

Team | Group | Resource | Environment
---|---|---|---
Frontend | Frontend Nonprod | Cloudfront | dev, qa
Frontend | Frontend Prod | Cloudfront | prod
Backend | Backend Nonprod | EKS | dev, qa
Backend | Backend Prod | EKS | prod
Data | Data Nonprod | Redshift | dev, qa
Data | Data Prod | Redshift | prod
SRE | SRE All | Cloudfront, EKS and Redshift | dev, qa, prod

Finally I assigned IAM Group Policies to each group allowing Engineers access to use their respective resource type including List, Get, Describe and any other action that did not deal with the administration of resources directly. The SRE team was given full access over all three resource types.

This RBAC system ensures that Engineers can access needed resources while limiting extra permissions and preventing privilege escalation attacks.

# Adding Users

Users can be added to their team's Nonprod and/or Prod group(s) during onboarding to quickly obtain the needed resource permissions. This could be handled in the existing terraform framework using a users.tf file that contains group membership configurations.

# Assumptions

- The dev and qa environments do not contain sensitive user data unlike production. This is why I classified both as nonprod.
- This solution is standalone and does not hook into existing infrastructure
- Additional environments may be added in the future
- SREs are expected to create and maintain all infrastructure

# Run the Solution

```terraform
cd ./brightwheel-rbac
terraform init
terraform validate
terraform plan
terraform apply
```

# Given More Time

The biggest missing piece to this setup is a mapping of EKS roles to IAM users in Kubernetes like [this](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html). The Backend Engineering team needs this to be able to access the EKS clusters and it could also be accomplished in terraform by calling a eksctl script, however I ran out of time.

Some other improvements include:
- Configure JIT access for production environments
- Apply group policies on specific resource groups to avoid hard coded resource names
- Get more information on the needs of each team and create custom policies for more targeted access (Does Backend Eng need read access to Cloudfront?)
