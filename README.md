# Backstage.io User Guide for IAG's Developer Portal

## Introduction to Backstage
## [CI/CD Process Documentation](docs/ci_cd_process.md)
**Backstage.io** is an open platform for building developer portals, unifying infrastructure tooling, services, and documentation to create a streamlined development environment. It benefits developers by enhancing efficiency and simplifying the management of applications and services.

## Getting Started with Backstage
Begin using Backstage for IAG's Developer Portal by setting up the necessary infrastructure:

### Clone the Infrastructure Repository
```bash
git clone https://github.com/tudark179/backstage-terraform.git
cd backstage-terraform
```
## Infrastructure Setup
Navigate to the terraform directory and follow the instructions to set up your AWS infrastructure using Terraform. Ensure you have the necessary permissions and configurations for AWS.

## Running Backstage
Once the infrastructure is in place, refer to the official Backstage documentation for steps to run and access the Backstage application: [Backstage Getting Started](https://backstage.io/docs/getting-started/).

## Navigating the Backstage UI
The Backstage interface is designed for ease of use:

## Homepage: Displays an overview of available services and applications.
Service Catalog: Manage and browse through the software components.
Documentation: Access all the relevant project documentation.
Explore the sidebar in the UI for more features and functionalities.

## Using Backstage Templates
To streamline project creation:

## Navigate to 'Create' Section
In the UI, find the templates available for use.

## Select and Fill in Template Details
Choose a template suitable for your project and fill in the required information.

## Scaffold Projects
Use the template to generate new components as per your project needs.

Note: Custom template creation can be referenced from the [Backstage Documentation](https://backstage.io/docs/features/software-templates/creating-templates).

## Customization and Configuration
For customizing Backstage:

Configuration: While this repository doesn't include app-config.yaml, you can create and configure it as per your needs following the [Configuration Documentation](https://backstage.io/docs/conf/).

**Plugins:** Enhance Backstage by adding plugins. Refer to the [Plugin Marketplace](https://backstage.io/plugins).
Troubleshooting and FAQs
Address common hurdles:

**Problem Solving:** For any issues, first refer to the [Troubleshooting Guide](https://backstage.io/docs/overview/troubleshooting).
**FAQs:** Regularly updated FAQs can be found in the [Backstage Documentation](https://backstage.io/docs/faq).
**Contact and Support**
Reach out for help or to contribute:

**Community Support:** Join the [Backstage Community](https://backstage.io/community) for support.
**GitHub Repository:** For specific issues or enhancements, visit the [repository's issues section](https://github.com/tudark179/backstage-terraform/issues).
