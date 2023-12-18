---
title: "Spring Boot • Environment Specific Profiles"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/19/spring-boot-env-specific-profiles.html
category: java
related: spring
description: "Explore how to set up Spring Boot environment specific profiles, such as dev, test, integration, and prod, with illustrative YAML configurations and command line examples."
---

## Overview

When building a Spring Boot application, it's essential to have different configurations for various environments like development (dev), testing (test), integration, and production (prod). This flexibility ensures that the application runs optimally in each environment.<!--excerpt--> In this comprehensive guide, we will explore how to set up these environment-specific profiles using YAML files instead of properties files.

## Setting Up YAML Configurations

YAML files offer a structured and readable format for configuration data. They are a popular choice for Spring Boot applications due to their simplicity and ease of use. Here's how you can set up YAML files for different environments:

### Development (Dev) Configuration

Create an _application-dev.yml_ file in the _src/main/resources_ directory of your project. Add the development-specific configurations in this file.

```yaml
server:
  port: 8081
spring:
  profiles:
    active: dev
  datasource:
    url: jdbc:mysql://localhost:3306/dev_db
    username: dev_user
    password: dev_pass
```

### Testing (Test) Configuration

Similarly, create an _application-test.yml_ file for the testing environment.

```yaml
server:
  port: 8082
spring:
  profiles:
    active: test
  datasource:
    url: jdbc:mysql://localhost:3306/test_db
    username: test_user
    password: test_pass
```

### Integration Configuration

For the integration environment, create an _application-integration.yml_ file.

```yaml
server:
  port: 8083
spring:
  profiles:
    active: integration
  datasource:
    url: jdbc:mysql://localhost:3306/integration_db
    username: integration_user
    password: integration_pass
```

### Production (Prod) Configuration

Lastly, for the production environment, create an _application-prod.yml_ file.

```yaml
server:
  port: 8080
spring:
  profiles:
    active: prod
  datasource:
    url: jdbc:mysql://localhost:3306/prod_db
    username: prod_user
    password: prod_pass
```

## Running Spring Boot with Specific Profiles

Once the YAML configurations are set up, you can run your Spring Boot application with a specific profile using the following command line:

```bash
./mvnw spring-boot:run -Dspring.profiles.active=dev
```


This example shows how to run the application with the development profile.

## Running Spring Boot with Multiple Profiles

In some cases, you may need to run your application with more than one profile. For instance, you might want to combine the development and testing configurations. Use the following command line to achieve this:

```bash
./mvnw spring-boot:run -Dspring.profiles.active=dev,test
```

## In Conclusion

By following these steps, you can efficiently set up environment-specific profiles for your Spring Boot application using YAML configurations. This approach provides a clear and structured format for your configuration data, making it easier to manage and understand. Moreover, running the application with specific profiles or a combination of profiles is straightforward, thanks to the simple command line options.
