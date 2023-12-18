---
title: "Java • Multiple Inheritance Using Interface"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/11/22/java-multiple-inheritance-using-interface.html
category: java
related: java
description: "Explore how to implement multiple inheritance in Java using interfaces, with practical examples like Vehicle and FlyingVehicle."
---


## Overview

Amongst the many facets of object-oriented programming, the concept of inheritance is fundamental. Multiple inheritance, a feature where a class can inherit from more than one superclass, can be particularly powerful but also complex. Java, however, does not support multiple inheritance directly in the way languages like C++ do. Instead, it offers a robust alternative through interfaces.<!--excerpt--> This article will delve into the concept of multiple inheritance in Java using interfaces, providing practical examples and best practices.

## Multiple Inheritance Through Class Inheritance

The history behind the absence of multiple inheritance in Java through traditional means, like class inheritance, is rooted in the language's design philosophy and the complexities associated with multiple inheritance in other programming languages.

1. **Simplification of Language Design:** Java was designed with the goal of being simple and secure. The creators of Java, led by James Gosling at Sun Microsystems, wanted to build a language that was easier to understand and more robust than its predecessors like C++. One of the complexities in C++ that they aimed to avoid was the ambiguity and complication arising from multiple inheritance.

2. **The Diamond Problem:** A significant issue with multiple inheritance is the "diamond problem," a scenario where a class inherits from two classes that have a common base class. This creates ambiguity in the path through which the base class is accessed. For instance, if class D inherits from both class B and class C, and these two classes inherit from a common class A, it becomes unclear which path to class A should be taken. This can lead to issues with data duplication and ambiguity in method calls.

3. **Increased Complexity and Ambiguity:** Multiple inheritance can make the code more complex and difficult to understand. It increases the risk of naming collisions and ambiguities in the hierarchy, making the programming model less clear and more prone to errors.

4. **Design Alternative - Interfaces:** To address these challenges, Java designers opted for a single inheritance model supplemented by interfaces. Interfaces in Java allow a class to inherit multiple sets of behavior without the pitfalls of multiple inheritance. This design promotes code reusability and polymorphism while keeping the language simpler and more maintainable.

5. **Focus on Composition over Inheritance:** Java's design encourages composition over inheritance. Composition involves creating objects that contain instances of other classes that implement the desired functionality. This approach is more flexible and leads to less tightly coupled code compared to classical inheritance, especially multiple inheritance.

6. **Evolution of Interface Concept:** Over time, Java has evolved the concept of interfaces. With the introduction of default methods in Java 8, interfaces in Java can now contain method implementations. This development has further reduced the need for multiple inheritance by allowing interfaces to provide "mixin-like" functionality, which was one of the use cases for multiple inheritance.

In summary, the decision to exclude traditional multiple inheritance from Java was a deliberate design choice aimed at simplifying the language, avoiding the complexities and ambiguities associated with multiple inheritance seen in languages like C++, and promoting clearer and more maintainable code structures. Instead, Java uses interfaces to enable a form of multiple inheritance that aligns with its design principles.

## Understanding Basic Interfaces

An interface in Java is an abstract type that is used to specify a behavior that classes must implement. Interfaces are about capabilities - what an object can do - rather than about what it is. For instance, any object that can fly might implement a _FlyingVehicle_ interface, which could declare methods like _fly()_ and _land()_. This does not describe what the object is (like a plane or a bird), but rather what it can do.

To implement an interface in Java, a class must provide concrete implementations of all the methods declared in the interface. For example, a class _Airplane_ might implement the _FlyingVehicle_ interface by providing specific code for how an _Airplane_ flies and lands.

Here's an example that illustrates the concept of implementing an interface in Java using a _FlyingVehicle_ interface and an _Airplane_ class:

**Figure 1.** FlyingVehicle Interface and an Airplane Class Diagram

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/java-multiple-inheritance-interf-1-287bb70.png">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuUBAp2j9BKfBJ4vLSCkfpCnB3qlDo4pEILMmiO7BsDafL7CfA6YNvMUcAAJbL6femdavYNafG6uj5rToJc9niO9ZPb41K0oiFRSW9pKtDQ-a6AWVmK6pXh313gbvAI2N0W00" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=SoWkIImgAStDuUBAp2j9BKfBJ4vLSCkfpCnB3qlDo4pEILMmiO7BsDafL7CfA6YNvMUcAAJbL6femdavYNafG6uj5rToJc9niO9ZPb41K0oiFRSW9pKtDQ-a6AWVmK6pXh313gbvAI2N0W00" target="_blank">PlantText</a>
   </small>
</div>

```java
// Define a FlyingVehicle interface
interface FlyingVehicle {
    void fly();  // Declare a method for flying
    void land(); // Declare a method for landing
}

// Implement the FlyingVehicle interface with the Airplane class
class Airplane implements FlyingVehicle {
    @Override
    public void fly() {
        System.out.println("The airplane is taking off and flying.");
        // Implement the specific flying behavior for an airplane
    }

    @Override
    public void land() {
        System.out.println("The airplane is landing.");
        // Implement the specific landing behavior for an airplane
    }
}

public class Main {
    public static void main(String[] args) {
        // Create an instance of the Airplane class
        Airplane myAirplane = new Airplane();

        // Call the fly() and land() methods on the airplane
        myAirplane.fly();
        myAirplane.land();
    }
}
```

In this example:

1. We define a _FlyingVehicle_ interface with two abstract methods: _fly()_ and _land()_. These methods declare the behavior that any flying vehicle should implement.

2. The _Airplane_ class implements the _FlyingVehicle_ interface. To do so, it provides concrete implementations of the _fly()_ and _land()_ methods. These implementations specify how an airplane should fly and land.

3. In the _main_ method, we create an instance of the _Airplane_ class (_myAirplane_) and then call the _fly()_ and _land()_ methods on it. This demonstrates that the _Airplane_ class implements the _FlyingVehicle_ interface and provides the expected behavior for flying and landing.

This example illustrates how interfaces in Java define a contract of behavior that implementing classes must adhere to. The _Airplane_ class, in this case, implements the _FlyingVehicle_ interface by providing specific implementations for the required methods.

## Interface with Default or Static Methods

Java 8 introduced default and static methods in interfaces, adding more flexibility. A default method is a non-abstract method, which provides a default implementation. This means that classes implementing the interface can either use this default implementation or provide their own version.

Static methods in interfaces help in providing utility methods relevant to the interface. They are not inherited by the implementing classes, thus maintaining the interface's purity while offering practical functionality.

### Static vs Default Methods in Java Interfaces

Static vs default methods in Java Interfaces serve different purposes.

#### Static Methods

- Static methods in interfaces are defined using the _static_ keyword.
- They belong to the interface itself and are not inherited by classes that implement the interface.
- You can call static methods using the interface name, like _InterfaceName.staticMethod()_.
- They are typically used for utility methods or methods that do not depend on the instance state of implementing classes.
- Static methods cannot be overridden in implementing classes, but they can be hidden if a class defines a static method with the same signature.

Example:

**Figure 2.**  Static Methods in Java Interfaces

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/java-multiple-inheritance-interf-2-02e7fb9.png">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuUBAp2j9BKfBJ4vLyAtqXBEhkHGKjAk1gaeoasiLol8pKnGW7D_Kaepy50rDhbekhkISnE9Ye3PdC4sK5cGxR6hqz62wkRWSKlDIG0u20000" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=SoWkIImgAStDuUBAp2j9BKfBJ4vLyAtqXBEhkHGKjAk1gaeoasiLol8pKnGW7D_Kaepy50rDhbekhkISnE9Ye3PdC4sK5cGxR6hqz62wkRWSKlDIG0u20000" target="_blank">PlantText</a>
   </small>
