---
title: "Spring 6 • What's New & Migration Guide"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/16/spring6-whats-new-and-migration-guide.html
category: java
related: spring
description: "Latest features and updates of Spring 6 with what's new and comprehensive migration guide."
---

## Overview

The Spring Framework's legacy in the Java ecosystem is undeniable. Recognized for its powerful architecture, versatility, and constant growth, Spring remains at the forefront of Java development. The release of Spring Framework 6.x heralds a new era, with enhanced features and revisions that cater to the modern developer's needs.<!--excerpt-->

## Pivotal Baseline Enhancements

Spring Framework 6.x sets a new standard by updating the prerequisites for various libraries, ensuring better compatibility and performance:
- **SnakeYAML** has ascended to version 2.0, offering better configuration parsing.
- **Jackson** climbs to 2.14, optimizing data serialization and deserialization processes.
- **Kotlin**, a major player in modern Java development, has received updates with **Coroutines** reaching 1.7 and **Serialization** advancing to 1.5.

## Core Container Makeover

The beating heart of the Spring Framework has undergone significant transformations:
- Addressing the deprecation of _java.net.URL_ constructors in JDK 20, URI-based URL resolution is now standardized.
- The introduction of _createBean(Class)_ method streamlines bean instantiation, catering to convention-based programming.
- There's a notable shift in array-to-collection conversion, now favoring a _List_ output for a _Collection_ target type.
- Improvements in _ThreadPoolTaskExecutor_ and _ThreadPoolTaskScheduler_ ensure seamless application context termination.
- **ApplicationContext**'s message resolution is now tightly linked to its active phase, enhancing consistency.
- Verbose logging for pre-computed fields during native image construction has been disabled by default but can be re-enabled with the _-Dspring.native.precompute.log=verbose_ compiler argument.
- 
### Addressing the deprecation of _java.net.URL_ constructors in JDK 20, URI-based URL resolution is now standardized.

Let's break down the changes and provide examples to illustrate the transition from using _java.net.URL_ constructors to a consistent URI-based resolution in JDK 20.

#### Traditional _java.net.URL_ Constructors

Before JDK 20, developers often used _java.net.URL_ constructors to create URLs. For example:

```java
URL url = new URL("https://www.example.com");
```

If there was a need to resolve a relative path against a base URL, it could be done like this:

```java
URL baseUrl = new URL("https://www.example.com/base/");
URL relativeUrl = new URL(baseUrl, "relativePath");
```

In this example, _relativeUrl_ would translate to _https://www.example.com/base/relativePath_.

#### Aligned URI-based Resolution in JDK 20

In JDK 20, with the deprecation of _java.net.URL_ constructors, the emphasis is on URI for resolution, which provides a more consistent approach, especially when handling relative paths.

To create a new URL, you can leverage _URI_ and then convert it to a _URL_:

```java
URI uri = new URI("https://www.example.com");
URL url = uri.toURL();
```

For relative path resolution:

```java
URI baseUri = new URI("https://www.example.com/base/");
URI relativeUri = baseUri.resolve("relativePath");
URL relativeUrl = relativeUri.toURL();
```

Here, _relativeUrl_ would again be _https://www.example.com/base/relativePath_.

#### Behavioral Changes for Uncommon Cases

Consider an uncommon scenario where a full URL is specified as a relative path:

**With _java.net.URL_ Constructors:**

```java
URL baseUrl = new URL("https://www.example.com/base/");
URL fullUrlAsRelative = new URL(baseUrl, "https://www.differentdomain.com/relativePath");
```

Previously, _fullUrlAsRelative_ would resolve to _https://www.differentdomain.com/relativePath_.

#### With URI-based Resolution

```java
URI baseUri = new URI("https://www.example.com/base/");
URI fullUriAsRelative = baseUri.resolve("https://www.differentdomain.com/relativePath");
URL fullUrlAsRelative = fullUriAsRelative.toURL();
```

With the URI-based resolution, _fullUrlAsRelative_ would still resolve to _https://www.differentdomain.com/relativePath_, maintaining consistency in behavior.

