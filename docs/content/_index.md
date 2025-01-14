+++
title = "Azure Verified Modules"
linkTitle = "Azure Verified Modules"
type = "home"
description = "Azure Verified Modules Test Site"
+++

{{% notice style="tip" title="New Quickstart Guides for Bicep and Terraform" %}}
**Check out our new [Quickstart Guides](/usage/quickstart/)!**

- See [Bicep Quickstart Guide](/usage/quickstart/bicep/)
- See [Terraform Quickstart Guide](/usage/quickstart/terraform/)
{{% /notice %}}

## Introduction

<div style="width:70%; margin: 0 auto;">
{{< youtube id="JbIMrJKW5N0" title="An introduction to Azure Verified Modules (AVM)" >}}
</div>

## Value Proposition

<table style="border: none; border-collapse: collapse; margin:0; padding:0;">
  <tr>
    <td style="border: none; padding:0; margin:0; width:65%">

Azure Verified Modules (AVM) is an initiative to consolidate and set the standards for what a good Infrastructure-as-Code module looks like.

Modules will then align to these standards, across languages (Bicep, Terraform etc.) and will then be classified as AVMs and available from their respective language specific registries.

AVM is a common code base, a toolkit for our Customers, our Partners, and Microsoft. It's an official, Microsoft driven initiative, with a devolved ownership approach to develop modules, leveraging internal & external communities.

Azure Verified Modules enable and accelerate consistent solution development and delivery of cloud-native or migrated applications and their supporting infrastructure by codifying Microsoft guidance (WAF), with best practice configurations.

  </td>
    <td style="border: none; margin:0; padding: 0;">
      <img src="images/avm_cycle.png" width=65% alt="AVM development cycle" style="margin:0 auto;padding: 0;">
    </td>
  </tr>
</table>

## Modules

<table style="border: none; border-collapse: collapse; margin: 0; padding: 0;">
  <tr>
    <td style="border: none; padding: 0; width:55%">
        <img src="images/avm_modules.png" width=80% alt="AVM module classifications">
    </td>
    <td style="border: none; padding: 0;">
Azure Verified Modules provides two types of modules: Resource and Pattern modules.

AVM modules are used to deploy Azure resources and their extensions, as well as reusable architectural patterns consistently.

Modules are composable building blocks that encapsulate groups of resources dedicated to one task.

- Flexible, generalized, multi-purpose
- Integrates child resources
- Integrates extension resources

AVM improves code quality and provides a unified customer experience.
    </td>
  </tr>
</table>

{{% notice style="important" %}}
AVM is owned, developed & supported by Microsoft, you may raise a GitHub issue on this repository or the module's repository directly to get support or log feature requests.

You can also log a support ticket and these will be redirected to the AVM team and the module owner(s).

See [Module Support](/help-support/module-support) for more information.
{{% /notice %}}

## Next Steps

<table style="border: none; border-collapse: collapse; margin: 0; padding: 0;">
  <tr>
    <td style="border: none; padding: 0; width:60%">

1. Review [Overview]({{% siteparam base %}}/overview/introduction)
2. Review the [Module Classification Definitions]({{% siteparam base %}}/specs/shared/module-classifications/)
3. Review the [Specifications]({{% siteparam base %}}/specs/module-specs/)
4. Review the [FAQ]({{% siteparam base %}}/faq/)
5. Learn how to [contribute to AVM]({{% siteparam base %}}/contributing/)
    </td>
    <td style="border: none; padding: 0;">

    ![AVM](images/avm_logo.png?width=10vw "AVM")

    </td>
  </tr>
</table>
