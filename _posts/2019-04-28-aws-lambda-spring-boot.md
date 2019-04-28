---
layout: kapresoft
title: Spring Boot AWS Lambda
image: /assets/images/kapresoft.png
canonical_url: https://www.kapresoft.com/java/2019/04/28/aws-lambda-spring-boot.html
category: java
---


# Overview

This article discusses running a Spring Boot application in [AWS Lambda](https://aws.amazon.com/lambda/).

<!--excerpt-->

# Why Spring Framework or Spring Boot?

Spring is a framework that allows you to wire application components together.  Spring utilizes dependency injection or as others may call it, Inversion of Control (IoC).  Dependency Injection provides a consistent way of configuring and managing components which makes your code less dependent on the container than it would be in a traditional enterprise development. The framework also promotes easy unit testing.

Spring Boot is implemented to have you up and running as quickly as possible with fewer upfront configuration.

# Repository

While going through this article, the example code will be referenced in this github repository [https://github.com/nfet/spring-boot-lambda](https://github.com/nfet/spring-boot-lambda).  You may follow or navigate directly to the source located here.

# Initializing Spring Boot

The Handler in the AWS Lambda config page is specified as:

```
com.kapresoft.demo.springbootlambda.Lambda::handler
```

## Constructor Initialization

See: [Lambda.java](https://github.com/nfet/spring-boot-lambda/blob/master/src/main/java/com/kapresoft/demo/springbootlambda/Lambda.java) in github

In this example, the AWS Lambda function code manually initializes Spring Boot using the SpringApplicationBuilder. The constructor code below creates the builder and sets up the spring active profiles.  Notice that after the constructor initialization, all the dependent objects need by this lambda have been assign as fields.

```java
public class Lambda {

    private final Logger log = LoggerFactory.getLogger(Lambda.class);

    private final ConfigurableApplicationContext appContext;
    private final ConfigurableEnvironment environment;
    private final JsonUtils jsonUtils;

    public Lambda() {
        final SpringApplicationBuilder builder = new SpringApplicationBuilder(Application.class)
                .logStartupInfo(false);
        initProfile(builder);

        // Retrieve dependent components from the application context
        appContext = builder.build().run();
        environment = appContext.getEnvironment();
        jsonUtils = appContext.getBean(JsonUtils.class);
    }

    private void initProfile(SpringApplicationBuilder builder) {
        final String environment = ofNullable(System.getenv("ENVIRONMENT")).orElse("default");
        if (hasLength(environment)) {
            log.info("Starting lambda with profile: {}", environment);
            builder.profiles(environment);
        }
    }

    public LambdaResponse handler(Map<String, Object> request, Context context) {
        log.info("Environment: {}", (Object[]) environment.getActiveProfiles());
        log.info("Message #1: {}", environment.getProperty("message"));
        log.info("Message #2: {}", environment.getProperty("message2"));
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

Setting the environment variables to set the spring active profile is a good way to run your lambda in different environments. In this example, we will need to specify an environment variable "test" or "prod".  In addition to the base [application.yml](https://github.com/nfet/spring-boot-lambda/blob/master/src/main/resources/application.yml), this will configure the application to pickup additional settings specified in the [application-test.yml](https://github.com/nfet/spring-boot-lambda/blob/master/src/main/resources/application-test.yml) or [application-prod.yml](https://github.com/nfet/spring-boot-lambda/blob/master/src/main/resources/application-prod.yml) configuration files.

# Example Cloud Watch Log

Click the following image to see the expanded-view of the example AWS Cloud Watch log.

<a target="_blank" href="https://cdngh.kapresoft.com/img/spring-boot-demo-cloudwatch-log.gif"><img width="560" src="https://cdngh.kapresoft.com/img/spring-boot-demo-cloudwatch-log.gif"/></a>

# References

* [Spring Framework](https://spring.io/projects/spring-framework)
* [Spring Boot](https://spring.io/projects/spring-boot)
* [Spring Boot Initializr](https://start.spring.io/) ~ bootstrap your application