In conclusion, the transition to URI-based resolution in JDK 20 provides a more consistent and reliable approach for URL creation and relative path resolution, even in uncommon cases.

### The introduction of _createBean(Class)_ method streamlines bean instantiation, catering to convention-based programming.

In Spring Framework 6.1, the method _AutowireCapableBeanFactory.createBean(Class, int, boolean)_ is deprecated. It is recommended to use the simpler, convention-based method _createBean(Class)_. This new method is consistently employed internally in version 6.1, especially in classes such as _SpringBeanJobFactory_ for Quartz integration and _SpringBeanContainer_ for Hibernate integration.

Here are the examples to illustrate this change:

#### Before (Using the Deprecated Method)

Suppose you want to create a bean of class _MyBean_:

```java
AutowireCapableBeanFactory factory = applicationContext.getAutowireCapableBeanFactory();

// Using the deprecated createBean method
MyBean myBean = (MyBean) factory.createBean(MyBean.class, AutowireCapableBeanFactory.AUTOWIRE_BY_TYPE, true);
```

Here, the method _createBean_ requires three arguments: the bean class, autowiring mode, and a boolean flag for dependency check.

#### After (Using the Recommended Method)

With the new convention-based method, the process is more straightforward:

```java
AutowireCapableBeanFactory factory = applicationContext.getAutowireCapableBeanFactory();

// Using the convention-based createBean method
MyBean myBean = factory.createBean(MyBean.class);
```

In this updated approach, the method infers the autowiring mode and dependency check based on conventions, leading to cleaner and more intuitive code.

#### Internal Use

For the internal workings of Spring 6, classes such as _SpringBeanJobFactory_ and _SpringBeanContainer_ now use the _createBean(Class)_ method for bean creation.

For instance:

#### In _SpringBeanJobFactory_ for Quartz

Previously, when a job is triggered in Quartz, it might have used the longer _createBean_ method to instantiate the required job beans. Now, it would utilize the _createBean(Class)_ convention for this purpose.

#### In _SpringBeanContainer_ for Hibernate

Similarly, when Hibernate needs to instantiate an entity listener or any other custom beans, the _SpringBeanContainer_ would leverage the _createBean(Class)_ method.

In essence, the adoption of the _createBean(Class)_ method streamlines bean creation in Spring 6, both for developers and within the framework's internal operations.

### There's a notable shift in array-to-collection conversion, now favoring a _List_ output for a _Collection_ target type

In Spring Framework 6, there's a significant change regarding the conversion of arrays to collections. Previously, the exact type of collection resulting from such a conversion could vary. Now, when converting an array to a _Collection_ target type, the framework consistently returns a _List_.

#### Before the Change

Suppose you have an array of strings:

```java
String[] stringArray = {"apple", "banana", "cherry"};
```

And you want to convert it to a collection using Spring's conversion service. The result might have been any implementer of the _Collection_ interface based on internal conditions:

```java
ConversionService conversionService = DefaultConversionService.getSharedInstance();
Collection<String> stringCollection = conversionService.convert(stringArray, Collection.class);

// The resultant stringCollection could be any type of Collection (e.g., Set, Queue, etc.)
```

#### After the Change

With the update in Spring Framework 6, converting the same array to a _Collection_ will consistently return a _List_:

```java
String[] stringArray = {"apple", "banana", "cherry"};

ConversionService conversionService = DefaultConversionService.getSharedInstance();
Collection<String> stringCollection = conversionService.convert(stringArray, Collection.class);

// The resultant stringCollection is now guaranteed to be of type List
if (stringCollection instanceof List) {
    System.out.println("The converted collection is a List!");
}
```

This change ensures that developers can expect a consistent type (List) when performing array-to-collection conversions, eliminating any uncertainty associated with the target collection type.

### Improvements in _ThreadPoolTaskExecutor_ and _ThreadPoolTaskScheduler_ ensure seamless application context termination

