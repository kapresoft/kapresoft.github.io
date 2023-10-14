---
title: "Spring Boot Conditional Annotations"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/10/01/spring-boot-conditional-annotations.html
category: java
related: spring
description: "Explore how to use Spring Boot's conditional annotations for seamless autoconfiguration. Master custom module integration with examples."
---

## Overview

The world of Java programming, notably within the Spring Framework, constantly evolves, offering developers powerful tools and techniques to streamline application building. One such tool that stands out is the _@Conditional_ annotation. This robust tool in Spring Boot is an absolute game-changer, offering a range of built-in annotations that allow developers to control configurations based on multiple criteria.<!--excerpt--> This article dives deep into these conditional annotations, exploring their workings, features, and real-world applications.

## Understanding the Power of _@Conditional_ Annotation

_@Conditional_ annotation in the Spring Boot environment is often considered a pivot for creating versatile and efficient applications. It empowers developers to conditionally include or exclude sections of configuration based on various criteria, ranging from the existence of specific beans to the detection of particular system properties or resources.

## Spring Boot's Predefined Conditional Annotations

Spring Boot doesn't merely offer a single _@Conditional_ annotation; it provides a suite of predefined conditional annotations, each designed for a specific type of condition. Let's delve into these:

### Class Conditions with @ConditionalOnClass and @ConditionalOnMissingClass

These annotations allow configurations to be included or excluded based on the presence or absence of particular classes in the runtime environment. Utilizing ASM (Abstract Syntax Tree) parsing, these annotations provide a flexibility to refer to actual classes, even if they might not exist on the running application's classpath.

For instance, consider an application requiring a specific _LoggingService_ only when _EmbeddedAcmeService.class_ exists:

```java
@Configuration
public class MyAutoConfiguration {

	@Configuration
	@ConditionalOnClass(EmbeddedAcmeService.class)
	static class EmbeddedConfiguration {

		@Bean
		@ConditionalOnMissingBean
		public EmbeddedAcmeService embeddedAcmeService() {
			// Implementation here
		}
	}
}
```

### Bean Conditions with @ConditionalOnBean and @ConditionalOnMissingBean

These annotations enable beans to be added or excluded based on the presence or absence of other beans. While the _value_ attribute defines beans by type, the _name_ attribute specifies them by their names. With _@ConditionalOnBean_, for instance, one can ensure that a _MyService_ bean is created only if no other bean of that type exists in the ApplicationContext:

```java
@Configuration
public class MyAutoConfiguration {

	@Bean
	@ConditionalOnMissingBean
	public MyService myService() {
		// Implementation here
	}
}
```

### Property Conditions with @ConditionalOnProperty

Spring Boot provides a versatile mechanism to conditionally include beans or configuration segments based on certain conditions. One of the most commonly used annotations for this purpose is _@ConditionalOnProperty_. This annotation allows beans to be included or excluded based on properties defined in the Spring Environment.

In this section, we will delve into the intricacies of the _@ConditionalOnProperty_ annotation and provide a few practical examples to demonstrate its use.

#### Understanding @ConditionalOnProperty

At its core, the _@ConditionalOnProperty_ annotation checks if specific properties have a certain value or merely exist in the Spring Environment. Here's the basic syntax:

```java
@ConditionalOnProperty(name = "property.name", havingValue = "expectedValue")
```

The above would mean that the associated bean or configuration would only be loaded if the property _property.name_ exists and has a value of _expectedValue_.

Here are some practical examples:

#### Simple Property Check

Suppose you have an application where you want to enable a specific service only when a property is set to _true_.

```java
@Service
@ConditionalOnProperty(name = "feature.x.enabled", havingValue = "true")
public class FeatureXService {
    // Service Implementation
}
```

In this example, the _FeatureXService_ would only be activated if the _feature.x.enabled_ property is set to _true_ in the application's properties.

#### Checking for Property Existence

Sometimes, you might want to load a bean merely based on the existence of a property, regardless of its value.