</div>

```java
interface MyInterface {
    static void staticMethod() {
        System.out.println("This is a static method in the interface.");
    }
}

class MyClass implements MyInterface {
    // You can't override a static method; you can only hide it
    static void staticMethod() {
        System.out.println("This is a static method in the class.");
    }
}
```

#### Default Methods

- Default methods in interfaces are defined using the _default_ keyword.
- They provide a default implementation for a method within an interface.
- Implementing classes can inherit the default implementation or choose to override it.
- Default methods allow you to add new methods to existing interfaces without breaking the classes that already implement those interfaces.
- They are used for backward compatibility when you need to add new methods to an interface without forcing all implementing classes to provide an implementation.
- For duplicate methods inherited from multiple interfaces, the inheriting class needs to explicitly resolve the ambiguity.

Basic Example:

**Figure 3.** Default Methods in Interface

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/java-multiple-inheritance-interf-3-15511c0.png">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuUBAp2j9BKfBJ4vLyAtqXBDjRE3YTdOArLmA2jhLAQbfYQKv9RKAPVcPAGfGdczgIKP-YeOcLoqNLt9EOd4nq1XdC0qq8hSW9pKtDQ-a66W6WeDY4P56EwJcfO2S2m00" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=SoWkIImgAStDuUBAp2j9BKfBJ4vLyAtqXBDjRE3YTdOArLmA2jhLAQbfYQKv9RKAPVcPAGfGdczgIKP-YeOcLoqNLt9EOd4nq1XdC0qq8hSW9pKtDQ-a66W6WeDY4P56EwJcfO2S2m00" target="_blank">PlantText</a>
   </small>
</div>

```java
interface MyInterface {
    default void defaultMethod() {
        System.out.println("This is a default method in the interface.");
    }
}

class MyClass implements MyInterface {
    // You can choose to override the default method
    @Override
    public void defaultMethod() {
        System.out.println("This is an overridden default method in the class.");
    }
}
```

Ambiguity Example:

When a class inherits multiple interfaces that have methods with the same name, the inheriting class needs to explicitly resolve the ambiguity by providing its own implementation of the conflicting method. Here's an example to illustrate this:

**Figure 4.** Interface Implementations With Ambiguity

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/java-multiple-inheritance-interf-4-b6d4f03.png">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuUBAp2j9BKfBJ4vLSCiiAYxnX7DjRE1ITdOArLmA2jhLAQbfYQKv9RKAPVcPAGef-S7vkQab6PbvwHgQNBN8PWMd9kVdfL1aM79EOd6nWc-bCvW66f1Ra9EQcvfNKWmq0S51SxOEXjKGo_BBKekACbDISTdca9gN0WeF0000" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=SoWkIImgAStDuUBAp2j9BKfBJ4vLSCiiAYxnX7DjRE1ITdOArLmA2jhLAQbfYQKv9RKAPVcPAGef-S7vkQab6PbvwHgQNBN8PWMd9kVdfL1aM79EOd6nWc-bCvW66f1Ra9EQcvfNKWmq0S51SxOEXjKGo_BBKekACbDISTdca9gN0WeF0000" target="_blank">PlantText</a>
   </small>
</div>

```java
// First interface with a default method named 'doSomething'
interface FirstInterface {
    default void doSomething() {
        System.out.println("Default implementation from FirstInterface");
    }
}

// Second interface with a default method named 'doSomething'
interface SecondInterface {
    default void doSomething() {
        System.out.println("Default implementation from SecondInterface");
    }
}

// A class that implements both interfaces and must resolve the ambiguity
class MyClass implements FirstInterface, SecondInterface {
    @Override
    public void doSomething() {
        // Explicitly choosing to override the method
        System.out.println("Custom implementation in MyClass");

        // Optionally calling default implementation from one of the interfaces
        FirstInterface.super.doSomething();
        // SecondInterface.super.doSomething(); // Uncomment to use SecondInterface's implementation
    }
}

public class Main {
    public static void main(String[] args) {
        MyClass myClass = new MyClass();
        myClass.doSomething(); // First calls MyClass's implementation, then FirstInterface's
    }
}
```