In the updated Spring Framework, two components, _ThreadPoolTaskExecutor_ and _ThreadPoolTaskScheduler_, have been enhanced to ensure a more seamless shutdown process when closing the application context. By default, these components will not accept any new task submissions during the shutdown phase. However, for situations where task submissions are still required during shutdown, there's an option to adjust a flag, though it might lead to a prolonged shutdown phase.

#### Default Behavior

When the application context begins its closure process:

```java
ApplicationContext context = new AnnotationConfigApplicationContext(MyAppConfig.class);
// ... your application logic here ...
context.close();
```

Both _ThreadPoolTaskExecutor_ and _ThreadPoolTaskScheduler_ will enter a graceful shutdown mode:

```java
ThreadPoolTaskExecutor taskExecutor = context.getBean(ThreadPoolTaskExecutor.class);
// This will throw an exception as new tasks cannot be submitted during shutdown by default
taskExecutor.execute(() -> System.out.println("New Task!"));
```

#### Customized Behavior

If you need to allow task submissions during the context's closure, adjust the _acceptTasksAfterContextClose_ flag:

```java
ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
taskExecutor.setAcceptTasksAfterContextClose(true);

ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
taskScheduler.setAcceptTasksAfterContextClose(true);
```

By setting the flag to _true_, the components can still accept new tasks even during the shutdown. But keep in mind, enabling this flag may prolong the time it takes for the application context to completely close.

### _ApplicationContext_'s message resolution is now tightly linked to its active phase, enhancing consistency.

The _ApplicationContext_ in the updated Spring Framework has seen improvements in its message resolution process. Now, attempts to retrieve messages from its internal _MessageSource_ are restricted to when the context is actively running. If there are attempts to fetch messages after the context has been closed, an exception will be raised.

#### Successful Message Retrieval

When the _ApplicationContext_ is active, retrieving messages works seamlessly:

```java
ApplicationContext context = new AnnotationConfigApplicationContext(MyAppConfig.class);
String message = context.getMessage("welcome.message", null, Locale.US);
System.out.println(message);  // Outputs the corresponding welcome message
```

#### Unsuccessful Message Retrieval

However, if you try to access the message after the context has been closed, it will result in an exception:

```java
ApplicationContext context = new AnnotationConfigApplicationContext(MyAppConfig.class);
context.close();

// This will throw an IllegalStateException since the context is no longer active
String message = context.getMessage("farewell.message", null, Locale.US);
```

In essence, the changes ensure that developers are only fetching messages when the context is in the right state, leading to more predictable and consistent behavior.

### Verbose logging for pre-computed fields during native image construction has been disabled by default but can be re-enabled with the _-Dspring.native.precompute.log=verbose_ compiler argument.

While creating a native image in Spring, the detailed logs concerning pre-computed fields are now off by default. However, if you want to view these logs, you can activate them using the _-Dspring.native.precompute.log=verbose_ argument during the compilation process.

#### Without Verbose Logging

When you build a native image without any additional arguments, you won't see the verbose logs related to pre-computed fields:

```bash
$ native-image -jar myApp.jar
```

#### With Verbose Logging

To get a detailed view of the pre-computed fields while building the native image, add the specific argument:

```bash
$ native-image -jar myApp.jar -Dspring.native.precompute.log=verbose
```

Upon executing this, the compiler will display the verbose logs related to pre-computed fields, offering more insights during the image construction process.

## Progressive Data Access and Transaction Handling

Data operations and transactions get a boost with strategic enhancements:
- Misconfigured _@Transactional_ annotations are promptly identified, safeguarding transactional operations.
- **JPA** initialization errors are now more descriptive, aiding developers in rectifying configurations.
- The **JpaTransactionManager**, in tandem with **HibernateJpaDialect**, offers refined exception handling, streamlining data operations.


## Web Applications: Redefining Standards

Web development with Spring sees groundbreaking changes:
- **Spring MVC** and **WebFlux** now incorporate method validation for controller inputs, elevating data integrity.
- Exception messaging has been refashioned, ensuring clearer communication to developers.
- Mapping prioritization has been refined, guaranteeing consistency.
- Enhancements to annotations like _@RequestParam_ and _@RequestHeader_ make data acquisition more developer-friendly.
- Both the **HTTP client** and **server** interfaces have been restructured for optimal timeout management and error tracking.

