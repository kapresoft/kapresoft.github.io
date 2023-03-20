---
title: "Spring Boot Profiles & AWS Lambda: Deployment Guide"
last_modified_at:   2023-03-20 10:17:00 -0700
image: /assets/images/kapresoft1-210x.png
canonical_url: https://www.kapresoft.com/java/2019/10/20/aws-lambda-spring-boot-profiles.html
category: java
redirect_from:
- /p/aws-lambda-spring-boot-profiles.html
- /aws-lambda-spring-boot-profiles.html
description: "Using Spring Boot Profiles in AWS Lambda to define and activate configuration for each environment. Improve app deployment strategies with this guide."
---

## Overview

In this article, we will explore how to leverage the Spring Boot Profiles feature in an AWS Lambda Compute environment to configure and activate specific settings for each environment, such as development, testing, integration, and production.<!--excerpt--> Spring Boot Profiles provide a powerful mechanism for configuring applications for different deployment environments, allowing developers to define environment-specific properties, such as database credentials, caching settings, or logging levels. By using Spring Boot Profiles with AWS Lambda, developers can easily manage and switch between multiple configurations for their applications, making it easier to maintain and deploy code across different environments. In this article, we will walk through the steps to define and activate different Spring Boot Profiles in an AWS Lambda Compute environment, giving you the tools you need to build and deploy robust, scalable applications on the cloud.

### Spring Boot Profiles

Note that any spring components annotated with the following can be annotated with @Profile to limit what profile they are loaded.

- @Component (and all sub-annotations: @Controller, @Repository, @Service, etc..)
- @Configuration
- @ConfigurtionProperties 

Additional information can be found on Spring Boot Profiles here

- [https://docs.spring.io/spring-boot/docs](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-profiles)

### Activating Spring Profiles

In AWS Lambda **Environment Variables** we will be activating spring provides via environment variable **SPRING_PROFILES_ACTIVE**.
Additional profiles can also be provided using comma-separated values (i.e. prod,secure to activate both prod and secure profile).
In this scenario, spring boot AWS lambda application will be activating the configurations: application-&lt;profile&gt;.yml.  

The following AWS Lambda Console Environment variables configuration will activate the profile *prod* during execution.

<img src="https://cdngh.kapresoft.com/img/spring-profiles-lambda-env.png" alt="spring lambda profiles env"/>

### Initial Execution (Cold Starts)

AWS Lambda cold starts occur when the very first request arrives after deployment.  After the first request is
executed, the AWS Lambda instance will be available to be utilized for subsequent requests.  There is no specific
settings on how long a lambda instance will be kept but the probability of having a good chance of a cold start will
occur between 1 and 10 minutes after initialization.  

Cold start will have an initial cost **Init Duration** in addition to the **Duration** of the execution.

The Cold Start initialization for this example is 3317.31 ms and an execution of 2122.24 ms.
Subsequent executions have the duration of 2.33 ms (and zero-cost initialization) which is significantly faster.
 
```text
REPORT RequestId: e74bf096-cb73-4b3f-91b3-562ffaf74483 
    Duration: 2122.24 ms 
    Billed Duration: 2200 ms 
    Memory Size: 320 MB 
    Max Memory Used: 161 MB 
    Init Duration: 3317.31 ms
```

### Subsequent Executions
```text
REPORT RequestId: 3bfcb1ba-c9ef-40b0-9e45-f0d1e9d78f7c	
    Duration: 2.33 ms	
    Billed Duration: 100 ms	
    Memory Size: 320 MB	
    Max Memory Used: 161 MB
```

**Lamba Documentation can be found here in AWS:**

- https://docs.aws.amazon.com/lambda/latest/dg/running-lambda-code.html

### AWS Console Log (Cold Start)

```text
=========================================================
:: Spring Boot ::

:: app :: Lambda Spring Boot :: v0.0.1
:: java.version :: 1.8.0_201
:: active profile :: prod
=========================================================

START RequestId: e74bf096-cb73-4b3f-91b3-562ffaf74483 Version: $LATEST
2019-10-20 22:11:35.059 INFO 1 --- [ main] c.k.demo.springbootlambda.Lambda : Active Profile(s): prod
2019-10-20 22:11:35.360 INFO 1 --- [ main] c.k.demo.springbootlambda.Lambda : House: Stark
2019-10-20 22:11:35.361 INFO 1 --- [ main] c.k.demo.springbootlambda.Lambda : Motto: Winter is Coming!
2019-10-20 22:11:36.080 INFO 1 --- [ main] c.k.demo.springbootlambda.Lambda : Input: {
"key1" : "value1",
"key2" : "value2",
"key3" : "value3"
}
2019-10-20 22:11:36.261 INFO 1 --- [ main] c.k.demo.springbootlambda.Lambda : Context: lambdainternal.api.LambdaContext@c8c12ac[
memoryLimit=320
awsRequestId=e74bf096-cb73-4b3f-91b3-562ffaf74483
logGroupName=/aws/lambda/spring-boot-demo
logStreamName=2019/10/20/[$LATEST]c0b0b9e1fc1a44c8ad26ae98cdf13d2f
functionName=spring-boot-demo
functionVersion=$LATEST
invokedFunctionArn=arn:aws:lambda:us-west-2:174239531130:function:spring-boot-demo
cognitoIdentity=lambdainternal.api.LambdaCognitoIdentity@4550bb58
clientContext=<null>
logger=lambdainternal.api.LambdaContextLogger@4ec4f3a0
]
2019-10-20 22:11:36.262 INFO 1 --- [ main] c.k.demo.springbootlambda.Lambda : AppContext: org.springframework.context.annotation.AnnotationConfigApplicationContext@7c30a502, started on Sun Oct 20 22:11:32 UTC 2019
2019-10-20 22:11:36.620 INFO 1 --- [ main] c.k.demo.springbootlambda.Lambda : Response: {
"status" : "success"
}
END RequestId: e74bf096-cb73-4b3f-91b3-562ffaf74483
REPORT RequestId: e74bf096-cb73-4b3f-91b3-562ffaf74483 Duration: 2122.24 ms Billed Duration: 2200 ms Memory Size: 320 MB Max Memory Used: 161 MB Init Duration: 3317.31 ms
```

### Lambda Source Code in Github

[Spring Boot AWS Lambda.java](https://github.com/kapresoft/spring-boot-aws-lambda/blob/master/src/main/java/com/kapresoft/demo/springbootlambda/Lambda.java) source code is available 
in [github](https://github.com/kapresoft/spring-boot-aws-lambda).