```java
@Component
@ConditionalOnProperty("database.backup.path")
public class DatabaseBackupService {
    // Service Implementation
}
```

Here, the _DatabaseBackupService_ would only be created if there's a _database.backup.path_ property defined, regardless of its actual value.

#### Using matchIfMissing Attribute

By default, if the property specified using _@ConditionalOnProperty_ is missing, the condition will not match. However, using the _matchIfMissing_ attribute, you can control this behavior:

```java
@Service
@ConditionalOnProperty(name = "logging.advanced.enabled", matchIfMissing = true)
public class AdvancedLoggingService {
    // Service Implementation
}
```

In this example, the _AdvancedLoggingService_ will be loaded if either the _logging.advanced.enabled_ property is not defined at all or if it's set to _true_.

#### Multiple Property Conditions

You can also define multiple property conditions using the _@ConditionalOnProperty_ annotation:

```java
@Component
@ConditionalOnProperty(
    name = { "database.type", "database.version" },
    havingValue = { "mysql", "5.7" }
)
public class MySQL57Connector {
    // Connector Implementation
}
```

Here, the _MySQL57Connector_ will only be loaded if both _database.type_ is set to _mysql_ and _database.version_ is set to _5.7_.

In summary, the _@ConditionalOnProperty_ annotation is a powerful tool in the Spring Boot arsenal, allowing for flexible and dynamic bean and configuration loading based on property values. As with all powerful tools, it should be used judiciously to ensure that application contexts remain clear and maintainable.

### Resource Conditions with @ConditionalOnResource

The _@ConditionalOnResource_ annotation in Spring Boot ensures that configurations are activated only when specific resources are present, be it a particular file or another type of resource. Leveraging Spring Boot's comprehensive array of conditions, the _@ConditionalOnResource_ annotation offers a tailored approach to instantiate and configure beans. This becomes invaluable when the intent is to adaptively load configurations or beans based on the availability of designated files in the classpath or filesystem.

In this section, we will cover the nuances of the _@ConditionalOnResource_ annotation and provide practical examples of its usage.

#### Basics of @ConditionalOnResource

The primary purpose of the _@ConditionalOnResource_ annotation is to check for the existence of a particular resource. Here's a basic representation:

```java
@ConditionalOnResource(resources = "classpath:file-name.extension")
```

This indicates that the associated bean or configuration would only be initialized if the specified resource file (_file-name.extension_) exists in the classpath.

Here are some practical examples:

#### Configuring Based on Properties File

Consider a scenario where you only want to load a specific configuration class if a particular properties file exists in the classpath:

```java
@Configuration
@ConditionalOnResource(resources = "classpath:custom-config.properties")
public class CustomConfigLoader {
    // Configuration details
}
```

In this case, _CustomConfigLoader_ will only be loaded if _custom-config.properties_ is found in the classpath.

#### Loading Service Based on XML Configuration

Suppose you have an XML-based configuration for a service, and you want the service to be active only if the XML configuration exists:

```java
@Service
@ConditionalOnResource(resources = "classpath:service-config.xml")
public class XMLConfiguredService {
    // Service Implementation
}
```

Here, _XMLConfiguredService_ will only be active if _service-config.xml_ exists in the classpath.

#### Checking for Multiple Resources

There might be cases where you want to conditionally load a bean only if multiple resources exist. This can be achieved by specifying multiple resources in the _resources_ attribute:

```java
@Component
@ConditionalOnResource(resources = {
    "classpath:config-one.properties",
    "classpath:config-two.properties"
})
public class DualConfigComponent {
    // Component Implementation
}
```

In this example, _DualConfigComponent_ will only be loaded if both _config-one.properties_ and _config-two.properties_ are present in the classpath.

#### Conditional Loading Based on External Files

While it's common to check resources in the classpath, _@ConditionalOnResource_ can also be used to check resources outside of it:

```java
@Component
@ConditionalOnResource(resources = "file:/etc/app/config.properties")
public class ExternalConfigComponent {
    // Component Implementation
}
```

