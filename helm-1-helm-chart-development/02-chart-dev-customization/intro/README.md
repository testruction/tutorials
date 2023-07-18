## Deploy a Simple Web Application

> This module is the continuation of the [01. Helm chart development (Initialization)]().
> From a learning perspective, it is highly recommended to complete this module before starting to this one.
> However, this course is designed to run any modules in any order.

The previous module consited in initializing a chart for new application composed of a backend and frontend application.
But their is still some work to do in order to get it deployed.

### Learning objectives

The objective of this course is to learn how to:

- Update the chart logic due to the application component segregation.
- Implement dedicated environment variables required for the component networking.
- Secure credentials to access the database
- Add dependent charts to deploy the database and monitoring third party services.
- Get more hands-on experience on `git`, `sed`, `vi` and `yq` tools

### References

The following sources were used to build this lab.

- Helm official documentation: <https://helm.sh/docs/>
- Argo-CD official chart: <https://artifacthub.io/packages/helm/argo/argo-cd>
