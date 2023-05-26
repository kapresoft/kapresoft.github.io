---
title: "Managing AWS CloudFront Using Spring Shell"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/05/26/spring-shell-aws-cloudfront.html
category: java
related: spring
description: "Manage CloudFront CDN with Spring Shell CLI. Update paths, invalidate content, optimize performance for cloud-based content management."
---

## Overview

This article explores an efficient approach to deploying static pages in [CloudFront](https://aws.amazon.com/cloudfront/) while leveraging the content delivery capabilities of AWS S3 and the convenience of _[Spring Shell](https://docs.spring.io/spring-shell/docs/3.0.2/docs/index.html)_ Command-Line Interface (CLI) using the [AWS SDK for Java](https://aws.amazon.com/sdk-for-java/).<!--excerpt--> It highlights the benefits of integrating _CloudFront_ with [AWS S3](https://aws.amazon.com/s3/), enabling businesses to optimize content delivery globally and reduce latency. 

The article emphasizes the usage of the AWS SDK for Java along with _Spring Shell_ CLI as a quicker alternative for CDN management, allowing developers to easily update _CloudFront_ Origin Paths and invalidate CDN content. 

By combining _CloudFront_, AWS S3, the AWS Java SDK, and _Spring Shell_ CLI, businesses can enhance website performance and provide a seamless user experience.

## Spring Shell: Exploring the Capabilities

_Spring Shell_ is a versatile command-line framework specifically designed to simplify the development of interactive shell applications in Java. It provides developers with a comprehensive range of tools and features that make it easy to create command-line interfaces (CLIs).

With _Spring Shell_, developers can quickly define commands, options, and arguments to build interactive applications that can be executed directly from the command prompt. This enables users to interact with the application through a text-based interface.

The framework offers essential features such as auto-completion, history management, scripting support, and tabular output formatting, which greatly enhance the development experience. It seamlessly integrates with other Spring projects, including Spring Boot and Spring Data, allowing for smooth integration with existing Java applications.

A notable advantage of _Spring Shell_ is its modular and extensible design. It provides a flexible plugin architecture that empowers developers to extend and customize the CLI with additional commands and features. This flexibility makes it well-suited for a wide range of applications, from simple administrative tools to complex interactive systems.

_Spring Shell_ is a powerful tool that empowers Java developers to create robust and user-friendly command-line applications. Its extensive feature set, seamless integration capabilities, and extensibility make it a popular choice for building CLIs within the Java ecosystem.

### Spring Shell Application vs. Web Application
Delivering a _Spring Shell_ application instead of web-based applications can be a more suitable choice for certain business needs. Unlike web-based applications that require a browser interface, a _Spring Shell_ application operates through a command-line interface, offering a streamlined and efficient user experience. This approach is particularly beneficial for businesses that prioritize automation, scripting, and quick execution of commands. 

For example, in a scenario where an organization needs to perform routine tasks or batch operations on a large scale, a _Spring Shell_ application provides a convenient and scriptable solution. It allows businesses to automate complex workflows, integrate with existing systems, and easily manage tasks through the command line, ultimately improving productivity and reducing reliance on manual web interactions.

### AWS Security with Spring Shell

A _Spring Shell_ application, similar to the security model employed by the _AWS Command Line Interface (CLI)_, offers robust security measures at the user level. It ensures that only authorized users with appropriate credentials can access and interact with the application's command-line interface. By implementing user authentication and access controls, businesses can maintain strict security standards and protect sensitive information. 

With a _Spring Shell_ application, administrators can manage user accounts, assign specific roles and permissions, and enforce secure authentication mechanisms such as username/password or API keys. This user-centric security approach adds an extra layer of protection, mitigating the risk of unauthorized access and safeguarding the application and its associated resources.

#### User-Level Security on Web-based Applications

On the contrary, implementing user-level AWS security in a web-based application can be a more complex and involved process. Web-based applications often require a comprehensive authentication and authorization system that includes handling user sessions, managing access tokens, and implementing secure communication protocols. Additionally, developers must carefully design and implement user management features, including user registration, password management, and role-based access control. 

These tasks can be time-consuming and require expertise in web application security practices. In contrast, a _Spring Shell_ application simplifies the security model by providing a command-line interface secured at the user level, which can be a more suitable and efficient solution for businesses with specific security requirements.

#### User Activity Audit

In a web-based application, implementing a user-level audit trail can be a non-trivial task that requires additional development effort. Developers need to design and implement custom logging and tracking mechanisms to capture and record user actions, user identities, and relevant metadata. This includes handling database operations, tracking user interactions, and managing log files. 

On the other hand, when using _Spring Shell_ with the AWS SDK, the user-level audit trail is automatically handled by AWS via the SDK, providing a seamless and built-in mechanism for tracking user actions and interactions with AWS services. This eliminates the need for manual implementation and simplifies the process of generating comprehensive audit trails.

## AWS CloudFront

Amazon _CloudFront_ is a leading content delivery network (CDN) service that enables efficient and reliable distribution of web content globally. As a CDN, _CloudFront_ utilizes edge locations strategically placed around the world to minimize latency and deliver content with exceptional performance.

With _CloudFront_, you can effectively manage your CDN by leveraging its powerful features and tools. The service allows you to optimize the distribution of both static and dynamic web content, ensuring fast and reliable delivery to end-users. By utilizing caching mechanisms and edge locations, _CloudFront_ reduces the load on origin servers and improves response times.

_CloudFront_ provides a range of options and commands for managing your CDN effectively. You can easily clear screens and manage the content distribution settings, including configuring caching behavior and adjusting performance parameters. The service offers logging capabilities, allowing you to monitor and analyze the performance of your CDN and make data-driven decisions.

Additionally, _CloudFront_ integrates seamlessly with other AWS services, such as Amazon S3, Spring Framework, and Maven, enabling streamlined development and deployment processes. The service supports the latest JDK 17, ensuring compatibility with modern Java applications.

When it comes to CDN management, _CloudFront_ offers debugging and logging functionalities to help diagnose and resolve issues. You can leverage these features to optimize your content delivery strategy and ensure a seamless user experience.

Amazon _CloudFront_ is a powerful CDN service that simplifies and enhances CDN management. By utilizing its advanced features, including caching, edge locations, and logging capabilities, you can effectively deliver web content with low latency and high performance. Whether you're distributing static or dynamic content, _CloudFront_ provides the tools and flexibility needed to manage your CDN efficiently.

## Example Use Case
- A Globally Hosted Static Web Content (CDN) using AWS S3 Bucket and CloudFront

In this example use case, let's explore deploying a static page in Amazon _CloudFront_ while utilizing content provided by AWS S3. We will leverage the _CloudFront_ Origin Path and CDN content invalidation to ensure a seamless deployment process. 

#### Common Operations for maintaining a CDN Includes (but not limited to):
- query existing configuration
- incremental deploy or update of content
- release entire new content
- invalidate cache (full or partial)

Using the _Spring Shell_ CLI, we can easily update the _CloudFront_ Origin Path to point to the AWS S3 bucket containing our static page content. By executing the "update Origin Path" command, we can modify the path from "/live-current" to "/live-next," ensuring that _CloudFront_ retrieves the latest version of the static page from the designated AWS S3 bucket utilizing an S3 Bucket Policy that permits public access to prefixes with pattern "/live*". 

### S3 Bucket Policy

```json
{
    "Version": "2012-10-17",
    "Id": "Public Policy",
    "Statement": [
        {
            "Sid": "Stmt1397633323327",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::cdn-bucket/live*"
        }
    ]
}
```

After updating the _CloudFront_ Origin Path, we need to invalidate the existing CDN content. This step is crucial to remove any cached versions of the previous static page and guarantee the delivery of the updated content. Through the _Spring Shell_ CLI, we issue the "invalidate CDN content" command, triggering _CloudFront_ to fetch the latest version from the updated Origin Path in the AWS S3 bucket.

AWS S3 serves as the content provider for _CloudFront_, enabling efficient storage and retrieval of static page content. By seamlessly integrating _CloudFront_ with AWS S3, we ensure optimal performance and global availability of the static page.

By combining the power of _CloudFront_, AWS S3, and the _Spring Shell_ CLI, we can efficiently deploy static pages and ensure a smooth user experience. The _CloudFront_ Origin Path update allows us to seamlessly transition to the new version of the static page, while the CDN content invalidation ensures that users receive the most up-to-date content from the AWS S3 bucket.

By leveraging the _Spring Shell_ CLI, _CloudFront_, and AWS S3, we can effectively deploy static pages by updating the _CloudFront_ Origin Path and performing CDN content invalidation. This integration between _CloudFront_ and AWS S3 provides a reliable and scalable solution for delivering static page content globally.

## Spring Shell Class: CDNCommands

### Properties:
- _objectMapper_: Used for Jackson Object mapper utilized for outputing JSON in pretty format.
- _defaultSettings_: Default settings for the application.
- _cloudFrontClient_: AWS Client type for interacting with Amazon CloudFront.

#### ObjectMapper

The object mapper is configured in [ShellConfig.java](https://github.com/kapresoft/spring-shell/blob/0dce7c46851028dd7a209a4ea89715c63e677db3/src/main/java/com/kapresoft/devops/shell/ShellConfig.java#L17-L20) for rendering response objects to JSON.

```java
@Bean
ObjectMapper objectMapper() {
    return new ObjectMapper()
        .enable(SerializationFeature.INDENT_OUTPUT);
}
```

#### DefaultSettings
The _DefaultSettings_ is a component that resolves the value of a user set environment variable _AWS_CLOUDFRONT_DIST_ID_.  This value is essentially used for all commands and makes the Distribution ID an optional argument if the environment variable is set.


```java
@Component
public class DefaultSettings {

    @Getter
    String distributionID;

   /**
    * The env AWS_CLOUDFRONT_DIST_ID is a user-defined environment variable for setting the default Distribution ID.
    */
    public DefaultSettings(@Value("#{environment.AWS_CLOUDFRONT_DIST_ID}") String distributionID) {
        this.distributionID = distributionID;
    }

}
```

### Setting Environment Variables In Linux/Unix
- Add the following export line to $HOME/.bashrc or $HOME/.zshrc

```shell
export AWS_CLOUDFRONT_DIST_ID="E1OAOW8NPJ78SQ" 
```

### Setting Environment Variables In Windows
- Navigate to [Advanced Systems](https://docs.oracle.com/en/database/oracle/machine-learning/oml4r/1.5.1/oread/creating-and-modifying-environment-variables-on-windows.html#GUID-DD6F9982-60D5-48F6-8270-A27EC53807D0) settings and select "Environment Variables" and add the following to User or System variables.

| Variable               | Value                 |
|------------------------|-----------------------|
| AWS_CLOUDFRONT_DIST_ID | E1OAOW8NPJ78SQ        |


### _resolveDistID(String distID)_
- A helper method that resolves the _CloudFront_ Distribution ID.
- Parameters:
   - _distID_: The _CloudFront_ Distribution ID.
- Returns: Resolved Distribution ID with the DefaultSettings Distribution ID as fallback.

```java
/**
  * @param distID The CloudFront Distribution-ID
  * @return String Resolves to the DefaultSettings Distribution-ID if {@code distID} is empty.
  */
 private String resolveDistID(String distID) {
     var resolvedDistID = hasLength(distID) ? distID : defaultSettings.getDistributionID();
     log.info("DistID: {}", resolvedDistID);
     return resolvedDistID;
 }
```

### _getConfig(String distID)_
- Retrieves the distribution configuration for a _CloudFront_ Distribution.
- Parameters:
   - _distID_: The _CloudFront_ Distribution ID.
- String: The _GetDistributionConfigResult_ containing the distribution configuration in JSON format.

```java
@ShellMethod(
        value = "Get CloudFront Distribution Config", 
        key = "config")
public String getConfig(
        @ShellOption(value = "dist", help = DIST_HELP, defaultValue = "") String optionalDistID) {

    var distID = resolveDistID(optionalDistID);
    if (!hasLength(distID)) {
        return "DistID was not resolved.";
    }

    DistributionConfig result;
    try {
        result = getDistributionConfig(distID).getDistributionConfig();
    } catch (AccessDeniedException | NoSuchDistributionException e) {
        return format(INVALID_DIST_ID_MSG,
                distID, e.getErrorMessage(), e.getErrorCode(), e.getStatusCode());
    }

    return objectMapper.writeValueAsString(result);
}
```

### _updatePath(String optionalDistID, String newPath)_
- Updates the _CloudFront_ distribution origin path.
- Parameters:
   - _optionalDistID_: The _CloudFront_ Distribution ID.
   - _newPath_: The new path to set.
- Returns: The command status message.

```java
@ShellMethod(
        value = "Update the CloudFront distribution origin path", 
        key = "update-path")
public String updatePath(
        @ShellOption(value = "dist", help = DIST_HELP, defaultValue = "") String optionalDistID,
        @ShellOption(value = "path", help = PATH_HELP) String newPath) {

    var distID = resolveDistID(optionalDistID);
    GetDistributionConfigResult distConfigResult = getDistributionConfig(distID);

    DistributionConfig distConfig = distConfigResult.getDistributionConfig();
    Optional<Origin> origin = distConfig.getOrigins().getItems().stream().findFirst();
    if (origin.isEmpty()) {
        return format(INVALID_CLOUD_FRONT_DISTRIBUTION_CONFIG_MSG,
                objectMapper.writeValueAsString(distConfig));
    }

    origin.get().setOriginPath(newPath);
    UpdateDistributionRequest request = new UpdateDistributionRequest()
            .withId(distID)
            .withIfMatch(distConfigResult.getETag())
            .withDistributionConfig(distConfig);
    cloudFrontClient.updateDistribution(request);

    return "Success";
}
```

### _invalidatePath(String optionalDistID, String path)_

- Invalidates a _CloudFront_ CDN origin path.
- Parameters:
   - _distID_: The _CloudFront_ Distribution ID.
   - _optionalPath_: The CDN Origin path to invalidate (Optional). Defaults to /*.
- Returns: The command status message.

```java
@ShellMethod(
        value = "Invalidate a CloudFront distribution path", 
        key = "invalidate-path")
public String invalidatePath(
        @ShellOption(value = "dist", help=DIST_HELP, defaultValue = "") String optionalDistID,
        @ShellOption(value = "path", help = PATH_HELP) String path) {

    var distID = resolveDistID(optionalDistID);

    GetDistributionConfigResult distConfigResult = getDistributionConfig(distID);

    DistributionConfig distConfig = distConfigResult.getDistributionConfig();
    Optional<Origin> origin = distConfig.getOrigins().getItems().stream().findFirst();
    if (origin.isEmpty()) {
        return format(INVALID_CLOUD_FRONT_DISTRIBUTION_CONFIG_MSG,
                objectMapper.writeValueAsString(distConfig));
    }

    InvalidationBatch batch = new InvalidationBatch()
            .withPaths(new Paths().withItems(path)
                    .withQuantity(1))
            .withCallerReference("spring-shell-aws");
    CreateInvalidationRequest request = new CreateInvalidationRequest()
            .withDistributionId(distID)
            .withInvalidationBatch(batch);
    cloudFrontClient.createInvalidation(request);

    return "Success";
}
```

## Overview of Spring Shell Commands

### Main Help

```shell
cdn:> help

AVAILABLE COMMANDS

Built-In Commands
       help: Display help about available commands
       stacktrace: Display the full stacktrace of the last error.
       clear: Clear the shell screen.
       quit, exit: Exit the shell.
       history: Display or save the history of previously run commands
       version: Show version info
       script: Read and execute commands from a file.

CDN Commands
       invalidate-path: Invalidate a CloudFront distribution path
       update-path: Update the CloudFront distribution origin path
       config: Get CloudFront Distribution Config
```

### Get Config

Retrieves the CloudFront configuration from the given distribution ID.

#### Help
```shell
cdn:> config -h

NAME
       config - Get CloudFront Distribution Config

SYNOPSIS
       config --dist String --help 

OPTIONS
       --dist String
       The CloudFront distribution ID, i.e. 'E1OAOW8NPJ78SQ' (Optional). Defaults to env var AWS_CLOUDFRONT_DIST_ID.
       [Optional] 
```

#### Error Messaging

This example error message displays when an unknown Distribution ID is supplied.

```shell
cdn:> config --dist 123

2023-05-25T15:06:04.733-07:00 DistID: 123
CDN with distID[123] failed with: The specified distribution does not exist.
  code=[NoSuchDistribution] status=[404]
```

#### Execute Command

```shell
cdn:> config --dist A1OBOX9NPJ37SQ
```
#### JSON Output

The output has been trimmed to remove certain values for brevity. The key element to focus on is the "origin" component, which holds significant importance.

```json
{
  "callerReference" : "142a4b34-863b-4d8f-9282-f28cd66f2d2a",
  "aliases" : {
    "quantity" : 1,
    "items" : [ "cdn.mysite.com" ]
  },
  "defaultRootObject" : "index.html",
  "origins" : {
    "quantity" : 1,
    "items" : [ {
      "id" : "cdn.s3.us-west-1.amazonaws.com",
      "domainName" : "cdn.s3.us-west-1.amazonaws.com",
      "originPath" : "/live-2023-May-17-01",
      "customHeaders" : {},
      "s3OriginConfig" : {},
      "customOriginConfig" : null,
      "connectionAttempts" : 3,
      "connectionTimeout" : 10,
      "originShield" : {
        "enabled" : true,
        "originShieldRegion" : "us-west-1"
      },
      "originAccessControlId" : ""
    } ]
  },
  "originGroups" : {},
  "defaultCacheBehavior" : {},
  "cacheBehaviors" : {},
  "customErrorResponses" : {},
  "comment" : "",
  "logging" : {},
  "priceClass" : "PriceClass_All",
  "enabled" : true,
  "viewerCertificate" : {
  },
  "restrictions" : {},
  "webACLId" : "",
  "httpVersion" : "http2and3",
  "isIPV6Enabled" : true,
  "continuousDeploymentPolicyId" : "",
  "staging" : false,
  "ipv6Enabled" : true
}
```
### Update Path

This command is designed to help you switch to a new release path. But before running the command, you'll need to follow a step to deploy the updated site to a new S3 bucket prefix.

#### Help

```shell
cdn:> update-path -h

NAME
       update-path - Update the CloudFront distribution origin path

SYNOPSIS
       update-path --dist String [--path String] --help 

OPTIONS
       --dist String
       The CloudFront distribution ID, i.e. 'E1OAOW8NPJ78SQ' (Optional). Defaults to env var AWS_CLOUDFRONT_DIST_ID.
       [Optional]

       --path String
       The CloudFront origin path, i.e. '/live-2023-05-25'
       [Mandatory]
```

#### Execute Command

The purpose of the following example scenario is to demonstrate the process of releasing a new version of CDN content after uploading it to a new S3 bucket prefix, with the added ability to roll back to the previously released content if needed.

To achieve a seamless transition to the newly uploaded content, the Shell Command "update-path" can be used to switch the path accordingly.

Existing Release:
- /live-2023-02-01

New Release Upload to new S3 Prefix
- /live-2023-05-25

To release the new site and instruct _CloudFront_ to direct to the new path (i.e., S3 bucket prefix), execute the following _Spring Shell_ command.

```
cdn:> update-path --dist A1OBOX9NPJ37SQ --path /live-2023-05-25
# Output
2023-05-25T14:28:21.169-07:00 DistID: A1OBOX9NPJ37SQ
Success
```

#### AWS CloudFront Console

The user can verify the update by navigating to the AWS CloudFront console and checking that the origin path on the target distribution has been successfully updated to _/live-2023-05-25_.

![spring-shell-cdn-update-path.png](https://cdngh.kapresoft.com/img/spring-shell-cdn-update-path-7fb6bb1.png
)

### Invalidate Path

The user can also invalidate the CloudFront distribution origin path to ensure that any cached content is refreshed and the latest version of the site is served. This can be done through the appropriate API or management console provided by AWS CloudFront. Invalidating the origin path allows for efficient content updates and ensures that users receive the most up-to-date version of the website when accessing it through the CloudFront CDN.

#### Help

```shell
cdn:> invalidate-path -h

#Output
NAME
       invalidate-path - Invalidate the CloudFront distribution origin path

SYNOPSIS
       invalidate-path --dist String [--path String] --help 

OPTIONS
       --dist String
       The CloudFront distribution ID, i.e. 'E1OAOW8NPJ78SQ' (Optional). Defaults to env var AWS_CLOUDFRONT_DIST_ID.
       [Optional]

       --path String
       The CloudFront origin path, i.e. '/live-2023-05-25'
       [Mandatory]

```

#### Execute Command

```shell
cdn:> invalidate-path --path /*
```

#### AWS CloudFront Console

After invalidating a path, the user can actively verify and check the status of the invalidation using the AWS Console for _CloudFront_. This can be done by navigating to the appropriate section in the console where the user can view the details and progress of the invalidation request. The console provides clear figures and information that allow the user to track the status of the invalidation and ensure that the content is properly refreshed in the _CloudFront_ CDN.

![spring-shell-invalidate.png](https://cdngh.kapresoft.com/img/spring-shell-invalidate-d8e4725.png)

Clicking on the Invalidation ID link in AWS Console will render this Details View. The invalidation path supplied in the CLI is marked as (1) in the image below.

![spring-shell-invalidate2.png](https://cdngh.kapresoft.com/img/spring-shell-invalidate2-a216fef.png)

#### Variations

There are a few variations that could improve the devops task.

##### 1. Allow Multiple Paths

This command could be modified to allow multiple paths as needed.

```shell
cdn:> invalidate --path '/image/*' --path '/docs/customer-support'
```
##### 2. Invalidation Status

A new command _invalidation-status_ could be created to show the progress of all path invalidations.

```shell
cdn:> invalidation-status
```

## In Conclusion

Deploying a static page in _CloudFront_ with the ability to update the _CloudFront_ Origin Path via _Spring Shell_ CLI and invalidate existing CDN content can greatly enhance the performance, scalability, and user experience of a web application. By leveraging the power of _AWS S3_ as a content provider and integrating CDN management capabilities offered by _CloudFront_, businesses can efficiently deliver static content to users worldwide, reducing latency and improving overall website performance.

Utilizing _Spring Shell_ as a command-line interface provides a quicker alternative to web-based solutions for managing CDN configurations. With _Spring Shell_'s flexibility and ease of use, developers can efficiently update _CloudFront_ Origin Paths, invalidate CDN content, and perform other management tasks directly from the command line, saving time and effort.

The combination of _CloudFront_, _AWS S3_, and _Spring Shell_ CLI offers a powerful and efficient solution for deploying static pages, managing CDN configurations, and delivering content globally. By embracing these tools, businesses can streamline their content delivery processes, leverage the benefits of cloud infrastructure, and provide a seamless user experience to their audience.

