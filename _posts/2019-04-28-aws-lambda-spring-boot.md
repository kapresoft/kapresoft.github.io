---
title: "AWS Lambda with Spring Boot: A Comprehensive Guide"
title_style: titlew
image: /assets/images/kapresoft1-210x.png
canonical_url: https://www.kapresoft.com/java/2019/04/28/aws-lambda-spring-boot.html
category: java
redirect_from:
- /p/aws-lambda-spring-boot.html
- /aws-lambda-spring-boot.html
description: "Learn how to deploy and manage your application on the AWS cloud with AWS Lambda and Spring Boot integration. Discover the benefits in this guide."
---

## Overview

This article explores the benefits of using Spring Boot with AWS Lambda, a powerful serverless compute service that enables developers to run code without worrying about server management. By integrating with the AWS cloud, AWS Lambda can respond to a variety of AWS events, such as S3, Messaging Gateways, API Gateway, and other generic AWS Resource events, providing an efficient and scalable solution for your application needs.  

<!--excerpt-->

## AWS Lambda Serverless Compute Environment

The benefit of invoking code in an AWS Lambda environment is that you are only paying for compute services at the time a request is being processed. This particular time of adhoc on-demand service alleviates the pain points of spinning up and maintain your own infrastructure services.

## Why Spring Boot?

Think of Spring Boot as an extension of the [Spring Framework](https://spring.io/projects/spring-framework) which provides bootstraps to eliminate boilerplate or ceremonial configurations.  Spring Framework is a framework that allows you to wire application components together.  Spring utilizes dependency injection or as others may call it, Inversion of Control (IoC).  Dependency Injection provides a consistent way of configuring and managing components which makes your code less dependent on the container than it would be in a traditional enterprise development. On top of other main features, spring has excellent support and advocates for unit and integration testing and best practices. 

Spring Boot is implemented to have you up and running as quickly as possible with fewer upfront configuration. The [Spring Boot Initializr](https://start.spring.io/) online tool can help you kickstart your app.  Spring Boot together with AWS Lambda, allows developers to focus more on business logic and less time supporting server infrastructures.

## Spring Boot Performance

>Is Spring Boot too slow or too bloated to run in AWS Lambda?

The modern spring framework is lightweight and has been broken up into different components.  You only need to import the components you need.  Take a look at the example [Cloud Watch Log](https://cdngh.kapresoft.com/img/spring-boot-demo-cloudwatch-log.gif) running a base example app and you will see that the framework loads in 2 to 5 seconds.  

When running a Lambda code there are a couple of things that you need to be mindful of:
1. Cold Start
2. Subsequent Execution of Code

### Cold Start

The Cold Start is essentially the cost or latency incurred when a first request comes in after deployment. After the first request is process, the instance is alive and will be reused for subsequent incoming requests.  When the instance is idle there is a probability that it will be recycled and for the purpose of this article, we will not cover this topic of recycling here.

### The Subsequent Execution of Code

After the cost of Cold Start is incurred, the lambda code is up and running and is ready to take tons of requests.  The lambda instance at this state should be running optimally with no startup costs unless the instance is recycled.

## Repository

While going through this article, the example code will be referenced in this github repository [https://github.com/kapresoft/spring-boot-aws-lambda](https://github.com/kapresoft/spring-boot-aws-lambda).  You may follow or navigate directly to the source located here.

## Handler function

In order to invoke a code (or a lambda function), we need to specify a handler in the AWS Lambda configuration. For this specific example, the Handler in the AWS Lambda config page is specified as:

```
com.kapresoft.demo.springbootlambda.Lambda::handler
```

## Constructor Initialization

See: [Lambda.java](https://github.com/kapresoft/spring-boot-aws-lambda/blob/master/src/main/java/com/kapresoft/demo/springbootlambda/Lambda.java) in github

In this example, the AWS Lambda function code manually initializes Spring Boot using the SpringApplicationBuilder. The constructor code below creates the builder and sets up the spring active profiles.  Notice that after the constructor initialization, all the dependent objects needed by this lambda have been assigned as instance fields.

```java
public class Lambda {

    private final Logger log = LoggerFactory.getLogger(Lambda.class);
    
    private final ConfigurableApplicationContext appContext;
    private final ConfigurableEnvironment environment;
    private final JsonUtils jsonUtils;

    public Lambda() {
        final SpringApplicationBuilder builder = new SpringApplicationBuilder(Application.class)
                .logStartupInfo(false);
        // Retrieve dependent components from the application context
        appContext = builder.build().run();
        environment = appContext.getEnvironment();
        jsonUtils = appContext.getBean(JsonUtils.class);
    }

    public LambdaResponse handler(Map<String, Object> request, Context context) {
        log.info("Active Profile(s): {}", arrayToCommaDelimitedString(environment.getActiveProfiles()));
        log.info("House: {}", environment.getProperty("motto.house"));
        log.info("Motto: {}", environment.getProperty("motto.message"));
        log.info("Input: {}", jsonUtils.toJson(request));
        log.info("Context: {}", ofNullable(context).map(c -> ReflectionToStringBuilder.toString(c, ToStringStyle.MULTI_LINE_STYLE))
                .orElse(null));
        log.info("AppContext: {}", appContext);

        final LambdaResponse response = LambdaResponse.builder().status("success").build();
        log.info("Response: {}", jsonUtils.toJson(response));
        return response;
    }

}
```

## Use of Environment Variables in Lambda

Setting the environment variables to set the spring active profile is a good way to run your lambda in different environments. In this example, we will need to specify an environment variable "test" or "prod".  In addition to the base [application.yml](https://github.com/kapresoft/spring-boot-aws-lambda/blob/master/src/main/resources/application.yml), this will configure the application to pickup additional settings specified in the [application-test.yml](https://github.com/kapresoft/spring-boot-aws-lambda/blob/master/src/main/resources/application-test.yml) or [application-prod.yml](https://github.com/kapresoft/spring-boot-aws-lambda/blob/master/src/main/resources/application-prod.yml) configuration files.

| Environment Variable | Profile Value(s)  | Note |
|---|---|---|
| SPRING_PROFILES_ACTIVE | test | Sets the active profile to test |
| SPRING_PROFILES_ACTIVE | prod | Sets the active profile to prod |
| SPRING_PROFILES_ACTIVE | prod,\<any> | Sets the active profile to<br/>prod and `<any>` arbitrary profile value |

In the case of multiple profile values like 'prod,experiment', Spring Boot will run with configurations application-prod.yml and application-experiment.yml.

An example usecase for this type of profile is for running experiments without actually having to redeploy any code changes is to specify an additional profile like "experiment" and have it pickup additional configuration, in this case, to enable an experiment.  When the experiment is complete, you will be able to update the profile to only pickup "prod".

### See Article for more details on Spring Boot Profiles
* [Spring Boot Profiles in AWS Lambda](/java/2019/10/20/aws-lambda-spring-boot-profiles.html)

## Example Cloud Watch Log

Click the following image to see the expanded-view of the example AWS Cloud Watch log.

<a target="_blank" href="https://cdngh.kapresoft.com/img/spring-boot-demo-cloudwatch-log.gif"><img width="560" src="https://cdngh.kapresoft.com/img/spring-boot-demo-cloudwatch-log.gif" alt="Cloud Watch Logs"/></a>

