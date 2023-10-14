---
title: "Spring Framework Annotations"
canonical_url: https://www.kapresoft.com/java/2023/10/01/spring-framework-annotations.html
category: java
related: spring
description: "Comprehensive guide on key Spring Framework annotations: their parameters, use-cases, and examples for robust application development."
---

## Overview

Spring Framework has solidified its place in the realm of Java-based enterprise applications. Its annotations simplify the coding process, enabling developers to focus on the business logic. This article delves into the core annotations in the Spring Framework, shedding light on their purposes and usage. Through this comprehensive guide, we aim to provide clarity and depth on these annotations.

<!--excerpt-->

## Understanding Spring Annotations

Annotations serve as meta-tags that provide meta-data directly into the code. When used in the Spring Framework, these annotations are processed by the Spring container to inject dependencies and configure the application context.

## Dependency Injection (DI) Annotations

### @Autowired
One of the cornerstones of Spring’s DI is the _@Autowired_ annotation. It informs Spring to inject an object dependency automatically.

- **Constructor Injection**:
```java
class Vehicle {
    Engine engine;

    @Autowired 
    Vehicle(Engine engine) {
        this.engine = engine;
    }
}
```
- **Setter Injection**:
```java
class Vehicle {
    Engine engine;

    @Autowired 
    void setEngine(Engine engine) {
        this.engine = engine;
    }
}
```
- **Field Injection**:
```java
class Vehicle {
    @Autowired 
    Engine engine;
}
```
The _@Autowired_ annotation also comes with a _required_ parameter. It determines Spring's action if it can't find a matching bean. If set to true (the default), a _NoSuchBeanDefinitionException_ is thrown. If false, it remains unset.

### @Bean
The _@Bean_ annotation signifies that a method instantiates, configures, and initializes a new object to be managed by Spring. For instance:
```java
@Bean 
Engine createEngine() {
    return new Engine();
}
```
It's essential to ensure methods annotated with _@Bean_ are part of classes annotated with _@Configuration_.

### @Autowired Parameters

The _@Autowired_ annotation in the Spring framework is used for automatic dependency injection. It tells Spring to resolve and inject a bean dependency for the annotated field, constructor, or method. While this annotation has a couple of parameters, the most commonly used are _required_ and _value_.

#### Parameters:

- **required (default is true)**: This indicates whether the annotated dependency is mandatory or not. If set to _true_ and Spring cannot find a matching bean to inject, an exception will be thrown. If set to _false_, no exception will be thrown, and the property will remain _null_.

- **value**: This rarely-used parameter allows for specifying the name of the bean to be autowired. It's not commonly used because the type of the dependency usually determines which bean is autowired.

Here’s a simple example to demonstrate its use:

#### Field Injection
```java
@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // ... class methods ...
}
```

#### Constructor Injection (preferred way)
```java
@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // ... class methods ...
}
```

#### Setter Injection
```java
@Service
public class UserService {

    private UserRepository userRepository;

    @Autowired
    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // ... class methods ...
}
```

#### Using _required_ parameter
   Suppose there might be cases where the _UserRepository_ bean might not be available.
```java
@Service
public class UserService {

    @Autowired(required = false)
    private UserRepository userRepository;

    // ... class methods ...
}
```
In the above example, if Spring can't find a bean of type _UserRepository_, it won't raise an exception, and the _userRepository_ field will be _null_.

Utilizing _@Autowired_ effectively can lead to cleaner and more maintainable code, making the dependency management aspect of Spring applications more seamless.

### @Qualifier
In scenarios where multiple beans of the same type exist, and Spring needs clarity on which one to inject, _@Qualifier_ comes to the rescue.
```java
@Autowired 
Driver(@Qualifier("bike") Vehicle vehicle) {
    this.vehicle = vehicle;
}
```
This annotation works in conjunction with _@Autowired_ to specify the exact bean id for injection.

### @Qualifier Parameters

The _@Qualifier_ annotation is used in conjunction with _@Autowired_ to specify which exact bean should be wired when there are multiple candidates of the same type. It's a way of refining the autowiring process by providing more specific injection instructions.

#### Parameters:

- **value**: This parameter specifies the name of the bean that should be injected. It's essentially the bean's identifier.

Here’s a simple example to demonstrate its use:

#### Using @Qualifier with Field Injection
   Suppose we have two beans of type _DataSource_ in our configuration, _primaryDataSource_ and _secondaryDataSource_. To inject the _secondaryDataSource_ bean into a service, we would do:

```java
@Service
public class DataProcessingService {

    @Autowired
    @Qualifier("secondaryDataSource")
    private DataSource dataSource;

    // ... class methods ...
}
```

#### Using @Qualifier with Constructor Injection
   Again, consider having two beans of type _PaymentService_, named _creditPaymentService_ and _debitPaymentService_. To inject a specific one:

```java
@Service
public class PurchaseService {

    private final PaymentService paymentService;

    @Autowired
    public PurchaseService(@Qualifier("creditPaymentService") PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    // ... class methods ...
}
```

#### Using @Qualifier with Setter Injection
   Let's assume there are multiple implementations of _NotificationService_, namely _smsNotificationService_ and _emailNotificationService_. We can select one for injection as follows:

```java
@Service
public class AlertService {

    private NotificationService notificationService;

    @Autowired
    @Qualifier("emailNotificationService")
    public void setNotificationService(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    // ... class methods ...
}
```

By leveraging _@Qualifier_, developers can exercise finer control over dependency injection, ensuring the right components are used in the right contexts.

### @Value
For injecting values into beans, we utilize _@Value_. This annotation can inject values from property files or directly.
```java
@Value("${engine.fuelType}") 
String fuelType;
```
This code snippet demonstrates the injection of the _fuelType_ value from a _.properties_ file.

### @Value Parameters

The _@Value_ annotation is used in Spring to inject values directly into fields, constructors, or methods. These values can come from property files, system properties, or be directly hard-coded.

#### Parameters:

- **value**: This parameter specifies the actual value or the expression to retrieve the value. It can reference properties using the _${...}_ syntax or SpEL (Spring Expression Language) expressions using the _#{...}_ syntax.

Here’s a simple example to demonstrate its use:

#### Injecting a Direct Value
   To directly set a field's value:

```java
@Component
public class AppConfig {
    
    @Value("SomeAppName")
    private String appName;
    
    // ... class methods ...
}
```

#### Injecting from a Property File
   Suppose we have a _config.properties_ file with the entry _app.version=1.0.0_. We can inject this value as:

```java
@Component
public class AppConfig {

    @Value("${app.version}")
    private String appVersion;

    // ... class methods ...
}
```

#### Injecting System Properties
   Retrieving system properties, for instance, the Java version:

```java
@Component
public class SystemInfo {

    @Value("${java.version}")
    private String javaVersion;

    // ... class methods ...
}
```

#### Using SpEL with @Value
   Spring Expression Language (SpEL) can be used to derive values:

```java
@Component
public class MathConfig {

    @Value("#{20 + 22}")
    private int result;

    // ... class methods ...
}
```

By utilizing _@Value_, developers can effortlessly externalize configuration and ensure their applications are more flexible and easier to manage.

## Context Configuration Annotations

### @Profile
Spring's _@Profile_ annotation ensures that specific beans or configurations are only activated under designated profiles.
```java
@Component 
@Profile("development") 
class DevelopmentConfig {}
```
In this instance, the _DevelopmentConfig_ bean is only activated when the "development" profile is active.

### @Profile Parameters

The _@Profile_ annotation in Spring is used to indicate that a component or configuration is only active when certain profiles are active. This is particularly useful for segregating parts of an application for different environments, such as development, testing, and production.

#### Parameters:

- **value**: An array of strings indicating the names of the profiles for which the component should be registered.

Here’s a simple example to demonstrate its use:

#### Defining a Development Configuration
   A configuration that is active only during the development phase:

```java
@Configuration
@Profile("dev")
public class DevConfig {
    // ... configuration beans for development ...
}
```

#### Defining a Production Configuration
   A configuration that's active only in the production environment:

```java
@Configuration
@Profile("prod")
public class ProductionConfig {
    // ... configuration beans for production ...
}
```

#### Defining Beans for Multiple Profiles
   A bean that's active for both testing and QA profiles:

```java
@Bean
@Profile({"test", "qa"})
public DataSource dataSource() {
    // ... return a DataSource suitable for testing and QA ...
}
```
### @Profile in DevOps for Production Environments

The _@Profile_ annotation is especially beneficial in DevOps, where infrastructure as code (IAC) and automated deployments are key. It allows for an agile approach to configuration management in production environments. By leveraging this annotation, DevOps teams can predefine configurations tailored for different virtual machine images, regions, or specific deployment scenarios without needing to change the codebase.