Here, _ExternalConfigComponent_ will only be loaded if _config.properties_ exists in the _/etc/app/_ directory on the file system.

In summary, the _@ConditionalOnResource_ annotation provides an effective way to conditionally load beans or configurations based on the presence of specific resources. This ensures flexibility in configuration management and allows for more dynamic applications that can adapt based on the resources available.

### Web Application Conditions

In Spring Boot, annotations such as _@ConditionalOnWebApplication_ and _@ConditionalOnNotWebApplication_ are pivotal in determining whether an application operates within a web environment. They adeptly detect the presence of components like Spring's _WebApplicationContext_, session scope, or a _StandardServletEnvironment_. These annotations offer a precise way to differentiate the application environment type, and the following examples will showcase their effective utilization:

#### Using @ConditionalOnWebApplication

This annotation ensures that certain beans or configurations are only loaded when the application runs within a web context.

```java
@Configuration
public class WebConfig {

    @Bean
    @ConditionalOnWebApplication
    public WebService defaultWebService() {
        return new DefaultWebService();
    }
}
```

In this example, the _DefaultWebService_ bean will only be instantiated if the application is a web application.

#### Customizing Web Behavior with @ConditionalOnWebApplication

Suppose you have a service that should only run when the application is web-based, like an authentication service for web sessions.

```java
@Configuration
public class AuthenticationServiceConfig {

    @Bean
    @ConditionalOnWebApplication
    public WebAuthenticationService webAuthenticationService() {
        return new WebAuthenticationService();
    }
}
```

The _WebAuthenticationService_ bean will only be initialized for web applications.

#### Using @ConditionalOnNotWebApplication

Sometimes, you might want specific configurations or beans to be present only when the application isn't a web application.

```java
@Configuration
public class NonWebConfig {

    @Bean
    @ConditionalOnNotWebApplication
    public LocalFileService localFileService() {
        return new LocalFileService();
    }
}
```

Here, the _LocalFileService_ bean will only be instantiated for non-web applications.

#### Switching Data Sources Based on Application Type

Suppose you want to switch between different data sources based on whether your application runs in a web environment or not.

```java
@Configuration
public class DataSourceConfig {

    @Bean
    @ConditionalOnWebApplication
    public DataSource webDataSource() {
        return new WebDataSource();
    }

    @Bean
    @ConditionalOnNotWebApplication
    public DataSource standaloneDataSource() {
        return new StandaloneDataSource();
    }
}
```

In this configuration, a _WebDataSource_ bean is created for web applications, while a _StandaloneDataSource_ is created for non-web applications.

In summary, by utilizing the _@ConditionalOnWebApplication_ and _@ConditionalOnNotWebApplication_ annotations, developers can achieve a high level of granularity and control over how components are loaded based on the nature of the application.

### SpEL Expression Conditions with @ConditionalOnExpression

Spring's SpEL (Spring Expression Language) stands out as a powerful feature, facilitating the querying and manipulation of objects. Using the _@ConditionalOnExpression_ annotation in tandem with SpEL allows developers to conditionally incorporate configurations based on specific expression outcomes. To further illustrate, let's delve into some examples that showcase its application:

#### Conditionally Creating a Bean Based on a Property Value
```java
@Bean
@ConditionalOnExpression("${app.featureX.enabled:false}")
public FeatureX featureX() {
    return new FeatureX();
}
```
In this example, the _featureX_ bean is instantiated and added to the Spring context only if the property _app.featureX.enabled_ is set to _true_.

#### Combining Multiple Property Checks
```java
@Bean
@ConditionalOnExpression("${app.featureA.enabled:false} and ${app.featureB.enabled:false}")
public CombinedFeature combinedFeature() {
    return new CombinedFeature();
}
```
Here, the _CombinedFeature_ bean is added only if both _app.featureA.enabled_ and _app.featureB.enabled_ properties are set to _true_.

