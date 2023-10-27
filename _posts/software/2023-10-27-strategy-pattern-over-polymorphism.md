---
title: "When to Choose Strategy Pattern Over Polymorphism"
title_style: title2
canonical_url: https://www.kapresoft.com/software/2023/10/27/strategy-pattern-over-polymorphism.html
category: software
related: software
description: "Delve into the depths of choosing strategy pattern over polymorphism in software design, featuring detailed Java examples."
---

## Overview

Navigating through the intricate landscape of software design, one often encounters the pivotal decision of whether to employ the _strategy pattern_ or leverage _polymorphism_. As cornerstone concepts of object-oriented programming (OOP), each brings its unique advantages and potential pitfalls.<!--excerpt--> This comprehensive guide is thoughtfully curated to elucidate the situations where the _strategy pattern_ holds the upper hand over polymorphism, all the while maintaining a steadfast adherence to esteemed design principles.

<a id='-9RsrP6pQfRGMSqj6lpwLA' class='gie-single' href='http://www.gettyimages.com/detail/172157592' target='_blank' style='color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;'>Embed from Getty Images</a><script>window.gie=window.gie||function(c){(gie.q=gie.q||[]).push(c)};gie(function(){gie.widgets.load({id:'-9RsrP6pQfRGMSqj6lpwLA',sig:'maAW_tEZQYUxwyQsoiyXP9-oCUb3AQM5TJVKSux3BEg=',w:'550px',h:'200px',items:'172157592',caption: false ,tld:'com',is360: false })});</script><script src='//embed-cdn.gettyimages.com/widgets.js' charset='utf-8' async></script>

## Strategy Pattern in a Nutshell

The _strategy pattern_, a prestigious _design pattern_ within the OOP domain, empowers the selection of an algorithm's behavior dynamically at runtime. Rather than cementing commitment to a single algorithm, a diverse array of algorithms is meticulously carved out, with each residing in its distinct class. These classes are designed to be interchangeable, thereby bestowing upon the context the liberty to oscillate between them as necessitated by the situation at hand. This judicious encapsulation of behavior not only amplifies _code re-usability_ but also _ flexibility and testability.

```java
public interface PaymentStrategy {
    void pay(int amount);
}

public class CreditCardPayment implements PaymentStrategy {
    private String name;
    private String cardNumber;

    public CreditCardPayment(String name, String cardNumber) {
        this.name = name;
        this.cardNumber = cardNumber;
    }

    @Override
    public void pay(int amount) {
        // Implementation for credit card payment
    }
}

public class PaypalPayment implements PaymentStrategy {
    private String emailId;

    public PaypalPayment(String emailId) {
        this.emailId = emailId;
    }

    @Override
    public void pay(int amount) {
        // Implementation for PayPal payment
    }
}
```

## Polymorphism at a Glance

At the other end of the spectrum, _polymorphism_ stands tall as another crucial concept in _OOP_. It extends the privilege to distinct classes to interpret a common method in their unique, bespoke manner. This is seamlessly actualized through _inheritance_, wherein a _superclass_ lays down a method, subsequently allowing its progeny, the subclasses, to furnish specific implementations as they see fit.

**Figure 1. Design Diagram of an Animal Polymorphism**
<div style="text-align: center; margin: 10px 0;">
<img src="https://cdngh.kapresoft.com/img/software-strategy-over-poly-e688626.png" alt="Design Diagram of an Animal Polymorphism"/>
</div>

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuKhEIImkLd3CoynDp56evb9Gq2xEByrBqT2qKYZBpqpXgkM2Ad79JyShxvnOWaCUQhXDZQuko1GKFb0NbqDgNWh8AG00" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=SoWkIImgAStDuKhEIImkLd3CoynDp56evb9Gq2xEByrBqT2qKYZBpqpXgkM2Ad79JyShxvnOWaCUQhXDZQuko1GKFb0NbqDgNWh8AG00" target="_blank">PlantText</a></small>

