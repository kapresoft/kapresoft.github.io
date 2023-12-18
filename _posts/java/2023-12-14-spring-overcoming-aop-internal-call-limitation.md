---
title: "Spring • Overcoming AOP Internal Call Limitation"
title_style: title2w
section_style: article1
category: java
related: spring
canonical_url: https://www.kapresoft.com/java/2023/12/14/spring-overcoming-aop-internal-call-limitation.html
description: "Explore the impact of Spring AOP's internal call limitation and affecting business logic."
---

## Overview

<a href="https://docs.spring.io/spring-framework/reference/core/aop.html" target="_blank" alt="Aspect-Oriented Programming (AOP) in Spring">Aspect-Oriented Programming (AOP) in Spring</a> offers a powerful way to encapsulate cross-cutting concerns, like logging, security, or transaction management, separate from the main business logic. However, it's not without its limitations, one of which becomes evident in the context of internal method calls.<!--excerpt--> 

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/spring-handling-aop-limitations-cover-44625e8.webp" alt="Image: Spring • Handling Aop Limitations">
</div>

In a typical Spring application, aspects are triggered by external method calls, but when a method within the same class calls another method of that class, the aspects don't get triggered. This subtle limitation can significantly impact the functionality and efficiency of a Spring application, especially in scenarios involving complex business logic.

In this article, we'll delve into a specific case study: the interaction between _OrderController_, _OrderService_, and _OrderAspect_ in a Spring application. We'll explore how the internal call limitation of Spring AOP affects the application, particularly focusing on the methods _order(product)_ and _ship(product)_ in the _OrderService_ class.

## Understanding Core Interactions in this Case Study

In a Spring framework-based application, the interaction between the _OrderController_, _OrderService_, and _OrderAspect_ is integral to the efficient processing of orders. These components collaborate, with each playing a distinct role in the application's workflow. Here, we'll delve into their specific functions and how they are supposed to interact, especially focusing on how Aspect-Oriented Programming (AOP) aspects are intended to function in an ideal scenario.

**Figure 1.**  Order Class Diagram

<div class="uml-diagram">
   <img src="https://www.planttext.com/api/plantuml/png/bPB1QWCX48RlFeKaborX0xc682aXX_QoeNa2ezFMu3gYxa8eVVVEQXOs2pbqGNOSll-VNtGVamofQorJLiR8cw0X7D2bWDP2u3-CqxV4eNs6q1i5V5ke-pO3As-bWjokV43TgKJOgLGlL7v0zEWY75qowSP-sNJUQ5o6hV2vJOz65oX-6ryTiFKM4kXii-LP-S3LIhepeMzj2zh81FRsN7L1j23TBDrhz40vTZkP2o76d39Wvuf9TKNZJhJkUHNGDFVrFdO7z-Po9VbKEWJxXv9YpQzdiLdmkXRvtppUKHSXSZOzmTh2PrgBEKW7qxqXMWYs1wU7n_07">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/bPB1QWCX48RlFeKaborX0xc682aXX_QoeNa2ezFMu3gYxa8eVVVEQXOs2pbqGNOSll-VNtGVamofQorJLiR8cw0X7D2bWDP2u3-CqxV4eNs6q1i5V5ke-pO3As-bWjokV43TgKJOgLGlL7v0zEWY75qowSP-sNJUQ5o6hV2vJOz65oX-6ryTiFKM4kXii-LP-S3LIhepeMzj2zh81FRsN7L1j23TBDrhz40vTZkP2o76d39Wvuf9TKNZJhJkUHNGDFVrFdO7z-Po9VbKEWJxXv9YpQzdiLdmkXRvtppUKHSXSZOzmTh2PrgBEKW7qxqXMWYs1wU7n_07" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=bPB1QWCX48RlFeKaborX0xc682aXX_QoeNa2ezFMu3gYxa8eVVVEQXOs2pbqGNOSll-VNtGVamofQorJLiR8cw0X7D2bWDP2u3-CqxV4eNs6q1i5V5ke-pO3As-bWjokV43TgKJOgLGlL7v0zEWY75qowSP-sNJUQ5o6hV2vJOz65oX-6ryTiFKM4kXii-LP-S3LIhepeMzj2zh81FRsN7L1j23TBDrhz40vTZkP2o76d39Wvuf9TKNZJhJkUHNGDFVrFdO7z-Po9VbKEWJxXv9YpQzdiLdmkXRvtppUKHSXSZOzmTh2PrgBEKW7qxqXMWYs1wU7n_07" target="_blank">PlantText</a>
   </small>
</div>

To illustrate the interaction between _OrderController_, _OrderService_, and _OrderAspect_ using PlantUML, we will represent these components and their relationships in a class diagram. Here's the PlantUML code that visualizes this interaction based on the provided Java code:

In this diagram:

- _OrderController_ has a dependency on _OrderService_, represented by a unidirectional association.
- _OrderService_ contains the methods _order(product)_ and _ship(product)_. The method _canShipImmediately()_ is private and therefore not accessible from outside the class.
- _OrderAspect_ is defined with two methods _aroundOrder()_ and _aroundShip()_, which advise the _order(product)_ and _ship(product)_ methods of _OrderService_, respectively. This advising relationship is depicted with a dotted line.
- The cardinality "1" indicates that one instance of _OrderController_ interacts with one instance of _OrderService_, and similarly for _OrderAspect_.

This diagram provides a high-level overview of the interactions between the three classes and how they are connected in the context of the Spring AOP framework.

### The _OrderController_

The _OrderController_ acts as the front-facing component that interacts with the user or the external system. It receives the order requests and delegates them to the _OrderService_ for processing.

```java
@RestController
public class OrderController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/order")
    public ResponseEntity<String> placeOrder(@RequestBody String product) {
        orderService.order(product);
        return ResponseEntity.ok("Order placed for " + product);
    }
}
```

In this example, the _OrderController_ exposes a POST endpoint where clients can place orders. It uses the _OrderService_ to process these orders.

### The _OrderService_

_OrderService_ is where the business logic for order processing resides. It includes methods like _order(product)_ and _ship(product)_.

```java
@Service
public class OrderService {

    public void order(String product) {
        // Order processing logic
        System.out.println("Ordering " + product);
        CompletedOrder completedOrder = ...;
        
        if (canShipImmediately(completedOrder)) {
            ship(completedOrder);
        }
    }

    public void ship(CompletedOrder order) {
        // Shipping logic
        System.out.println("Shipping " + order.getProduct());
    }

    private boolean canShipImmediately(CompletedOrder order) {
        // business logic determining whether the ordered
        // product can be shipped immediately
        return true;
    }
}
```

Here, the _order(product)_ method internally calls the _ship(product)_ method, which is where the AOP limitation becomes evident.

### The _OrderAspect_

_OrderAspect_ is designed to intercept calls to these methods and execute cross-cutting concerns like logging or security checks.

```java
@Aspect
@Component
public class OrderAspect {

    @Around("execution(* com.example.OrderService.order(..))")
    public Object aroundOrder(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("Before ordering");
        // Business Logic: Lock Product Inventory
        Object result = joinPoint.proceed();
        // Business Logic: Update Product Inventory
        CompletedOrder order = joinPoint.getArgs()[0];
        System.out.println("After ordering");
        return result;
    }

    @Around("execution(* com.example.OrderService.ship(..))")
    public Object aroundShip(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("Before shipping");
        Object result = joinPoint.proceed();
        // Business Logic: Send notification to interested parties
        CompletedOrder order = joinPoint.getArgs()[0];
        System.out.println("After shipping");
        return result;
    }
}
```

In an ideal scenario, when _OrderController_ calls _orderService.order(product)_, the _aroundOrder_ advice in _OrderAspect_ should get triggered, followed by the _aroundShip_ advice when _order(product)_ internally calls _ship(product)_. However, due to the internal method call limitation of Spring AOP, the _aroundShip_ advice does not get triggered when _ship(product)_ is called internally from _order(product)_.

### The Interaction Flow

The expected interaction flow is as follows:

1. _OrderController_ receives an order request and calls _orderService.order(product)_.
2. _OrderAspect_'s _aroundOrder_ gets triggered, adding additional logic around the _order(product)_ method.
3. Within _order(product)_, _ship(product)_ is called.
4. Ideally, _OrderAspect_'s _aroundShip_ should now be triggered to wrap additional logic around _ship(product)_.

However, due to Spring's proxy-based AOP mechanism, the _aroundShip_ advice is not executed in step 4, leading to the discussed limitation. This example illustrates the need for careful design considerations when using Spring AOP, particularly in scenarios involving internal method calls within the same bean.

## Overcoming Spring AOP's Internal Call Limitation: A Practical Solution