In this example, we have two interfaces, _FirstInterface_ and _SecondInterface_, both of which declare a method named _doSomething_. The _MyClass_ class implements both interfaces, so it must provide its own implementation of the _doSomething_ method to resolve the ambiguity.

In the _MyClass_ implementation, we have overridden the _doSomething_ method, and it will use this implementation when we call _myClass.doSomething()_. This allows the class to provide a specific behavior for the _doSomething_ method, resolving the ambiguity caused by the method with the same name in both interfaces.

In summary, static methods in interfaces are associated with the interface itself, while default methods provide a default implementation that can be inherited by implementing classes. Static methods are not inherited, while default methods can be inherited and optionally overridden by implementing classes.

## Multiple Inheritance-like Structure Through Interfaces

Is multiple inheritance possible in Java using interfaces? Absolutely. Interfaces allow Java to support multiple inheritance-like behavior. This is because a class in Java can implement multiple interfaces, thereby inheriting the abstract methods of multiple interfaces.

Take, for instance, a class _FlyingCar_ that needs to function both as a _Vehicle_ and as a _FlyingVehicle_. In Java, _FlyingCar_ can implement both these interfaces, thereby inheriting their capabilities. It's a way to have the best of both worlds, the functionalities of a regular vehicle and a flying vehicle, without the complexities and ambiguities often associated with multiple inheritance.

## Practical Example: Vehicle and FlyingVehicle

How to use an interface for multiple classes in Java? Let's illustrate this with our _Vehicle_ and _FlyingVehicle_ example. A basic _Vehicle_ interface might declare methods like _drive()_ and _stop()_. The _FlyingVehicle_ interface, as already mentioned, would have methods like _fly()_ and _land()_. A class like _FlyingCar_ implementing both these interfaces would provide its own definitions for all these methods, thus exhibiting behaviors of both a regular vehicle and a flying vehicle.

Here's an example to illustrate how a class in Java can implement multiple interfaces with default methods, specifically focusing on a FlyingCar class that implements both Vehicle and FlyingVehicle interfaces, each having a default method named stop(). 

In this scenario, the _FlyingCar_ class's _stop()_ method will decide which interface's _stop()_ method to call based on whether the car is flying. This requires an additional method, _isFlying()_, to determine the car's current state. Here's how the implementation would look:

### Example:

**Figure 5.** Multiple Inheritance with Ambiguity

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/java-multiple-inheritance-interf-5-72bdf0d.png">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/XP112i8m44NtFSKi5VK6fHG4Z-1-JAOwC4rACYsKqhlRj8e5You_dxp_CcLK3DhMacNib4A5Xk1A3pP2C6G0Xywp1Hkuezq-vS5IXQte27CJrJTJCQxVNwHdT_-cLD8lZ3a9Eli7QGHZVE7E623FkMw4Qd8QYm8-uQrytDW-tRmNGfVcfshhJp_jrauh6iTbQZ4joTbqnIS0" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=XP112i8m44NtFSKi5VK6fHG4Z-1-JAOwC4rACYsKqhlRj8e5You_dxp_CcLK3DhMacNib4A5Xk1A3pP2C6G0Xywp1Hkuezq-vS5IXQte27CJrJTJCQxVNwHdT_-cLD8lZ3a9Eli7QGHZVE7E623FkMw4Qd8QYm8-uQrytDW-tRmNGfVcfshhJp_jrauh6iTbQZ4joTbqnIS0" target="_blank">PlantText</a>
   </small>
</div>