### Spring MVC and WebFlux now incorporate method validation for controller inputs, elevating data integrity.

**Spring MVC** and **WebFlux** have introduced a more enhanced method validation for controller inputs, ensuring better data quality. This validation specifically targets controller method parameters using @Constraint annotations.

#### Before Method Validation

In previous setups, you might have had a controller like:

```java
@RestController
@Validated
public class MyController {
    @PostMapping("/endpoint")
    public ResponseEntity<?> processData(@Valid MyRequestBody body) {
        // process data
    }
}
```

With this setup, validations were typically applied at the argument resolver level.

#### With Method Validation

Now, with the new method validation:

```java
@RestController
public class MyController {
    @PostMapping("/endpoint")
    public ResponseEntity<?> processData(@Constraint(MyConstraint.class) String input, @Valid MyRequestBody body) {
        // process data
    }
}
```

In this example:
- _@Constraint(MyConstraint.class)_ directly validates the _input_ method parameter.
- _@Valid_ is still used for complex objects like request bodies, but the validation happens at the method level.
- If there's no _BindingResult_, and method validation fails, then a _MethodValidationException_ is raised.

To fully utilize this, you should:
1. Remove _@Validated_ from the controller class.
2. Ensure the validator beans (_mvcValidator_ or _webFluxValidator_) use _jakarta.validation.Validator_, like _LocalValidatorFactoryBean_.
3. Apply constraint annotations directly on method parameters.

Remember, this avoids the risk of double validation and centralizes the validation process for better consistency and clarity.

## Amplifying Message-Driven Applications

The focus is clear: heightened security and superior functionality:
- The **RSocket interface client** is now aligned with the RSocket client's default timeout configurations.
- To fortify applications, **SpEL** expressions from questionable origins are now barred by default in WebSocket messaging, enhancing security protocols.

For Message-Driven Applications, there are significant enhancements in security and functionality. The **RSocket interface client** has changed its default timeout approach, relying more on the RSocket client's settings. Also, to boost security, **SpEL** expressions evaluation from questionable sources has been disabled by default, especially in WebSocket messaging.

### RSocket Interface Client

Previously, there might have been a 5-second default timeout on certain methods. This has been altered:

```java
// Older Approach: The RSocket interface client had its own default timeout.
RSocketRequester requester = ...;
String response = requester.route("some.route").data("request").retrieveMono(String.class).block();

// New Approach: The timeout now depends on the configuration of the RSocket client and its transport.
RSocketRequester.Builder builder = ...;
RSocketRequester requester = builder.connectTcp("localhost", 7000).block();
```