For instance, consider a global application that requires different data source configurations based on the region of deployment. With the _@Profile_ annotation, different profile configurations can be embedded in the application, and the correct one activated based on the virtual machine image used for deployment.

Here’s a simple example to demonstrate its use:

#### Regional Configurations
   Suppose an application is deployed across North America and Europe, with different data sources:

```java
@Configuration
@Profile("NA")
public class NorthAmericaConfig {
    // ... configuration beans for North America data sources ...
}

@Configuration
@Profile("EU")
public class EuropeConfig {
    // ... configuration beans for Europe data sources ...
}
```

When deploying a virtual machine in North America, the DevOps team would activate the _NA_ profile, and similarly, the _EU_ profile for Europe.

#### Performance Tuning
   Imagine needing specific performance configurations for a high-load scenario versus a regular one:

```java
@Configuration
@Profile("high-load")
public class HighLoadConfig {
    // ... configuration beans for optimizing high-load scenarios ...
}
```

When anticipating a spike in traffic, the DevOps team can deploy a set of virtual machines with the _high-load_ profile activated, ensuring the system is optimized to handle the increased demand.

Through _@Profile_, DevOps can dynamically adapt the application to various production needs without manual intervention, ensuring streamlined deployments, and optimized runtime configurations.

Using the _@Profile_ annotation, developers can keep their configurations organized and ensure that the right configurations are used for the appropriate environments, improving maintainability and reducing potential runtime issues.

### @Scope
The _@Scope_ annotation defines the scope of the bean, which can be singleton (default), prototype, or even custom scopes.
```java
@Component 
@Scope("prototype") 
class EngineInstance {}
```
In this code, every time _EngineInstance_ is injected, a new instance is created, thanks to the "prototype" scope.

### @Scope Parameters

The _@Scope_ annotation in the Spring framework is used to define the scope of a bean. By default, Spring beans are singletons, but sometimes you may need to define beans that have a different lifecycle. The _@Scope_ annotation helps to dictate this lifecycle.

#### Parameters:

- **value**: This is the primary parameter, and it determines the lifecycle of the bean. Common values include:
    - _singleton_: (Default) Only one instance of the bean will be created for each Spring container.
    - _prototype_: A new instance will be created each time the bean is requested.
    - _request_: A single instance will be created for each HTTP request. (Only valid in a web-aware Spring ApplicationContext)
    - _session_: A single instance will be created for each HTTP session. (Only valid in a web-aware Spring ApplicationContext)
    - _application_: Bean lives the lifecycle of a ServletContext (Only valid in a web-aware Spring ApplicationContext)
    - _websocket_: Scoped to a websocket lifecycle.

- **proxyMode**: This parameter is used when you want to force the creation of a proxy to control the actual creation of the object, especially useful with _request_, _session_, and _application_ scopes. Values can be _TARGET_CLASS_, _INTERFACES_, or _NO_.

Here’s a simple example to demonstrate its use:

#### Prototype Scope
   In situations where you need a new instance of a bean every time it's injected/looked-up:

```java
@Component
@Scope("prototype")
public class PrototypeBean {
    // ... class definition ...
}
```

#### Request Scope
   For beans that are tied to the lifecycle of an HTTP request:

```java
@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class RequestScopedBean {
    // ... class definition ...
}
```

#### Session Scope
   When you need a bean to be tied to the lifecycle of an HTTP session:

```java
@Component
@Scope(value = "session", proxyMode = ScopedProxyMode.INTERFACES)
public class SessionScopedBean {
    // ... class definition ...
}
```

Using the _@Scope_ annotation allows developers to precisely control the lifecycle and instantiation of their Spring beans, enabling more flexible and efficient applications.

## Test Configuration Annotations

### Embracing Test Beans with @TestBean
When writing tests in Spring, _@TestBean_ is a vital annotation that allows you to add or replace a specific bean in the context for testing purposes.

The _@TestBean_ annotation in Spring is used to define a bean explicitly for testing purposes. It replaces any existing bean of the same type in the context, making it useful for mocking or stubbing specific behaviors.

Mocking provides a way to isolate components for testing, ensuring consistent, fast, and controlled results without the side effects of interacting with real-world systems.

Here's a simple example to demonstrate its use:

**Scenario:**
You have a service _NotificationService_ which interacts with a third-party service to send notifications. When testing, you don't want to send real notifications, but rather you want to mock the behavior.

**1. The Service:**
```java
@Service
public class NotificationService {

    public String sendNotification(String message) {
        // Code to send notification using a third-party service
        return "Notification Sent";
    }
}
```