#### Using Arithmetic Operations
```java
@Bean
@ConditionalOnExpression("#{${app.max.users} > 100}")
public HighCapacityService highCapacityService() {
    return new HighCapacityService();
}
```
In this scenario, the _HighCapacityService_ bean is instantiated if the property _app.max.users_ exceeds 100.

#### Utilizing Ternary Operations
```java
@Bean
@ConditionalOnExpression("'${app.environment}' == 'dev' ? true : false")
public DevelopmentTool developmentTool() {
    return new DevelopmentTool();
}
```
This example demonstrates the instantiation of the _DevelopmentTool_ bean only if the _app.environment_ property is set to _dev_.

#### Working with Lists and Arrays
```java
@Bean
@ConditionalOnExpression("#{'${app.supported.languages}'.split(',').contains('English')}")
public EnglishSupportService englishSupportService() {
    return new EnglishSupportService();
}
```
This example will instantiate the _EnglishSupportService_ bean if the comma-separated list property _app.supported.languages_ contains _English_.

These examples underscore the versatility and precision of SpEL in tandem with the _@ConditionalOnExpression_ annotation, facilitating intricate conditions based on various system properties and configurations.

### Combining Conditions: The Logic of AND & OR

In Spring Boot, combining conditions isn't just about juxtaposing two or more annotations; it's about creating a logical synergy between them for refined configuration control. By leveraging logical operators like AND and OR, you can achieve more targeted and layered configurations. Here are some practical examples to demonstrate this:

#### Using AND Logic

Imagine you want a bean to be created only if two conditions are met: a certain class is on the classpath **and** a specific property is set.

```java
@Configuration
@ConditionalOnClass(ExampleClass.class)
@ConditionalOnProperty(name = "example.property", havingValue = "true")
public class AndCombinedConfiguration {
    
    @Bean
    public ExampleService exampleService() {
        return new ExampleServiceImpl();
    }
}
```

In this scenario, _ExampleService_ will only be instantiated if _ExampleClass_ is present on the classpath **and** the property _example.property_ has a value of _true_.

#### Using OR Logic

Spring doesn't provide a direct OR operator for conditions, but you can achieve OR logic using a custom condition. Let's say you want a bean to be created if either a certain class is present **or** a specific property is set.

```java
public class OrCondition implements Condition {

    @Override
    public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
        boolean classCondition = context.getBeanFactory().containsBean(ExampleClass.class.getName());
        boolean propertyCondition = "true".equals(context.getEnvironment().getProperty("example.property"));
        
        return classCondition || propertyCondition;
    }
}

@Configuration
@Conditional(OrCondition.class)
public class OrCombinedConfiguration {
    
    @Bean
    public ExampleService exampleService() {
        return new ExampleServiceImpl();
    }
}
```

In this example, the _ExampleService_ will be instantiated if either _ExampleClass_ is present **or** the _example.property_ is set to _true_.

These examples provide a foundational understanding, but the real-world scenarios can be far more complex, combining multiple ANDs and ORs. With Spring Boot's conditional annotations, developers have the flexibility to craft configurations that closely align with application needs.

### Crafting Custom Conditions in Spring

While Spring Boot offers a plethora of built-in conditions to cater to most scenarios, there will inevitably be unique requirements that necessitate custom conditions. By implementing the _Condition_ interface, developers can define such custom conditions with bespoke logic. Let's explore this through a couple of illustrative examples:

#### Checking Custom Property Value

Imagine you want to create a condition that checks if a property _custom.feature.enabled_ is set to _superTrue_:

```java
public class CustomPropertyCondition implements Condition {

    @Override
    public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
        String propertyValue = context.getEnvironment().getProperty("custom.feature.enabled");
        return "superTrue".equals(propertyValue);
    }
}

@Configuration
@Conditional(CustomPropertyCondition.class)
public class CustomPropertyConfiguration {
    
    @Bean
    public CustomService customService() {
        return new CustomServiceImpl();
    }
}
```

With this configuration, _CustomService_ will only be instantiated if the property _custom.feature.enabled_ has the exact value _superTrue_.

#### Checking the Presence of a Specific Bean

