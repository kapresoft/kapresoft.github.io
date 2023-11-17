---
title: "Design Patterns • Composition vs Aggregation"
title_style: title2
canonical_url: https://www.kapresoft.com/software/2023/11/17/design-patterns-composition-vs-aggregation.html
category: software
related: software
description: "Explore the intricacies of Composition vs Aggregation in design patterns, with real-life examples and domain model applications."
---

## Overview

When it comes to software engineering and design, understanding the concepts of composition and aggregation is crucial for creating robust and efficient domain models. These terms, often used in object-oriented programming, represent relationship patterns between objects that dictate how they interact and depend on each other.<!--excerpt--> By dissecting these concepts and illustrating them with real-life examples, we can gain a deeper comprehension of their applications and significance in domain modeling.

Composition and aggregation are both associative relationships but differ in terms of ownership and life cycle of the involved objects. While both play pivotal roles in domain modeling, understanding their distinct characteristics is essential for their appropriate application in various scenarios. This article aims to demystify these concepts, providing clarity with practical examples.

## Composition Domain Modeling

In domain modeling, composition and aggregation represent different types of relationships between objects. *Composition* implies a strong ownership, where the life cycle of the contained object is strictly bound to the container. When the container object is destroyed, so are its contents. This reflects a “part-of” relationship where the parts cannot exist independently of the whole.

### Composition of an Engine and Wheel

In the figure below is an example class diagram to illustrate the concept of Composition in a UML class diagram. In this example, we'll use a simple scenario of a _Car_ and its integral parts, like _Engine_ and _Wheel_. In Composition, these parts are entirely dependent on the _Car_ for their existence.

**Figure 1.** Composition Class Diagram of an Engine and Wheel Relationship

The UML class diagram showing the composition relationship between a _Car_ and its components, _Engine_ and _Wheels_, underlining the concept that the existence of the components is dependent on the existence of the car.