**2. Test Configuration with _@TestBean_:**
```java
@RunWith(SpringRunner.class)
@SpringBootTest
public class NotificationServiceTest {

    @Autowired
    private NotificationService notificationService;

    @TestBean
    private NotificationService mockNotificationService() {
        return Mockito.mock(NotificationService.class);
    }

    @Test
    public void testNotification() {
        Mockito.when(mockNotificationService().sendNotification("Hello")).thenReturn("Mocked Notification");
        
        String response = notificationService.sendNotification("Hello");
        assertEquals("Mocked Notification", response);
    }
}
```

In the test above, the _@TestBean_ is used to create a mocked version of the _NotificationService_. This mocked bean will replace the actual _NotificationService_ bean in the test application context. This way, when the test is run, the mock behavior (defined by _Mockito.when()_) will be executed instead of the real service behavior.

### Conditional Tests with @IfProfileValue
For executing specific test methods in particular profile conditions, _@IfProfileValue_ proves beneficial. By setting name and value pairs, you can control the test's run conditions.

_@IfProfileValue_ is a conditional test annotation in Spring, allowing the execution of a test method based on specific profile values. For instance, one might want to run certain tests only in a "development" environment and not in "production".

```java
@RunWith(SpringRunner.class)
@ContextConfiguration
public class ConditionalTests {

    @Test
    @IfProfileValue(name = "environment", values = {"development"})
    public void testMethodForDevEnvironment() {
        // Test logic specific to the development environment
    }
}
```

In the above example, _testMethodForDevEnvironment()_ will only be executed if the JVM system property _environment_ is set to "development".

### Harnessing Mock Environments with @MockBean

While writing unit tests, mocking certain beans can streamline the process. With _@MockBean_, you can easily replace a bean with a mock version, simplifying the testing landscape.

The _@MockBean_ annotation in Spring is used to add mock objects to the Spring application context. These mock beans are automatically injected into any field marked with an _@Autowired_ annotation. This is particularly useful in tests where you'd want to mock certain beans and not use the actual implementations.

Here's an illustrative example:

```java
@RunWith(SpringRunner.class)
@SpringBootTest
public class UserServiceTest {

    @Autowired
    private UserService userService;

    @MockBean
    private UserRepository userRepository;

    @Test
    public void testGetUser_whenUserExists() {
        User mockUser = new User("John", "Doe");
        Mockito.when(userRepository.findByName("John")).thenReturn(mockUser);

        User result = userService.getUserByName("John");

        assertEquals(mockUser, result);
    }
}
```

In the example above, _userRepository_ is mocked using _@MockBean_. This means that whenever _userService_ calls methods on the _userRepository_, it will be interacting with the mock and not the actual repository. This allows for controlled testing scenarios where expected behavior can be easily defined.

### Focusing Tests with @TestPropertySource

To define property sources for your tests, you can leverage _@TestPropertySource_. It aids in refining the testing environment by specifying which properties are active during tests.

The _@TestPropertySource_ annotation in Spring Framework is used to customize the locations of property sources used in your tests. This becomes particularly useful when you want to run certain tests with specific property values without altering the main application's properties.

Here's an example:

Suppose we have an application property that sets the type of database to use. By default, the application uses a production database. However, for certain tests, we want to use an H2 in-memory database.

**src/main/resources/application.properties:**
```properties
database.type=production
```

**Test class:**

```java
@RunWith(SpringRunner.class)
@SpringBootTest
@TestPropertySource(properties = {"database.type=h2"})
public class DatabaseTest {

    @Value("${database.type}")
    private String databaseType;

    @Test
    public void whenUsingTestPropertySource_thenH2DatabaseIsUsed() {
        assertEquals("h2", databaseType);
    }
}
```

In this example, the _@TestPropertySource_ annotation overrides the _database.type_ property just for this test class, ensuring that the H2 database is used instead of the production database. This allows for focused testing under specific conditions without affecting other parts of the application.

## In Conclusion

Spring Framework’s annotations are pivotal for developing robust and scalable applications. These annotations allow developers to produce cleaner, more modular code, streamlining maintenance. This guide has explored the core Spring annotations, offering insights into their capabilities and applications. Utilizing these tools facilitates a smoother development experience with the Spring Framework.

Annotations in the Spring framework streamline the testing process. They provide controlled environments, facilitate mock implementations, and support conditional test executions, improving test precision and efficiency. Their use fortifies applications against potential challenges.