Suppose you want to ensure that a certain bean is only created if another bean, _EssentialBean_, is already defined in the context:

```java
public class EssentialBeanCondition implements Condition {

    @Override
    public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
        return context.getBeanFactory().containsBean(EssentialBean.class.getName());
    }
}

@Configuration
@Conditional(EssentialBeanCondition.class)
public class DependentConfiguration {
    
    @Bean
    public DependentService dependentService() {
        return new DependentServiceImpl();
    }
}
```

Here, the _DependentService_ bean will only be created if _EssentialBean_ is present in the Spring context.

In summary, crafting custom conditions in Spring Boot is a powerful way to introduce flexibility and specificity into your configurations. With the capability to define custom logic through the _Condition_ interface, developers can ensure that their configurations are precisely aligned with the application's evolving needs.

### Unlocking Advanced Capabilities with Java 8

Java 8 introduced groundbreaking features like lambda expressions, streams, and the new Date and Time API, among others. With these advancements, developers could write more concise, functional, and efficient code. Let's delve into some examples showcasing how the __@ConditionalOnJava__ annotation in Spring Boot can be utilized to leverage these features:

#### Lambda Expressions
```java
@Bean
@ConditionalOnJava(JavaVersion.EIGHT)
public MyFunctionalInterface myBeanUsingLambda() {
    return () -> "Hello from Java 8!";
}
```
Here, the bean will only be created if the application is running on Java 8, allowing it to use lambda expressions safely.

#### Streams
```java
@Configuration
@ConditionalOnJava(JavaVersion.EIGHT)
public class StreamConfiguration {
    
    @Bean
    public List<String> filteredNames() {
        List<String> names = Arrays.asList("John", "Jane", "Doe", "Anna");
        return names.stream().filter(name -> !name.equals("Doe")).collect(Collectors.toList());
    }
}
```
This configuration will only be loaded when Java 8 is in use, ensuring the stream operations can be executed without issues.

#### New Date and Time API
```java
@Bean
@ConditionalOnJava(JavaVersion.EIGHT)
public LocalDateTime currentDateTime() {
    return LocalDateTime.now();
}
```
This bean leverages the enhanced Date and Time API introduced in Java 8. By using the _@ConditionalOnJava_ annotation, you can ensure that the code will only execute in the appropriate Java environment.

#### Optional
```java
@Configuration
@ConditionalOnJava(JavaVersion.EIGHT)
public class OptionalConfiguration {

    @Bean
    public Optional<String> optionalBean() {
        return Optional.ofNullable("Sample String");
    }
}
```

This configuration demonstrates the use of _Optional_, a container object that may or may not contain a non-null value. It ensures safer code by avoiding potential null references.

By using the __@ConditionalOnJava__ annotation, developers can seamlessly integrate Java 8 features into their Spring Boot applications, ensuring compatibility and tapping into the enhanced capabilities Java 8 brings to the table.

### AutoConfiguration Use Case of Conditional Annotations

In the world of Spring Boot, AutoConfiguration is a powerful tool. It allows for the automatic configuration of beans in the Spring context, streamlining the application setup process. Conditional annotations play a pivotal role in this by enabling or disabling certain configurations based on specific criteria.

Let's consider a basic example. Suppose you're developing a web application that can connect to a database. Depending on the availability of a certain library in your classpath, you want to autoconfigure a datasource.

#### Add Dependencies
Firstly, include the necessary Spring Boot starter dependencies in your _pom.xml_ or _build.gradle_.

```xml
<!-- Spring Boot Starter Data JPA for database operations -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
```

#### Create an AutoConfiguration
You'll then create an autoconfiguration class:

```java
@Configuration
@ConditionalOnClass(name = "org.springframework.jdbc.datasource.DataSource")
public class DatabaseAutoConfiguration {

    @Bean
    @ConditionalOnMissingBean
    public DataSource defaultDataSource() {
        //... create a basic DataSource instance
    }
}
```