![Class Diagram: Composition of Engine and Wheel](https://cdngh.kapresoft.com/img/design-composition-vs-aggregation-engine-car-6d8120d.png)

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuU9ApaaiBbPmJYnIgEPI009TrxpqpBnKXLGm1H4ApqXDpOcELIW7qSLSjJ1TKANL216mIeW0o4WjNLsO8Yk5vFoyaiJCl6Au34GnaWINGsfU2j1L0000" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=SoWkIImgAStDuU9ApaaiBbPmJYnIgEPI009TrxpqpBnKXLGm1H4ApqXDpOcELIW7qSLSjJ1TKANL216mIeW0o4WjNLsO8Yk5vFoyaiJCl6Au34GnaWINGsfU2j1L0000" target="_blank">PlantText</a></small>

In this diagram:
- The _Car_ class contains an _Engine_ and an array of _Wheel_ objects.
- The asterisk (*) in the relation _Car *-- Engine_ and _Car *-- Wheel_ signifies a composition relationship. It means that _Engine_ and _Wheel_ are part of _Car_ and cannot exist independently without the _Car_.
- When a _Car_ object is destroyed, its _Engine_ and _Wheel_ objects are also destroyed.

### Composition of a Shopping Cart System

For a real-world service-oriented example of Composition, let's consider an _Online Shopping System_. In this system, a _ShoppingCart_ service is composed of _Item_ services. The lifecycle of _Item_ services is tightly coupled with the _ShoppingCart_ - when the cart is cleared or deleted, the items within it cease to exist in that context.

**Figure 2.** Shopping Cart System Relationship Class Diagram

This UML diagram effectively illustrates the composition relationship in a service-oriented architecture, where the _ShoppingCart_ service is composed of and manages the lifecycle of _Item_ services. This setup highlights the dependency of _Item_ services on their encompassing _ShoppingCart_ service.


![Shopping Cart System Relationship Class Diagram](https://cdngh.kapresoft.com/img/design-composition-vs-aggregation-shopping-937f573.png)

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/RP1D2i8m48NtESNGLRNq0Y9IS2K8Bdg2CHbhC7ycgL34kvjOQIiuYrcyxysyIPeGqSTUAyOSyXjs1CN9A6a8sgjrJfeEsY54qWKy6QJY2aEOu3vDVq6k-YX3t1wIVGSozJ2H2eN8UfaRoDKCF6dxeF-CAqAVCyfHVB753H_td5srqUTp3MgQHM7xio9mNlA5Aas4UuycoZWi5_yyQrtNOyO6kDNE1X9WBonP6p8Y_TaR" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=RP1D2i8m48NtESNGLRNq0Y9IS2K8Bdg2CHbhC7ycgL34kvjOQIiuYrcyxysyIPeGqSTUAyOSyXjs1CN9A6a8sgjrJfeEsY54qWKy6QJY2aEOu3vDVq6k-YX3t1wIVGSozJ2H2eN8UfaRoDKCF6dxeF-CAqAVCyfHVB753H_td5srqUTp3MgQHM7xio9mNlA5Aas4UuycoZWi5_yyQrtNOyO6kDNE1X9WBonP6p8Y_TaR" target="_blank">PlantText</a></small>

In this diagram:
- The _ShoppingCart_ class has methods to add, remove, or clear _Item_ instances from its list, indicating that it manages the lifecycle of _Item_ services.
- Each _Item_ class includes properties like _name_, _price_, and _quantity_, which are relevant to the shopping context.
- The composition relationship (represented by the filled diamond and a line) between _ShoppingCart_ and _Item_ implies that the _Item_ services are part of the _ShoppingCart_ and do not exist independently outside of it.
- For example, when a _ShoppingCart_ is cleared or deleted, the _Item_ instances in its list are also discarded, underlining their dependent existence.

The example Java implementation below captures the essence of a composition relationship where the items are part of the shopping cart and are managed by it.

```java
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@Data
public class ShoppingCart {
    private List<Item> items = new ArrayList<>();

    public void addItem(Item item) {
        items.add(item);
    }

    public void removeItem(Item item) {
        items.remove(item);
    }

    public void clearCart() {
        items.clear();
    }
}

@Data
@NoArgsConstructor
public class Item {
    private String name;
    private double price;
    private int quantity;

    public Item(String name, double price, int quantity) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }
}
```

In this code:
- The _ShoppingCart_ class contains a list of _Item_ objects. It provides methods to add, remove, or clear items from the cart.
- The _Item_ class represents an item in the shopping cart with properties like _name_, _price_, and _quantity_, and their respective getters and setters.
- The _clearCart_ method in the _ShoppingCart_ class clears the entire list of items, illustrating the dependency of _Item_ objects on the _ShoppingCart_ (if the cart is cleared or deleted, the items are also removed).

## Aggregation in Domain Modeling

*Aggregation*, on the other hand, suggests a weaker relationship. It indicates a “has-a” relationship, where the container object holds references to other objects but does not strictly manage their life cycles. In aggregation, the contained objects can exist independently of the container.

### Aggregation of Universities and Students

This time, we'll consider a scenario involving a _University_ and _Student_ to depict the aggregation relationship. In Aggregation, the _Student_ can exist independently of the _University_, unlike in Composition.

**Figure 3.** Aggregation Class Diagram for a University Student Relationship

This UML diagram illustrates the aggregation relationship between a _University_ and _Student_, demonstrating that while the university contains students, these students have an existence independent of the university.

![Aggregation Class Diagram for a University Student Relationship](https://cdngh.kapresoft.com/img/design-composition-vs-aggregation-university-34744e4.png)

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuU9ApaaiBbO8pSiiIoqgpYofLAZcKW02tU2IqfJKl9BeM8LY2AkOgnQc6Ye7L0eKGjAQhwiBbxDIo4Wivk9oICrB0Te30000" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=SoWkIImgAStDuU9ApaaiBbO8pSiiIoqgpYofLAZcKW02tU2IqfJKl9BeM8LY2AkOgnQc6Ye7L0eKGjAQhwiBbxDIo4Wivk9oICrB0Te30000" target="_blank">PlantText</a></small>

In this diagram:
- The _University_ class has an array of _Student_ objects, representing the students attending the university.
- The hollow diamond (o) in the relation _University o-- Student_ signifies an aggregation relationship. It indicates that _Student_ objects are associated with the _University_, but their lifecycle is not strictly tied to the _University_.
- This means students can exist independently of the university, like when they graduate or transfer to another institution.

### Aggregation of a Library Management System

For a real-world service-oriented example of Aggregation, let's consider a _Library Management System_. In this system, a _Library_ service aggregates _Book_ services. While the _Library_ manages and coordinates access to _Book_ services, each _Book_ service can exist independently, serving its information or getting loaned out to users. The _Library_ does not own the _Book_ services but merely coordinates them.

**Figure 4.** Aggregation Class Diagram for a Library Management System

This UML diagram efficiently illustrates the aggregation relationship in a service-oriented architecture, where the _Library_ service aggregates multiple _Book_ services without owning them.

![Aggregation Class Diagram for a Library Management System](https://cdngh.kapresoft.com/img/design-composition-vs-aggregation-library-51c2d6a.png)

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/PP1D2eD038NtSuhWobAyG2b5khPquGcYXkdW_9IPJ45AxzvH4HMpU93t7dmaPM3q78qMuerjZv8WgrJZqG_mG9jsGvQX7WAJoU0h84shCGHOQhCtphbIWQztv_eRD4d3cc3NZNu-2ZIdDV1at8SEsKziI5EmmTJibPN0YZKTN8pySdwrjKFxZ9plc1ozdPWxsdAHAugPUG6KqfD4fY1IgIJRfL_z0G00" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=PP1D2eD038NtSuhWobAyG2b5khPquGcYXkdW_9IPJ45AxzvH4HMpU93t7dmaPM3q78qMuerjZv8WgrJZqG_mG9jsGvQX7WAJoU0h84shCGHOQhCtphbIWQztv_eRD4d3cc3NZNu-2ZIdDV1at8SEsKziI5EmmTJibPN0YZKTN8pySdwrjKFxZ9plc1ozdPWxsdAHAugPUG6KqfD4fY1IgIJRfL_z0G00" target="_blank">PlantText</a></small>

In this diagram:
- The _Library_ class has a method to add or remove _Book_ instances to/from its collection, indicating that it manages _Book_ services.
- Each _Book_ class has methods like _loanOut()_ and _returnBook()_, suggesting that they maintain their behavior and state independently.
- The aggregation relationship (represented by the hollow diamond and a line) between _Library_ and _Book_ implies that the _Library_ service does not strictly control the lifecycle of the _Book_ services. Books can be added or removed from the library's collection without affecting their individual existence.
- This setup highlights the concept of service aggregation in a system where the main service (_Library_) coordinates and provides access to other independent services (_Book_).

Following the aggregation pattern for the _Library Management System_ with _Library_ and _Book_ classes, here's how you can implement it in Java with Lombok for reducing boilerplate code.

In this code, the aggregation relationship is characterized by the _Library_ managing a collection of _Book_ objects without having direct control over their lifecycle. The _Book_ objects maintain their independent existence, which is a fundamental characteristic of aggregation in object-oriented design.


```java
import lombok.Data;
import java.util.ArrayList;
import java.util.List;

@Data
public class Library {
    private List<Book> books;

    public Library() {
        this.books = new ArrayList<>();
    }

    public void addBook(Book book) {
        books.add(book);
    }

    public void removeBook(Book book) {
        books.remove(book);
    }
}

@Data
public class Book {
    private String title;
    private String author;

    public Book(String title, String author) {
        this.title = title;
        this.author = author;
    }
}
```

## In Conclusion

In this exploration of composition and aggregation in object-oriented programming, we've delved into the nuances of these two fundamental design patterns, crucial for structuring robust and efficient systems. Through real-world analogies and service-oriented examples, we've seen how these relationships dictate the interactions and dependencies between objects, influencing the design and functionality of software systems.

Composition, characterized by a strong, life-dependent relationship between objects, emphasizes the integral nature of components within a whole. Our example of the _Online Shopping System,_ illustrated both in concept and Java code, demonstrates how items within a shopping cart are intrinsically linked to the cart itself, ceasing to exist independently once the cart is cleared or deleted.

On the other hand, aggregation, with its emphasis on a looser association where components can exist independently of the whole, was exemplified in the _Library Management System._ Here, books in a library exist as separate entities and retain their identity and existence beyond the scope of the library, a concept we observed through both conceptual explanation and Java implementation.

Both composition and aggregation offer unique advantages and are chosen based on the specific requirements and constraints of the system being designed. Understanding these patterns not only aids developers in making informed design decisions but also enhances the maintainability, scalability, and overall quality of the software.

As we continue to advance in the world of software development, the thoughtful application of such design patterns remains a cornerstone in the creation of efficient, resilient, and adaptable systems. Whether you're a seasoned developer or a newcomer to the field, grasping the essence of composition and aggregation is a step towards mastering the art of software design and architecture.