The change provides more flexibility, as the timeout behavior is primarily dictated by the RSocket client and its transport settings. See reference issue [#30248](https://github.com/spring-projects/spring-framework/issues/30248).

### SpEL Expressions in WebSocket Messaging

To improve security, SpEL expressions evaluation from untrusted sources is turned off by default in WebSocket messaging. If you need the SpEL-based selector header support, it needs to be explicitly enabled:

```java
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // Explicitly enabling the selector header
        registry.enableSimpleBroker().setSelectorHeaderName("selector");
    }
}
```

This means that by default, applications won't evaluate potentially harmful SpEL expressions, especially in WebSocket scenarios. If needed, developers can opt-in with the above configuration. See reference issue [#30550](https://github.com/spring-projects/spring-framework/issues/30550)

## Seamless Migration from Prior Versions

Transitioning from Spring Framework 5.x to 6.x? Here's a concise migration guide:
- Annotations, including @Inject, now reside under jakarta.inject, while annotations like @PostConstruct and @PreDestroy have transitioned to jakarta.annotation.
- Bean property identification in the core container has deviated from the default java.beans.Introspector
- Emphasis is on migrating from ListenableFuture to CompletableFuture, ensuring concurrent task handling efficiency.

### Annotations Transition to Jakarta Packages in Spring

In recent changes to the Spring framework, specific annotations have undergone a transition to new namespaces, reflecting broader shifts in the Java ecosystem. These transitions are fundamental and crucial for developers to comprehend and adapt to, ensuring the smooth operation of their applications.

#### Migration to jakarta.inject and jakarta.annotation

In response to the modifications in JSR-330 and JSR-250 standards, the annotations, including _@Inject_, have been moved to the _jakarta.inject_ namespace. Similarly, other prominent annotations like _@PostConstruct_ and _@PreDestroy_ have been transitioned to _jakarta.annotation_.

Consider a previous implementation:

```java
import javax.inject.Inject;
import javax.annotation.PostConstruct;

public class SampleService {
    @Inject
    private SomeDependency someDependency;

    @PostConstruct
    public void init() {
        // Initialization logic
    }
}
```

In the updated scenario, the imports would shift to:

```java
import jakarta.inject.Inject;
import jakarta.annotation.PostConstruct;
```

It's worth noting that, for the time being, Spring will continue detecting the old _javax_ equivalents, which is beneficial for those applications relying on pre-compiled binaries.

### Bean Property Identification Changes in Spring's Core Container

The core container of Spring has undergone a significant shift in how it identifies bean properties. Traditionally, it relied on the default _java.beans.Introspector_. However, recent updates showcase a deviation from this norm.

**Transition from _java.beans.Introspector_**

Spring's core container now determines basic bean properties without resorting to the default _java.beans.Introspector_. This change aims to enhance efficiency but can lead to disparities for those accustomed to the 5.3.x version and its intricate JavaBeans usage.

For those who wish to maintain full compatibility with the 5.3.x version, there's a provision to revert to the older style. By specifying the content _org.springframework.beans.BeanInfoFactory=org.springframework.beans.ExtendedBeanInfoFactory_ in a _META-INF/spring.factories_ file, users can enable the full utilization of _java.beans.Introspector_ as was the case in version 5.3.

On the flip side, users who are still on 5.3.x but wish to experience the improved introspection performance of the 6.0-style property determination can do so. This can be achieved by inserting _org.springframework.beans.BeanInfoFactory=org.springframework.beans.SimpleBeanInfoFactory_ in a custom _META-INF/spring.factories_ file.

**Other Notable Changes**

- The transition from _javax_ annotations to _jakarta_ annotations is evident with the core container now detecting _@Inject_ in _jakarta.inject_ and both _@PostConstruct_ and _@PreDestroy_ in _jakarta.annotation_. For now, Spring also recognizes the _javax_ equivalents.

- _LocalVariableTableParameterNameDiscoverer_ is on its way out, being deprecated. Any successful resolution attempt by it will trigger a warning. To evade this warning, users are advised to compile Java sources using the Java 8+ _-parameters_ flag rather than the _-debug_ compiler flag.

- _LocalValidatorFactoryBean_ has updated its dependency to rely on standard parameter name resolution under Bean Validation 3.0. This configuration also considers additional Kotlin reflection if Kotlin is detected in the system. Hence, for parameter names in Bean Validation setups, it's recommended to compile Java sources with the Java 8+ _-parameters_ flag.

- A shift in preference from _ListenableFuture_ to _CompletableFuture_ is evident, with the former being deprecated.

- The core container has now implemented a strict checking mechanism for methods with the _@Async_ annotation. They must return either _Future_ or _void_, and this rule is now actively enforced.

- Lastly, _SimpleEvaluationContext_ has made changes that disable array allocations. This change is in line with the regular constructor resolution practices.

In summary, these transformations reflect Spring's continuous efforts to optimize its core container, ensuring it remains robust and efficient for developers.

### Migrating from _ListenableFuture_ to _CompletableFuture_: Enhancing Concurrent Task Handling

The evolution of concurrent task handling in software applications has seen a pivotal shift. One of the significant changes in recent times is the migration from _ListenableFuture_ to _CompletableFuture_. This transition isn't just a mere replacement of one library for another. Instead, it epitomizes an effort to embrace modern capabilities and ensure efficiency in concurrent operations.

#### Background Context
Historically, the Spring framework has employed _ListenableFuture_ for managing asynchronous computation tasks. This approach provided a mechanism to register callbacks that would execute once the asynchronous task was completed. While useful, the capabilities of _ListenableFuture_ were limited compared to the more contemporary _CompletableFuture_.

#### Why CompletableFuture?
_CompletableFuture_ offers a more robust and flexible API for asynchronous programming. It doesn't just allow the registration of callbacks but also supports combining multiple asynchronous computations, thus enabling developers to chain tasks seamlessly. Its non-blocking nature further ensures that resources are used optimally, reducing the overhead and potential for bottlenecks.

#### Migration Implications
For those still reliant on _ListenableFuture_, it's crucial to understand its deprecation. The recommendation is to transition to _CompletableFuture_ to leverage its advanced capabilities. This shift has been highlighted in notable Spring updates, such as 
reference issue [#27780](https://github.com/spring-projects/spring-framework/issues/27780)

## In Conclusion

As we stand on the precipice of technological evolution in the Java ecosystem, Spring Framework 6.x shines as a beacon of innovation, setting new standards in software development. It's more than just an upgrade; it encapsulates Spring's vision of continuous innovation, enhanced security, and equipping developers with futuristic tools. With each iteration, the framework has consistently demonstrated an unyielding commitment to enhancing the developer experience, streamlining integrations, fortifying security, and fostering a vibrant development environment. Recognizing the changes and their implications is crucial for smooth integration. Let's summarize the monumental strides this latest release takes and how it paves the way for the future, urging developers to harness these novelties and architect state-of-the-art applications.

### The Dawn of New Standards

#### Harnessing the Power of Baseline Upgrades
Dovetailing with modern technologies ensures the framework remains contemporary and pertinent. The upgrades to essential libraries like **SnakeYAML**, **Jackson**, and **Kotlin** (both **Coroutines** and **Serialization**) are not mere incremental changes but strategic decisions to keep the ecosystem vibrant, efficient, and forward-compatible.

#### Reimagining the Core Container
The meticulous refinements in the core container showcase Spring's dedication to adaptability. From a more seamless URL resolution mechanism aligning with JDK 20's developments to the modern _createBean(Class)_ method for intuitive bean creation, Spring Framework 6.x demonstrates an unwavering focus on improving the foundational components.

#### Elevating Data Access & Transaction Management
By addressing and enhancing user experience subtleties, like clearer error messaging in **JPA** bootstrapping and a more intuitive exception handling mechanism, the framework strengthens its commitment to seamless data access and robust transactional integrity.

#### Web Development's Paradigm Shift
With groundbreaking enhancements to both **Spring MVC** and **WebFlux**, Spring Framework 6.x is shaping the future of web development. The thoughtful refinements, ranging from enhanced validation for controller parameters to the rejuvenation of HTTP client-server interfaces, underscore a vision for a web that's more responsive, secure, and developer-friendly.

#### A Commitment to Secure Messaging
In an age where security is paramount, Spring's strategic decisions to fortify its messaging applications — like the recalibration of the **RSocket interface client** and the pro-security move to disable certain **SpEL** expressions by default — resonate with the needs of contemporary applications.

### The Path Forward: Transitioning with Foresight

Migration to Spring Framework 6.x, though promising, necessitates an understanding of its nuances. It's pivotal to recognize the relocations of pivotal annotations and the shift in mechanisms like bean property determination. The subtle nudge towards _CompletableFuture_ from _ListenableFuture_ further epitomizes Spring's vision of embracing modernity.

### Final Thoughts: Embracing Spring Framework 6.x's Pioneering Spirit

In essence, Spring Framework 6.x isn't merely an upgrade — it's a testament to the framework's evolutionary spirit, consistently pushing the envelope in the realms of innovation, security, and efficiency. It heralds a new era for Java developers, offering a suite of tools and enhancements tailored for the challenges and opportunities of tomorrow. Embracing this release is not just about leveraging its features but about aligning with a vision of progressive, secure, and efficient software development. As developers and technology enthusiasts, the call is clear: to welcome, understand, and harness the power of Spring Framework 6.x to shape the future of robust, scalable, and innovative applications.