Here, the _@ConditionalOnClass_ annotation checks if a specific class (in this case, a DataSource class from Spring's JDBC module) is available in the classpath. If the class is present, the configuration will be activated.

Further, the _@ConditionalOnMissingBean_ ensures that this default _DataSource_ bean is only created if no other _DataSource_ bean has been defined elsewhere in the application.

#### Include in spring.factories

To ensure Spring Boot recognizes your autoconfiguration, you'll have to include it in the _META-INF/spring.factories_ file:

```properties
org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
com.example.DatabaseAutoConfiguration
```

Now, when your application starts, if the required JDBC classes are in the classpath, the _DatabaseAutoConfiguration_ will kick in and provide a default DataSource bean unless one is already provided elsewhere in the application.

In conclusion, conditional annotations simplify the process of setting up different environments and scenarios in Spring Boot applications, making development more efficient and dynamic.

### AutoConfiguration for an Arbitrary Spring Module Library using Conditional Annotations

AutoConfiguration is a cornerstone of Spring Boot's philosophy of convention over configuration. It automates the process of setting up beans in the Spring context based on certain conditions. The conditional annotations in Spring Boot are used to determine whether these beans should be included based on specific conditions. Let’s illustrate this with an example of autoconfiguring an arbitrary Spring module that will only be loaded and setup if the Jackson library exists: the _SpringModuleLibrary_.

**Scenario**: Imagine there's a Spring module called _SpringModuleLibrary_ that helps with certain custom operations, and you want your application to autoconfigure certain beans if this module is present in the classpath.

#### Add Dependencies
Ensure the required dependencies for the _SpringModuleLibrary_ are included in your project's _pom.xml_ or _build.gradle_ file.

```xml
<!-- Dependency for the arbitrary SpringModuleLibrary -->
<dependency>
    <groupId>org.mycompany.module</groupId>
    <artifactId>spring-module-library</artifactId>
    <version>1.0.0</version>
</dependency>
```

#### Create the AutoConfiguration

In this example, this module will only load if a particular library is int the classpath. In this example, we will use Jackson ObjectMapper as an example that the library depends on.

You'll then craft an autoconfiguration class:

```java
@Configuration
@ConditionalOnClass(com.fasterxml.jackson.databind.ObjectMapper.class)
public class SpringModuleAutoConfiguration {

    @Bean
    @ConditionalOnMissingBean
    public CustomService defaultCustomService() {
        return new CustomService(); // This is a service from SpringModuleLibrary that depends on Jackson ObjectMapper
    }
}
```

Here:
- The _@ConditionalOnClass_ annotation ensures this configuration is activated only if a specific class (Jackson's _ObjectMapper_) from the _SpringModuleLibrary_ is available on the classpath.
- The _@ConditionalOnMissingBean_ annotation ensures the _CustomService_ bean is created only if there's no other bean of type _CustomService_ defined elsewhere in the application.

#### Registration in _spring.factories
To make Spring Boot aware of this autoconfiguration, you'll have to register it in the _META-INF/spring.factories_ file:

```properties
org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
com.example.SpringModuleAutoConfiguration
```

By doing so, when your Spring Boot application starts and detects the _SpringModuleLibrary_ in the classpath, the _SpringModuleAutoConfiguration_ will automatically configure the required beans for you, unless they're explicitly defined elsewhere in your application.

In essence, using conditional annotations, developers can seamlessly introduce and use third-party or custom Spring modules in their applications with minimal manual configurations.

## In Conclusion

Spring Boot continues to revolutionize the way developers approach Java-based applications. Its vast array of conditional configurations, ranging from built-in annotations to custom conditions, provides developers with the flexibility to shape the behavior of their applications based on dynamic conditions. This level of granular control ensures that applications remain adaptive, efficient, and aligned with specific operational environments. By understanding and leveraging these conditional tools, developers can create robust, responsive, and finely-tuned applications that cater to diverse and evolving requirements. As we continue to journey through the evolving landscape of software development, the adaptability that Spring Boot's conditional configurations offer will undoubtedly remain an invaluable asset.