```java
// Interface for regular vehicles
interface Vehicle {
    void drive();

    // Default method 'stop'
    default void stop() {
        System.out.println("Vehicle stopped.");
    }
}

// Interface for flying vehicles
interface FlyingVehicle {
    void fly();
    void land();

    // Default method 'stop'
    default void stop() {
        System.out.println("FlyingVehicle stopped.");
    }
}

// Class that implements both interfaces
class FlyingCar implements Vehicle, FlyingVehicle {
    private boolean flying;

    @Override
    public void drive() {
        System.out.println("FlyingCar is driving.");
        flying = false;
    }

    @Override
    public void fly() {
        System.out.println("FlyingCar is flying.");
        flying = true;
    }

    @Override
    public void land() {
        System.out.println("FlyingCar is landing.");
        flying = false;
    }

    // Method to check if the car is currently flying
    private boolean isFlying() {
        return flying;
    }

    @Override
    public void stop() {
        // Decide which stop method to call based on flying state
        if (isFlying()) {
            FlyingVehicle.super.stop(); // Calls the stop method of FlyingVehicle interface
        } else {
            Vehicle.super.stop(); // Calls the stop method of Vehicle interface
        }
    }
}

public class Main {
    public static void main(String[] args) {
        FlyingCar myFlyingCar = new FlyingCar();
        myFlyingCar.drive();
        myFlyingCar.fly();
        myFlyingCar.stop(); // Output will depend on whether the car is flying or driving
        myFlyingCar.land();
        myFlyingCar.stop(); // Output will depend on the car's state
    }
}
```

In this implementation, the _FlyingCar_ class has a private field _flying_ to keep track of whether it is flying. The _isFlying()_ method checks this state. When _stop()_ is called, it determines the appropriate action based on whether the _FlyingCar_ is in flight. If it is flying, it calls the _stop_ method from the _FlyingVehicle_ interface; otherwise, it calls the _stop_ method from the _Vehicle_ interface. This approach elegantly handles the dynamic nature of a _FlyingCar_, providing context-specific behavior.

## Proper Use of Multiple Inheritance Using Interface

What is the proper use of multiple inheritance using interface in Java? The key is to use interfaces for defining capabilities or behaviors and then implement those interfaces in classes that require those behaviors. 

It's crucial to design your interfaces thoughtfully, keeping them focused and not too broad. Overusing interfaces or making them too granular can lead to a confusing and hard-to-maintain codebase.

### Example Usage of Interface Default Methods in Tests

Here's an example of implementing two interfaces, _JsonAssertions_ and _RestAssertions_, which have default methods, and a unit test that uses these interfaces to assert JSON content and RESTful responses:

First, let's define the interfaces _JsonAssertions_ and _RestAssertions_:

```java
import org.junit.jupiter.api.Assertions;

// Interface for JSON assertions
interface JsonAssertions {
    default void assertJsonEquals(String expectedJson, String actualJson) {
        Assertions.assertEquals(expectedJson, actualJson, "JSON content does not match");
    }
}

// Interface for REST assertions
interface RestAssertions {
    default void assertStatusCode(int expectedStatusCode, int actualStatusCode) {
        Assertions.assertEquals(expectedStatusCode, actualStatusCode, "HTTP Status code does not match");
    }
}
```

Now, let's create a test class that implements these interfaces and uses their default methods to perform assertions:

```java
import org.junit.jupiter.api.Test;

class MyRestTest implements JsonAssertions, RestAssertions {
    
    // Simulated REST API response
    String jsonResponse = "{\"name\":\"John\",\"age\":30}";

    @Test
    void testJsonAssertion() {
        String expectedJson = "{\"name\":\"John\",\"age\":30}";

        // Use the assertJsonEquals method from JsonAssertions
        assertJsonEquals(expectedJson, jsonResponse);
    }

    @Test
    void testRestAssertion() {
        int expectedStatusCode = 200;
        int actualStatusCode = 200; // Simulated response status code

        // Use the assertStatusCode method from RestAssertions
        assertStatusCode(expectedStatusCode, actualStatusCode);
    }
}
```