This diagram visually represents the inheritance relationship where _Dog_ and _Cat_ classes extend the _Animal_ class, with each of the three classes containing a _sound_ method.

Here is a java code that represents this design:

```java
public class Animal {
    public void sound() {
        System.out.println("Animal makes a sound");
    }
}

public class Dog extends Animal {
    public void sound() {
        System.out.println("Dog barks");
    }
}

public class Cat extends Animal {
    public void sound() {
        System.out.println("Cat meows");
    }
}
```

## When to Choose Strategy Pattern

Opting for the strategy pattern proves itself invaluable when confronted with a myriad of algorithms or behaviors pertaining to a particular task, each demanding the elasticity to be supplanted interchangeably at runtime. This methodology aligns seamlessly with the _design principles_ advocating for _program to interface, not implementation_, while also championing the cause of _composition over inheritance_. The thoughtful encapsulation of behavior not only propels _code re-usability_ but also ensures the maintenance of pristine, unblemished code.

### Redesigning the Animal Hierarchy using the Strategy Pattern

Here's a redesign of your classes using the strategy pattern:

**Figure 2. Design Diagram of an Animal Sound Strategy**

<div style="text-align: center; margin: 10px 0;">
<img src="https://cdngh.kapresoft.com/img/software-strategy-over-animal-sound-1759505.png" alt="Design Diagram of an Animal Sound Strategy"/>
</div>

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/ZP5D3e9038NtSuekCOOBi20OkG4dQA0GuloGQSV4g7SNq92CH67Rz_Mz_XGiw2KOhNehv5ki2IeNR5E9Hw7k1dS5S3HueRcS7223g-iRzLIgriWC9ziRr3ENSjIQnLQJqHjE_d9BnCWpIQJjxnp6RPmtlwOkNJTBs_kTKNQI9RKOz3QzPAUF_Ej4IzXQYjpNykSDQHXMsXWTc1XoLP1jfcU_0000" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=ZP5D3e9038NtSuekCOOBi20OkG4dQA0GuloGQSV4g7SNq92CH67Rz_Mz_XGiw2KOhNehv5ki2IeNR5E9Hw7k1dS5S3HueRcS7223g-iRzLIgriWC9ziRr3ENSjIQnLQJqHjE_d9BnCWpIQJjxnp6RPmtlwOkNJTBs_kTKNQI9RKOz3QzPAUF_Ej4IzXQYjpNykSDQHXMsXWTc1XoLP1jfcU_0000" target="_blank">PlantText</a></small>


The diagram shows that _DogSound_, _CatSound_, and _DefaultSound_ all implement the _SoundStrategy_ interface and that the _Animal_ class uses the _SoundStrategy_ interface.

- _SoundStrategy_ is an interface that declares a method _makeSound_ with a return type of _void_.
- _Animal_ is a class with a private field _soundStrategy_ of type _SoundStrategy_, a constructor that takes a _SoundStrategy_ object as a parameter, a _setSoundStrategy_ method that allows changing the _soundStrategy_ at runtime, and a _performSound_ method that delegates the responsibility of making a sound to the current _soundStrategy_ object.
- _DogSound_, _CatSound_, and _DefaultSound_ are classes that implement the _SoundStrategy_ interface, providing specific implementations for the _makeSound_ method.

In this refactored design, the separate _Dog_ and _Cat_ classes are no longer necessary. Their distinct behaviors are encapsulated within their respective strategy classes, _DogSound_ and _CatSound_, both of which implement the _SoundStrategy_ interface. This approach aligns with the strategy pattern, allowing for flexible and interchangeable behavior at runtime. By encapsulating the sound-making behavior within these strategy classes, the design adheres to the principle of composition over inheritance, reducing complexity and enhancing maintainability.

Here is a java code that represents this design:

```java
public interface SoundStrategy {
    void makeSound();
}

public class Animal {
    private SoundStrategy soundStrategy;

    public Animal(SoundStrategy soundStrategy) {
        this.soundStrategy = soundStrategy;
    }

    public void setSoundStrategy(SoundStrategy soundStrategy) {
        this.soundStrategy = soundStrategy;
    }

    public void performSound() {
        soundStrategy.makeSound();
    }
}

public class DogSound implements SoundStrategy {
    @Override
    public void makeSound() {
        System.out.println("Dog barks");
    }
}

public class CatSound implements SoundStrategy {
    @Override
    public void makeSound() {
        System.out.println("Cat meows");
    }
}

public class DefaultSound implements SoundStrategy {
    @Override
    public void makeSound() {
        System.out.println("Animal makes a sound");
    }
}
```

In this example, we have an interface _SoundStrategy_ with a method _makeSound_. This method is implemented by _DogSound_, _CatSound_, and _DefaultSound_, each providing a specific implementation for the sound the animal makes. The _Animal_ class has a _SoundStrategy_ field, and its constructor accepts a _SoundStrategy_ object to initialize this field. The _setSoundStrategy_ method allows changing the sound strategy dynamically. The _performSound_ method in _Animal_ delegates the responsibility of making a sound to the current _soundStrategy_ object. This redesign aligns with the strategy pattern, encapsulating the sound-making behavior in separate classes and providing flexibility in changing the behavior at runtime.


### Shipping Strategy

Another example for instance, is a logistics operation in the throes of grappling with varying shipping strategies. Instead of entrenching each method within the codebase, it is astutely encapsulated within its dedicated class, thereby rendering them interchangeable based on the shifting sands of requirements.


**Figure 2. Design Diagram of a Shipping Strategy**
<div style="text-align: center; margin: 10px 0;">
<img src="https://cdngh.kapresoft.com/img/software-strategy-over-poly-shipping-88eaede.png" alt="Design Diagram of a Shipping Strategy"/>
</div>

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/jP9D2i8m48NtSufPLgGU88WKHBSAnGF4PAo1z8TC8efwTzjAmROKDxeAlCoRR-On2NlfVCWjW2aykPDKXEdPL9KfijGxwIcxuHqGvqfQ5MmjTD_hadrKEarEuAvvPW9r6OwMu0cWh6J6BUdDjJEWoIjBEHMUVyauxDC_4rgzzSSyw2f6d8R2v8TozDrPao-bqTDZzaORxRTyB1Rzm2TgFWA3zsfnl1hd9J0mCK12XMukv0K0" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=jP9D2i8m48NtSufPLgGU88WKHBSAnGF4PAo1z8TC8efwTzjAmROKDxeAlCoRR-On2NlfVCWjW2aykPDKXEdPL9KfijGxwIcxuHqGvqfQ5MmjTD_hadrKEarEuAvvPW9r6OwMu0cWh6J6BUdDjJEWoIjBEHMUVyauxDC_4rgzzSSyw2f6d8R2v8TozDrPao-bqTDZzaORxRTyB1Rzm2TgFWA3zsfnl1hd9J0mCK12XMukv0K0" target="_blank">PlantText</a></small>


In this diagram, the _Order_ class has an association with the _ShippingStrategy_ interface, indicating that it uses the interface. The _FedExShipping_ and _UPSShipping_ classes implement the _ShippingStrategy_ interface.

Here is a java code that represents this design:

```java
public interface ShippingStrategy {
    double calculateShippingCost(Order order);
}

public class FedExShipping implements ShippingStrategy {
    @Override
    public double calculateShippingCost(Order order) {
        // Implementation for FedEx shipping cost calculation
        return // FedEx specific calculation;
    }
}

public class UPSShipping implements ShippingStrategy {
    @Override
    public double calculateShippingCost(Order order) {
        // Implementation for UPS shipping cost calculation
        return // UPS specific calculation;
    }
}

public class Order {
    private ShippingStrategy shippingStrategy;

    public Order(ShippingStrategy shippingStrategy) {
        this.shippingStrategy = shippingStrategy;
    }

    public void setShippingStrategy(ShippingStrategy shippingStrategy) {
        this.shippingStrategy = shippingStrategy;
    }

    public double calculateShippingCost() {
        return shippingStrategy.calculateShippingCost(this);
    }
}
```