This title provides a clearer and more specific description of the content, emphasizing both the problem (Spring AOP's internal call limitation) and the nature of the content (a practical solution). It indicates to the reader that the article will not only discuss the issue but also provide actionable steps to address it.

The limitation of Spring's Aspect-Oriented Programming (AOP) in handling internal method calls within the same bean poses a significant challenge in certain scenarios, such as our _OrderService_ example. However, there are workarounds to overcome this limitation. One effective approach is to refactor the method that is not triggering the aspect (due to an internal call) into a separate service. In our case, this means moving the _ship(product)_ method from _OrderService_ to a new service, _OrderShippingService_. This restructuring ensures that the call to _ship(product)_ becomes an external one, allowing the AOP aspect to trigger as expected. Let's delve into how this can be implemented with Java code examples.

**Figure 2.**  Class Diagram with OrderShippingService Workaround

<div class="uml-diagram">
   <img src="https://www.planttext.com/api/plantuml/png/bLBTQiCW5BxtAQIxoIWfxBQKq55wiTsaR4zWzQop68-eoIXZxpuroKWClPWGEFdu_kIuTvvPtpQASCMSexKLO0-elKMbmD9lGiDvm0Y_W-qa1xhjMSDl8goDOXmIN1YBekK-q4xzz1Z6Dt06jOEZzjBVo0-Pvet6ix1FQOpKbpnq3lVXU3-tGoaIgUHCH_5Bqu2Gp8Ew5GTiZ08F8bblQVA9gZEY0gRpcbcblkxQ1VY-LIemztbs1aBFtOwbeQf69sQnrRr3SKMfJ-4RxiCXjDQNrn6DrlNv6kHJQMpu3sMebUzxzRIYfS0lNQQndk-zTU0ecO59C2KlzZOH3JVVAFZmcoftPwAJI-uVRs4yyCaUj8Wl-1S0">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/bLBTQiCW5BxtAQIxoIWfxBQKq55wiTsaR4zWzQop68-eoIXZxpuroKWClPWGEFdu_kIuTvvPtpQASCMSexKLO0-elKMbmD9lGiDvm0Y_W-qa1xhjMSDl8goDOXmIN1YBekK-q4xzz1Z6Dt06jOEZzjBVo0-Pvet6ix1FQOpKbpnq3lVXU3-tGoaIgUHCH_5Bqu2Gp8Ew5GTiZ08F8bblQVA9gZEY0gRpcbcblkxQ1VY-LIemztbs1aBFtOwbeQf69sQnrRr3SKMfJ-4RxiCXjDQNrn6DrlNv6kHJQMpu3sMebUzxzRIYfS0lNQQndk-zTU0ecO59C2KlzZOH3JVVAFZmcoftPwAJI-uVRs4yyCaUj8Wl-1S0" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=bLBTQiCW5BxtAQIxoIWfxBQKq55wiTsaR4zWzQop68-eoIXZxpuroKWClPWGEFdu_kIuTvvPtpQASCMSexKLO0-elKMbmD9lGiDvm0Y_W-qa1xhjMSDl8goDOXmIN1YBekK-q4xzz1Z6Dt06jOEZzjBVo0-Pvet6ix1FQOpKbpnq3lVXU3-tGoaIgUHCH_5Bqu2Gp8Ew5GTiZ08F8bblQVA9gZEY0gRpcbcblkxQ1VY-LIemztbs1aBFtOwbeQf69sQnrRr3SKMfJ-4RxiCXjDQNrn6DrlNv6kHJQMpu3sMebUzxzRIYfS0lNQQndk-zTU0ecO59C2KlzZOH3JVVAFZmcoftPwAJI-uVRs4yyCaUj8Wl-1S0" target="_blank">PlantText</a>
   </small>
</div>

To include the refactored _OrderShippingService_ in the PlantUML diagram, we'll adjust the relationships to show how _OrderService_ now interacts with this new service, and how _OrderAspect_ advises both services. Here's the updated PlantUML code:

In this refactored diagram:

- _OrderController_ continues to have a dependency on _OrderService_.
- _OrderService_ now has a dependency on _OrderShippingService_, represented by a unidirectional association. This change reflects the refactoring where the _ship(product)_ method has been moved to _OrderShippingService_.
- _OrderShippingService_ is a new class with the _ship(product)_ method.
- _OrderAspect_ now advises methods in both _OrderService_ and _OrderShippingService_.
- The advising relationships of _OrderAspect_ are updated to reflect that it now interacts with both _OrderService_ and _OrderShippingService_.

This updated diagram provides a clearer picture of the new architecture, illustrating how the refactoring has led to the separation of responsibilities between _OrderService_ and _OrderShippingService_, and how _OrderAspect_ is applied across these services.

### Refactoring to _OrderShippingService_

First, we create a new service, _OrderShippingService_, and move the _ship(product)_ method into it.

```java
@Service
public class OrderShippingService {

    public void ship(String product) {
        // Shipping logic
        System.out.println("Shipping " + product);
    }
}

```

### Updating _OrderService_

Next, we update the _OrderService_ to call the _ship(product)_ method from the _OrderShippingService_ instead of calling it internally.

```java
@Service
public class OrderService {

    @Autowired
    private OrderShippingService orderShippingService;

    public void order(String product) {
        // Order processing logic
        System.out.println("Ordering " + product);
        CompletedOrder completedOrder = ...;
        
        // External call to OrderShippingService's ship method
        if (canShipImmediately(completedOrder)) {
            orderShippingService.ship(completedOrder);
        }
    }
    
    private boolean canShipImmediately() {
        // business logic determining whether the ordered
        // product can be shipped immediately
        return true;
    }
}
```

### Updating _OrderAspect_

Finally, we update the _OrderAspect_ to include an around aspect on _OrderShippingService.ship(product)_.

```java
@Aspect
@Component
public class OrderAspect {

    @Around("execution(* com.example.OrderService.order(..))")
    public Object aroundOrder(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("Before ordering");
        // Business Logic: Lock Product Inventory
        Object result = joinPoint.proceed();
        // Business Logic: Update Product Inventory
        CompletedOrder order = joinPoint.getArgs()[0];
        System.out.println("After ordering");
        return result;
    }

    @Around("execution(* com.example.OrderShippingService.ship(..))")
    public Object aroundShip(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("Before shipping");
        // Business Logic: Send notification to interested parties
        Object result = joinPoint.proceed();
        CompletedOrder order = joinPoint.getArgs()[0];
        System.out.println("After shipping");
        return result;
    }
}
```

With these changes, the aspect _aroundShip_ in _OrderAspect_ will now be triggered when the _ship(product)_ method is called from the _OrderService_. This restructuring is a practical workaround to the internal method call limitation of Spring AOP, ensuring that the aspects are executed as intended, and the application's business logic remains intact and effective.

## Pros and Cons of AOP

Spring AOP is still a relevant and widely used feature in the Spring ecosystem. Its integration with the Spring Framework makes it an accessible option for developers to handle cross-cutting concerns like transaction management, logging, and security in a modular and reusable manner. While it might not be suitable for all scenarios, especially those requiring complex aspect-oriented programming beyond its proxy-based model, it remains a valuable tool for many typical enterprise applications. Its ease of use and integration with Spring beans make it a go-to choice for many developers working within the Spring environment.

### Disadvantages of Aspect-Oriented Programming (AOP)

Aspect-Oriented Programming (AOP), particularly in the context of Spring, provides a structured approach to managing cross-cutting concerns but is not without its challenges. The primary disadvantage of AOP is **the complexity it adds to the application's execution flow**. This complexity is twofold: firstly, it **makes the flow less transparent**, especially to those not well-versed in AOP, and secondly, **it can lead to developer frustration due to the implicit execution of "magic" code**. This lack of transparency complicates debugging and understanding the application's behavior.

Another significant limitation of Spring's AOP is its reliance on a proxy-based approach, which restricts its use to public method calls within Spring-managed beans. This means that **AOP cannot be applied to private, protected, or package-private methods**, potentially leaving significant portions of the codebase unaffected by aspects. Moreover, AOP in Spring **struggles with internal method calls within the same bean**, a limitation exemplified in scenarios like the _OrderService_ case. Such internal calls do not trigger aspects, leading to unexpected behavior and necessitating complex workarounds.

Beyond Spring, the cons of AOP include the potential for scattered code. The logic for a single functionality might be distributed across various aspects and the main code, making the codebase more challenging to understand and maintain. Additionally, t**he dynamic nature of aspect weaving complicates the debugging process, making it hard to trace the program flow**. Overuse or incorrect application of AOP can also **introduce performance overheads and unforeseen side effects**. Careful design and implementation of AOP are essential to avoid negatively impacting the application's performance and maintainability.

### Evaluating the Usefulness of Spring AOP

Spring AOP offers a balance of benefits and drawbacks. Its usefulness lies in its **ability to cleanly separate concerns like logging, security, and transactions from the business logic**. This separation enhances modularity and code readability, **making the application easier to maintain and extend**. However, its limitations, such as the inability to intercept internal method calls and the complexity it introduces in the application's execution flow, can be deterrents in certain scenarios. Therefore, while Spring AOP is undoubtedly useful for specific use cases, its applicability should be evaluated in the context of each project's requirements and complexity.

### In Conclusion

In conclusion, Aspect-Oriented Programming (AOP) in Spring offers a robust framework for managing cross-cutting concerns in a modular and efficient way. While it presents certain challenges, such as complexity in code understanding and limitations with internal method calls, the benefits of AOP in terms of code modularity and separation of concerns often outweigh these drawbacks. However, it is crucial for developers to understand both the strengths and limitations of Spring AOP to make informed decisions about its use in their projects. As with any technology, the key lies in using Spring AOP judiciously, where it adds value without introducing unnecessary complexity. Through careful application and understanding of its nuances, Spring AOP can be an invaluable tool in the arsenal of a Spring developer, enhancing the maintainability, scalability, and functionality of enterprise applications.