In this example, the use of default methods in Java interfaces is appropriate and serves a specific purpose. Let's discuss the appropriateness of this use case in more detail:

The example demonstrated two interfaces, _JsonAssertions_ and _RestAssertions_, each defining a default method for performing specific types of assertions:

1. _JsonAssertions_ interface includes the _assertJsonEquals_ default method for comparing JSON content.
2. _RestAssertions_ interface includes the _assertStatusCode_ default method for asserting HTTP status codes.

In this example, the Test class is no longer implementing an interface but inheriting the operations of an interface through the use of default methods. Here's why this use of default methods is proper:

1. **Interface Evolution and Backward Compatibility:** Default methods in interfaces are designed for evolving interfaces without breaking existing implementations. In this case, if new assertion methods need to be added to these interfaces in the future, existing test classes that implement these interfaces won't be forced to implement the new methods immediately. This is beneficial for maintaining backward compatibility and allowing for easy extension of the assertion capabilities.

2. **Code Organization and Reusability:** Using default methods to encapsulate common assertion logic (such as comparing JSON content or HTTP status codes) promotes code organization and reusability. Test classes that implement these interfaces can leverage the default implementations, reducing code duplication and ensuring consistent assertion behavior across multiple test classes.

3. **Clarity and Readability:** The use of interfaces with default methods can enhance the clarity and readability of unit tests. By providing well-named default methods in the interfaces, the intent and purpose of the assertions become more self-documenting, making the tests easier to understand and maintain.

The use of default methods in Java interfaces, as demonstrated in the unit test example, is a valid and practical approach when it comes to organizing and maintaining test code. It supports interface evolution, code organization, and code reusability. However, as with any programming feature, it should be used judiciously, and potential conflicts and interface design considerations should be carefully managed.

## Impact of Default Methods on the Use of Abstract Classes

The introduction of default methods in Java interfaces has indeed influenced the role and necessity of abstract classes in Java programming. Abstract classes and interfaces in Java serve similar but distinct purposes: while abstract classes are used to provide a common base with some shared implementation, interfaces define a contract or capability without implementation details. Before Java 8, abstract classes were often used as a workaround to achieve some level of method implementation inheritance which was not possible with interfaces at the time.

However, with the introduction of default methods in interfaces in Java 8, the line between interfaces and abstract classes has somewhat blurred:

1. **Shared Implementations:** Prior to Java 8, if you wanted to provide a shared implementation for certain methods, you would typically use an abstract class. Now, default methods in interfaces allow for shared implementations, reducing the need for abstract classes in many scenarios.

2. **Reduced Boilerplate Code:** Default methods reduce the need for boilerplate code in implementing classes. In the past, similar functionalities had to be repeated in each subclass of an abstract class or were achieved through complex class hierarchies. Now, interfaces with default methods can provide a single, central place for such implementations.

3. **Enhanced Flexibility:** Interfaces with default methods offer greater flexibility. A class can implement multiple interfaces but can only extend one abstract class. With default methods, a class can inherit behavior from multiple sources without the constraints of the single inheritance model.

4. **Design Philosophy:** The design philosophy shifts from "is-a" (inheritance) to "has-a" (capability). This aligns with modern best practices in object-oriented design, where composition is favored over inheritance. Interfaces with default methods facilitate this approach by focusing on what an object can do rather than what it is.

5. **Abstract Classes Still Relevant:** Despite these advantages, abstract classes remain relevant for certain use cases. They are still useful when you need to share state (fields) among various subclasses. Interfaces do not hold state and can only declare constants. Additionally, abstract classes are beneficial when the shared implementation should not be optional or needs to be protected from modification by the inheriting classes.

In conclusion, while default methods in interfaces have reduced some of the reliance on abstract classes by providing a means to share implementation code, they haven't rendered abstract classes obsolete. The choice between using an interface with default methods and an abstract class depends on the specific requirements of the application and the design philosophy being followed.