The given code snippet illustrates a _strategy pattern_ implementation for calculating shipping costs in a flexible and interchangeable manner. The _ShippingStrategy_ interface defines a single method, _calculateShippingCost_, which takes an _Order_ as a parameter and returns a _double_ representing the shipping cost. 

Two concrete classes, _FedExShipping_ and _UPSShipping_, implement this interface, each providing a specific method to calculate shipping costs according to FedEx and UPS respectively. The _Order_ class has a _ShippingStrategy_ field, and its constructor accepts a _ShippingStrategy_ object to initialize this field. The _setShippingStrategy_ method allows changing the shipping strategy dynamically. 

The _calculateShippingCost_ method in _Order_ delegates the responsibility of calculating the shipping cost to the current _shippingStrategy_ object, demonstrating the core principle of the strategy pattern where algorithms (shipping cost calculations in this case) are encapsulated in separate classes and can be easily switched at runtime.

## Differences in Growth: Polymorphism vs. Strategy Pattern

When we consider the evolution and expansion of software applications, the difference in growth between _polymorphism_ and the _strategy pattern_ is quite distinct.

### Polymorphism: Growth Through Inheritance
In the case of polymorphism, growth predominantly occurs through the mechanism of _inheritance_. As new functionalities or variants of existing functionalities are introduced, they are typically incorporated into the system by creating new subclasses that inherit from a common superclass. Each of these subclasses then provides its own specific implementation of the behavior dictated by the superclass. This approach tends to grow the class hierarchy vertically, adding more branches to the inheritance tree. However, this can sometimes result in a rigid structure that can be difficult to modify or extend as the system evolves.

**Design Advantages:**
- Clear and straightforward hierarchy: The hierarchical structure provided by inheritance can make the relationship between different classes clear and easy to understand.
- Code reuse: Polymorphism allows for the reuse of common code, thereby reducing redundancy.

**Testability Advantages:**
- Ease of testing individual behaviors: The specific behavior of each subclass can be tested in isolation, allowing for targeted testing.

```java
public class Animal {
    public void sound() {
        System.out.println("Animal makes a sound");
    }
}

public class Dog extends Animal {
    public void sound() {
        System.out.println("Dog barks");
    }
}

public class Cat extends Animal {
    public void sound() {
        System.out.println("Cat meows");
    }
}
```

### Strategy Pattern: Growth Through Behavioral Implementations
On the flip side, the _strategy pattern_ facilitates growth through the addition of new behavioral implementations. As the need for new behaviors arises, new classes encapsulating these behaviors are created and made interchangeable with existing behaviors. This approach grows the system horizontally, adding more options for behavior without modifying the existing class hierarchy. This results in a more flexible and maintainable structure that can easily adapt to changes over time.

**Design Advantages:**
- Flexibility: The strategy pattern provides the flexibility to switch between different behaviors at runtime.
- Maintainability: The decoupling of behavior from the class structure makes it easier to add or modify behaviors without affecting other parts of the system.

**Testability Advantages:**
- Ease of testing different behaviors: Each behavior encapsulated by a strategy can be tested in isolation, allowing for precise and targeted testing.
- Simplified testing: The separation of behavior makes it easier to mock or stub behaviors during testing, thereby simplifying the testing process.

```java
public interface ShippingStrategy {
    double calculateShippingCost(Order order);
}

public class FedExShipping implements ShippingStrategy {
    @Override
    public double calculateShippingCost(Order order) {
        // Implementation for FedEx shipping cost calculation
        return // FedEx specific calculation;
    }
}

public class UPSShipping implements ShippingStrategy {
    @Override
    public double calculateShippingCost(Order order) {
        // Implementation for UPS shipping cost calculation
        return // UPS specific calculation;
    }
}
```

