---
title: "Spring Bean Scopes"
title_style: title
canonical_url: https://www.kapresoft.com/java/2023/05/16/spring-bean-scopes.html
category: java
related: spring
description: "Discover Spring bean scopes in this guide. Learn singleton, prototype, and custom scopes for flexible application development."
---

## Overview

**Understanding and Utilizing Bean Scopes in the Spring Framework**

In this article, we will delve into the concept of bean scopes in [Spring Framework](https://docs.spring.io/spring-framework/reference/index.html). Understanding and effectively utilizing bean scopes is essential for controlling the lifecycle and behavior of your beans, allowing you to enhance the flexibility and power of your Spring applications.<!--excerpt--> We will explore the different bean scopes available in Spring, discuss their significance, and provide guidance on how to leverage them effectively.

In Spring Framework, a bean definition acts as a recipe for creating object instances. Similar to a class, you can create multiple object instances from a single bean definition. Bean scopes allow you to control not only the dependencies and configuration values plugged into an object but also the scope of the objects created.

By configuring the scope of a bean, you can determine its lifecycle and how it is managed within the Spring container. Spring offers several predefined scopes, such as Singleton, Prototype, Request, Session, Application, and WebSocket, each catering to different use cases and requirements.

## Singleton Scope

### A Brief Overview of the Singleton Pattern

Singleton is a widely used design pattern in software development ad defined in the [Gang of Four (GoF)](https://en.wikipedia.org/wiki/Design_Patterns) patterns book, and it represents a concept where only one instance of a class can exist in the system, in this case the JVM. 

In the context of the Spring Framework, the Singleton scope refers to the creation of a single instance of a bean within the Spring container. This means that whenever a bean with Singleton scope is requested, the container will always return the same instance, which is cached for subsequent requests. The Singleton scope is the default scope in Spring and is suitable for stateless and shared objects.

Here's a Java example (without Spring) to illustrate the Singleton scope:

```java
public class SingletonExample {
    private static SingletonExample instance;

    private SingletonExample() {
        // Private constructor to prevent direct instantiation
    }

    public static SingletonExample getInstance() {
        if (instance == null) {
            synchronized (SingletonExample.class) {
                if (instance == null) {
                    instance = new SingletonExample();
                }
            }
        }
        return instance;
    }

    // Other methods and properties...
}
```

In this example, _SingletonExample_ is a class that follows the Singleton design pattern. The _getInstance()_ method provides a way to access the single instance of the class. The instance is lazily created upon the first call to _getInstance()_ and subsequently returned for all subsequent calls.

To use the _SingletonExample_ class, you can obtain the instance as follows:

```java
SingletonExample singleton = SingletonExample.getInstance();
```

Regardless of how many times you call _getInstance()_, you will always receive the same instance of the _SingletonExample_ class. This ensures that the Singleton object is effectively a shared resource throughout your application.

### Singleton Scope in Spring Framework

The Singleton scope is the default scope in Spring. When a bean is defined as a singleton, the Spring IoC container creates a single instance of the object defined by that bean definition. This single instance is stored in a cache, and all subsequent requests for that bean return the cached object.

It's important to note that **Spring's singleton scope is different from the singleton pattern** defined in the Gang of Four (GoF) patterns book. While the GoF singleton restricts the creation of a single instance per ClassLoader, the **Spring singleton scope is per-container and per-bean**. This means that each bean defined in a Spring container has its own singleton instance.

To define a bean as a singleton in XML configuration, you can use either of the following approaches:

```xml
<bean id="accountService" class="com.something.DefaultAccountService"/>
<!-- The following is equivalent, though redundant (singleton scope is the default) -->
<bean id="accountService" class="com.something.DefaultAccountService" scope="singleton"/>
```

The Singleton scope ensures that only one shared instance of a bean is managed within the container, making it suitable for stateless and shared objects.

## Prototype Scope

Unlike the Singleton scope, the **Prototype scope creates a new bean instance every time it is requested**. Each request for a bean with the Prototype scope results in the creation of a distinct object. This provides a fresh instance of the bean for each usage, allowing for more fine-grained control over its lifecycle.

To define a bean with the Prototype scope, you can use the following XML configuration:

```xml
<bean id="beanName" class="com.example.MyBean" scope="prototype"/>
```

It's important to note that with the Prototype scope, the responsibility of **managing the bean's lifecycle falls upon the client or the application itself**. The Spring container does not keep track of Prototype beans once they are created. To release resources held by Prototype-scoped beans, a custom bean post-processor can be used.

Suppose you have a _Task_ class that represents a task in your application. Each time a new task is created, you want it to be a fresh instance with its own state. In such a scenario, you can use the prototype scope for the _Task_ bean to ensure that a new instance is created every time it is requested.

```java
@Component
@Scope("prototype")
public class Task {
    private String title;

    public Task(String title) {
        this.title = title;
    }

    // Getters and setters

    // Other methods
}
```

In the above example, the _Task_ class is annotated with _@Component_ to indicate that it is a Spring-managed bean. The _@Scope("prototype")_ annotation specifies the prototype scope, ensuring that a new instance of the _Task_ bean is created each time it is requested.

Now, whenever you need to create a new task, you can simply inject the _Task_ bean into another component or retrieve it from the application context:

```java
@Component
public class TaskManager {
    private TaskFactory taskFactory;

    public TaskManager(TaskFactory taskFactory) {
        this.taskFactory = taskFactory;
    }

    public void createTask(String title) {
        Task newTask = taskFactory.createTask(title);
        // Perform operations on the new task
    }
}
```

In the _TaskManager_ class, the _TaskFactory_ is injected, which can be used to create new instances of the _Task_ bean with the specified title. Each time the _createTask_ method is called, a new _Task_ instance will be created, allowing you to work with distinct and independent task objects.

The _TaskFactory_ can be a separate class responsible for creating instances of the _Task_ bean. Here's an example of how the _TaskFactory_ class could be implemented:

```java
@Component
public class TaskFactory {

    private final ApplicationContext applicationContext;

    public TaskFactory(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }

    public Task createTask(String title) {
        // Calls the ApplicationContext directly 
        // to create the Prototype Task instance.
        return applicationContext.getBean(Task.class, title);
    }
}
```

In the above example, the _TaskFactory_ class is annotated with _@Component_ to make it a Spring-managed bean. The _TaskFactory_ class has a dependency on the _ApplicationContext_, which is injected through the constructor.

The _createTask_ method takes the task title as a parameter and uses the _applicationContext.getBean()_ method to retrieve a new instance of the _Task_ bean from the Spring container. The _getBean()_ method accepts the _Task.class_ parameter to indicate the bean type and the _title_ parameter to pass as an argument to the _Task_ bean's constructor.

By using the _TaskFactory_ class in conjunction with the prototype scoped _Task_ bean, you can dynamically create new instances of the _Task_ bean with different titles whenever needed.

### Misunderstandings

The Prototype scope in Spring is often misunderstood due to some common misconceptions. Let's explore these misunderstandings and provide clarity on the behavior of Prototype scoped beans.

#### Misunderstanding 1:  Prototype beans are created for each method invocation

Some developers **mistakenly assume that a new instance of a Prototype scoped bean is created every time a method of that bean is invoked**. However, this is not the case. The Spring container creates a new instance of the Prototype bean when it is initially requested, and this instance is then reused for subsequent method invocations.

To illustrate this, consider the following example:

```java
@Component
@Scope("prototype")
public class PrototypeBean {
    private static int instanceCount = 0;
    private int instanceNumber;

    public PrototypeBean() {
        instanceCount++;
        instanceNumber = instanceCount;
        System.out.println("Creating PrototypeBean instance: " + instanceNumber);
    }

    public void performAction() {
        System.out.println("Performing action in PrototypeBean instance: " + instanceNumber);
    }
}
```

In this example, the _PrototypeBean_ class is annotated with _@Scope("prototype")_ to define its scope as Prototype. Each time the _PrototypeBean_ is requested, a new instance is created and assigned a unique _instanceNumber_. The constructor of the _PrototypeBean_ logs the creation of each instance, and the _performAction()_ method simply prints the instance number.

Now, let's see how the Prototype bean is used:

```java
@Component
public class ClientBean {
    private final PrototypeBean prototypeBean;

    public ClientBean(PrototypeBean prototypeBean) {
        this.prototypeBean = prototypeBean;
    }

    public void doSomething() {
        prototypeBean.performAction();
    }
}
```

In the _ClientBean_ class, we have a dependency on the _PrototypeBean_. The _doSomething()_ method simply invokes the _performAction()_ method on the _PrototypeBean_.

If we now execute the following code:

```java
public static void main(String[] args) {
    AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext();
    context.register(ClientBean.class, PrototypeBean.class);
    context.refresh();

    ClientBean clientBean1 = context.getBean(ClientBean.class);
    clientBean1.doSomething();

    ClientBean clientBean2 = context.getBean(ClientBean.class);
    clientBean2.doSomething();

    context.close();
}
```

The output will be:

```
Creating PrototypeBean instance: 1
Performing action in PrototypeBean instance: 1
Performing action in PrototypeBean instance: 1
```

As you can see, even though the _doSomething()_ method is invoked on two separate instances of _ClientBean_, the same instance of _PrototypeBean_ is reused for both invocations.

#### Misunderstanding 2: Spring manages the lifecycle of Prototype beans

**Another common misunderstanding is that Spring automatically manages the lifecycle of Prototype scoped beans**, such as destroying them when they are no longer in use. However, Spring does not keep track of Prototype beans once they are created. It's the responsibility of the client or the application itself to handle the destruction of Prototype beans when necessary.

To demonstrate this, let's modify the previous example by adding a _destroy()_ method to the _PrototypeBean_ class:

```java
@Component
@Scope("prototype")
public class PrototypeBean {
    // ...

    @PreDestroy
    public void destroy() {
        System.out.println("Destroying PrototypeBean instance: " + instanceNumber);
    }
}
```

The _destroy()_ method is annotated with _@PreDestroy_, indicating that it should be called before the Prototype bean is destroyed.

If we update the _main()_ method as follows:

```java
public static void main(String[]

 args) {
    AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext();
    context.registerShutdownHook(); // Registers a shutdown hook to ensure proper closing of the context

    context.register(ClientBean.class, PrototypeBean.class);
    context.refresh();

    ClientBean clientBean1 = context.getBean(ClientBean.class);
    clientBean1.doSomething();

    context.close(); // Closing the context

    ClientBean clientBean2 = context.getBean(ClientBean.class);
    clientBean2.doSomething();
}
```

The output will be:

```
Creating PrototypeBean instance: 1
Performing action in PrototypeBean instance: 1
Destroying PrototypeBean instance: 1
Creating PrototypeBean instance: 2
Performing action in PrototypeBean instance: 2
```

As you can see, the _destroy()_ method of the Prototype bean is not invoked when the Spring context is closed. The destruction of Prototype beans is not managed by Spring, and it's the responsibility of the application to handle their cleanup.

These examples help clarify the misconceptions surrounding the Prototype scope in Spring. It's important to understand that Prototype beans are not created on every method invocation and that Spring does not manage their lifecycle. By being aware of these aspects, you can effectively utilize Prototype scoped beans in your applications.



## Request Scope

The request scope in Spring is specifically designed for web applications and allows you to create beans that are tied to a specific HTTP request. When a bean is defined with the request scope, a new instance of that bean is created for each incoming request, and it is discarded once the request processing is complete.

To define a bean with the request scope, you can use the following XML configuration:

```xml
<bean id="loginAction" class="com.something.LoginAction" scope="request"/>
```

In addition to XML configuration, if you're using annotation-driven components or Java configuration, you can utilize the _@RequestScope_ annotation to assign a component to the request scope. Here's an example in Java:

```java
@RequestScope
@Component
public class LoginAction {
    // ...
}
```

The request scope is useful when you have components that need to maintain state or hold request-specific data. Each request will have its own instance of the bean, ensuring that the data is isolated and specific to that particular request.

## Session Scope

The session scope allows you to create beans that are tied to a user's session in a web application. A new instance of a session-scoped bean is created for each user session and is available throughout the entire session's lifespan.

To define a bean with the session scope, you can use the following XML configuration:

```xml
<bean id="sessionBean" class="com.something.SessionBean" scope="session"/>
```

Similarly, if you're using annotation-driven components or Java configuration, you can annotate a class with _@SessionScope_ to assign it to the session scope:

```java
@SessionScope
@Component
public class SessionBean {
    // ...
}
```

Components with session scope are useful when you need to maintain user-specific data or store user preferences throughout their session. Each user will have their own instance of the bean, ensuring data separation and personalized behavior.

## Application Scope

The application scope in Spring is similar to a singleton bean but with some key differences. It creates a single instance of a bean per ServletContext, rather than per Spring ApplicationContext, making it accessible throughout the entire web application.

To assign a component to the application scope using annotation-driven components or Java configuration, you can use the _@ApplicationScope_ annotation. Here's an example in Java:

```java
@ApplicationScope
@Component
public class AppPreferences {
    // ...
}
```

Alternatively, you can define the application scope in XML configuration for a bean definition. Here's an example:

```xml
<bean id="appPreferences" class="com.something.AppPreferences" scope="application"/>
```

Components with application scope are shared across all users and sessions within the web application. They are useful for storing application-wide settings or caching data that needs to be accessed globally.

## WebSocket Scope

The WebSocket scope in Spring Framework is associated with the lifecycle of a WebSocket session. It applies to applications that use STOMP (Simple Text Oriented Messaging Protocol) over WebSocket.

The WebSocket scope is only valid in the context of a web-aware Spring ApplicationContext. It allows scoping a single bean definition to the lifecycle of a WebSocket.

Unfortunately, there is no specific annotation like _@WebSocketScope_ available for assigning a component to the WebSocket scope directly. The WebSocket scope is automatically applied when using STOMP over WebSocket applications.

## 8. Custom Scopes

In addition to the predefined bean scopes, Spring Framework also allows you to define custom scopes to suit your specific requirements. You can implement a custom scope by creating a class that implements the _org.springframework.beans.factory.config.Scope_ interface and overriding its methods.

Once you have implemented your custom scope, you need to make the Spring container aware of it. This can be done programmatically or declaratively using the _CustomScopeConfigurer_ class.

**Java-based Configuration:**

```java
import org.springframework.beans.factory.config.CustomScopeConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
    @Bean
    public CustomScopeConfigurer customScopeConfigurer() {
        CustomScopeConfigurer configurer = new CustomScopeConfigurer();
        configurer.addScope("customScope", new CustomScopeImplementation());
        return configurer;
    }
}
```

In this example, we use the _@Configuration_ annotation to indicate that the class is a configuration class. The _customScopeConfigurer_ method is annotated with _@Bean_, which tells Spring to treat the returned object as a bean and manage its lifecycle.

Inside the _customScopeConfigurer_ method, we create an instance of _CustomScopeConfigurer_ and add our custom scope using the _addScope_ method. The first argument is the name of the scope, which in this case is "customScope", and the second argument is an instance of your custom scope implementation (_CustomScopeImplementation_ in this example).

Ensure that you have defined your custom scope implementation (_CustomScopeImplementation_) correctly before using it in the configuration.

With this configuration in place, Spring will be aware of your custom scope and use it when managing beans annotated with _@Scope("customScope")_.

### Example Custom Scope Implementation

In this example, the _CustomScopeImplementation_ class implements the _Scope_ interface from the Spring Framework. It maintains two maps: _scopedObjects_ to store the instances of scoped objects and _destructionCallbacks_ to store the destruction callbacks associated with each object.

```java
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.config.Scope;

import java.util.HashMap;
import java.util.Map;

public class CustomScopeImplementation implements Scope {
    private final Map<String, Object> scopedObjects = new HashMap<>();
    private final Map<String, Runnable> destructionCallbacks = new HashMap<>();

    @Override
    public Object get(String name, ObjectFactory<?> objectFactory) {
        if (!scopedObjects.containsKey(name)) {
            scopedObjects.put(name, objectFactory.getObject());
        }
        return scopedObjects.get(name);
    }

    @Override
    public Object remove(String name) {
        destructionCallbacks.remove(name);
        return scopedObjects.remove(name);
    }

    @Override
    public void registerDestructionCallback(String name, Runnable callback) {
        destructionCallbacks.put(name, callback);
    }

    @Override
    public Object resolveContextualObject(String key) {
        return null;
    }

    @Override
    public String getConversationId() {
        return null;
    }
}
```

The _get()_ method retrieves the object from the scopedObjects map. If the object is not found, it is created using the provided _ObjectFactory_ and added to the map.

The _remove()_ method removes the object from the scopedObjects map and removes the associated destruction callback.

The _registerDestructionCallback()_ method stores the destruction callback for a given object name.

The _resolveContextualObject()_ method is not used in this example and returns _null_.

The _getConversationId()_ method is also not used in this example and returns _null_.

Note: This is a basic example to illustrate the custom scope implementation. In a real-world scenario, you may need to handle concurrency, manage scope lifecycle, and perform other operations based on your specific requirements.

### Custom Scope Usage

Once you have implemented your custom scope, you can configure it in Spring Configuration. To use a custom scope with a Spring bean annotated with _@Component_, you can specify the custom scope using the _@Scope_ annotation. Here's an example:

```java
import org.springframework.beans.factory.config.CustomScopeConfigurer;
import org.springframework.beans.factory.config.Scope;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.Map;

@Component
@Scope("customScope")
public class CustomScopedBean {
    private final String name;

    public CustomScopedBean() {
        this.name = "CustomScopedBean";
    }

    @PostConstruct
    public void init() {
        System.out.println("Initializing CustomScopedBean");
    }

    public void doSomething() {
        System.out.println("CustomScopedBean: " + name);
    }
}
```

In this example, the _CustomScopedBean_ is annotated with _@Component_ to indicate that it is a Spring-managed bean. The _@Scope("customScope")_ annotation specifies the custom scope to be used for this bean.

Assuming you have configured the custom scope correctly in your Spring configuration, when the application context is created, an instance of _CustomScopedBean_ will be created and managed according to the custom scope's rules.

You can then use the _CustomScopedBean_ in other components or services just like any other Spring-managed bean. For example, you can inject it into another component:

```java
@Component
public class AnotherComponent {
    private final CustomScopedBean customScopedBean;

    public AnotherComponent(CustomScopedBean customScopedBean) {
        this.customScopedBean = customScopedBean;
    }

    public void doSomething() {
        customScopedBean.doSomething();
    }
}
```

In this example, the _AnotherComponent_ has a dependency on _CustomScopedBean_ and it is injected through the constructor. The _CustomScopedBean_ instance used in _AnotherComponent_ will be the one managed by the custom scope.

Make sure that your custom scope implementation and the custom scope name specified in _@Scope_ match with the configuration you provided in your Spring configuration file or class.



## Conclusion

Understanding and effectively utilizing bean scopes in Spring Framework is essential for controlling the lifecycle and behavior of your beans. By selecting the appropriate scope for your beans, you can achieve the desired level of control, data isolation, and sharing within your applications.

In this comprehensive guide, we have explored the various bean scopes available in Spring, including singleton, prototype, request, session, application, and WebSocket scopes. We have also discussed how to define beans with different scopes using XML configuration, annotations, and Java configuration.

Additionally, we have addressed commonly asked questions about Spring bean scopes, such as the difference between request and session scopes. Remember to choose the scope that aligns with your specific requirements and consider using custom scopes when necessary.

By leveraging the power of bean scopes, you can enhance the flexibility and scalability of your Spring applications, ensuring optimal performance and resource management.

If you have any further questions or need more information about Spring bean scopes, feel free to explore the [official Spring Framework documentation](https://docs.spring.io/spring-framework/reference/core/beans/factory-scopes.html) or consult the vibrant Spring community.

Happy coding with Spring bean scopes!