### Example of Interface Default Methods vs Interface-Abstract Implementations

Sure, let's look at two examples to illustrate the usage of interfaces with and without default methods, and their implementation in an abstract class.

### FlyingVehicle Interface without Default Methods

In this example, the _FlyingVehicle_ interface will declare methods without providing default implementations. An abstract class _AbstractFlyingVehicle_ will then implement this interface and provide the base implementation.

**Interface:**

```java
interface FlyingVehicle {
    void fly();
    void land();
}
```

**Abstract Class Implementation:**

```java
abstract class AbstractFlyingVehicle implements FlyingVehicle {
    @Override
    public void fly() {
        System.out.println("Basic flying mechanism");
    }

    @Override
    public void land() {
        System.out.println("Basic landing mechanism");
    }

    // Additional functionalities common to all flying vehicles
    public void performPreFlightCheck() {
        System.out.println("Performing pre-flight check");
    }
}
```

In this setup, any class extending _AbstractFlyingVehicle_ will inherit the basic implementations of _fly()_ and _land()_, and also has the additional method _performPreFlightCheck()_.

```java
abstract class AbstractFlyingVehicle implements FlyingVehicle {
    @Override
    public void fly() {
        System.out.println("Basic flying mechanism");
    }

    @Override
    public void land() {
        System.out.println("Basic landing mechanism");
    }
}
```

Now, let's create a concrete class _Helicopter_ that extends _AbstractFlyingVehicle_. The _Helicopter_ class can use the provided implementations or override them with more specific behavior:

```java
class Helicopter extends AbstractFlyingVehicle {
    @Override
    public void fly() {
        System.out.println("Helicopter taking off");
    }

    @Override
    public void land() {
        System.out.println("Helicopter landing");
    }

    public void hover() {
        System.out.println("Helicopter hovering");
    }
}
```

In this example:

- The _Helicopter_ class inherits the _performPreFlightCheck()_ method from _AbstractFlyingVehicle_, demonstrating how shared behavior can be encapsulated in an abstract class.
- The _fly()_ and _land()_ methods are overridden to provide specific functionality for helicopters, showing how concrete classes can customize inherited behavior.
- An additional method _hover()_ is defined in _Helicopter_, illustrating how concrete classes can extend the capabilities of the abstract class.

By using _AbstractFlyingVehicle_, we create a foundation for flying vehicles that can be extended and specialized by concrete subclasses. This approach is particularly useful when there are common functionalities or states that need to be shared among various subclasses, which is a typical use case for abstract classes.

### FlyingVehicle Interface with Default Methods

Here, the _FlyingVehicle_ interface will include default method implementations. This approach eliminates the need for an abstract class to provide base implementations.

**Interface with Default Methods:**

```java
interface FlyingVehicle {
    default void fly() {
        System.out.println("Default flying mechanism");
    }

    default void land() {
        System.out.println("Default landing mechanism");
    }

    // Other flying-related methods can be added here
}
```

**Concrete Class Implementation:**

```java
class BasicFlyingCar implements FlyingVehicle {
    // This class automatically inherits default implementations of fly() and land()
    // Additional specific methods for BasicFlyingCar can be added here
}
```

In this example, any class implementing _FlyingVehicle_ will have the default implementations of _fly()_ and _land()_ unless it provides its own overrides. This approach provides greater flexibility and reduces the need for a hierarchy of abstract classes, simplifying the class design and structure.

Both examples illustrate the flexibility and choices Java offers in designing class hierarchies and interfaces, allowing developers to choose the approach that best fits their application's architecture and requirements.

## Conclusion

In conclusion, while Java does not support traditional multiple inheritance, it provides a powerful and flexible alternative through interfaces. This approach allows classes to inherit multiple sets of behaviors, encouraging code reusability and maintaining a clean, manageable code structure. Understanding and effectively utilizing interfaces, especially with the advent of default and static methods, can significantly enhance your Java programming capabilities.