In summary, while polymorphism tends to grow the system through inheritance, resulting in a potentially rigid vertical structure, the strategy pattern promotes horizontal growth by adding new behavioral implementations. This fundamental difference highlights the flexibility and maintainability advantages offered by the strategy pattern in adapting to the ever-evolving landscape of software applications. The strategy pattern also tends to be more test-friendly, offering ease of testing different behaviors in isolation.

## Testing Polymorphic vs Strategy Designs 

When testing polymorphic classes, you often find yourself writing separate tests for each subclass, which can lead to duplicate assertions. For example:

```java
@Test
public void testDogSound() {
    Animal dog = new Dog();
    assertEquals("Dog barks", dog.sound());
}

@Test
public void testCatSound() {
    Animal cat = new Cat();
    assertEquals("Cat meows", cat.sound());
}

@Test
public void testDefaultAnimalSound() {
    Animal animal = new Animal();
    assertEquals("Animal makes a sound", animal.sound());
}
```

In the above example, each subclass of _Animal_ requires a separate test, even though the assertion logic is quite similar. This can result in redundant code and increase the maintenance burden as the number of subclasses grows.

### Testing Behavioral Classes

Conversely, when using the strategy pattern, we can test the behaviors independently and then test their integration with the _Animal_ class separately:

```java
@Test
public void testAnimalWithDogSound() {
    SoundStrategy dogSound = new DogSound();
    Animal animal = new Animal(dogSound);
    assertEquals("Dog barks", animal.performSound());
}

@Test
public void testDogSound() {
    SoundStrategy dogSound = new DogSound();
    assertEquals("Dog barks", dogSound.makeSound());
}

@Test
public void testCatSound() {
    SoundStrategy catSound = new CatSound();
    assertEquals("Cat meows", catSound.makeSound());
}
```

In this example, the _DogSound_ and _CatSound_ behaviors are tested independently of the _Animal_ class. We then have a single test for the _Animal_ class with the _DogSound_ behavior, significantly reducing duplicate assertions. This approach simplifies the testing process and ensures scalability as new behaviors are introduced.

The ease of testing is a good indicator that the strategy pattern provides a clear advantage in scenarios where behavior needs to be changed dynamically. By isolating behaviors and making them interchangeable, the strategy pattern facilitates a more modular and maintainable design. This translates to simpler and more effective testing procedures, as each behavior can be tested in isolation, and their integration with the main class can be verified with minimal tests.

Compared to the redundancy in testing polymorphic classes, this serves as a strong testament that a strategy pattern is best for this case. The modular nature of the _strategy pattern_ allows for independent testing of behaviors and their integration, significantly reducing the complexity and duplication often found in testing polymorphic classes.

## In Conclusion

The intricate tapestry of software design is masterfully woven from myriad threads of strategic decisions, among which the pivotal choice between the _strategy pattern_ and _polymorphism_ prominently stands.

In cases where your design finds itself entangled in the complexities of polymorphism, it might be judicious to shift towards a more behavioral approach, as encapsulated by the _strategy pattern_. This method doesn’t just bring clarity and flexibility to your design process, effectively easing the traversal through multifaceted design challenges, but it also significantly bolsters the _testability_ of your system. Such an enhancement in testability proves invaluable, as it facilitates the independent validation of each behavior or strategy, thereby streamlining the testing process.

The _strategy pattern_ emerges as a paragon of flexibility, proffering a resilient framework that deftly accommodates the interchangeability of algorithms or behaviors in real-time. Deeply rooted in time-honored _design principles_, it stands as a monumental tribute to the indispensability of _code re-usability_ and the unwavering pursuit of impeccable, flawless code. The utility of the _strategy pattern_ is abundantly clear, particularly in scenarios that demand the meticulous encapsulation of behavior, as eloquently illustrated by the previously discussed example of shipping cost calculations. Ultimately, this approach doesn't merely solve problems; it resolves them with unparalleled elegance and efficiency, epitomizing the very essence of clean, maintainable code.

