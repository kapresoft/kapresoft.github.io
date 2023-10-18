---
title: "Factory Design Pattern"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/10/18/factory-design-pattern.html
category: java
related: java
description: "Guide on the Factory Design Pattern, its applications in Java, and its role in modern programming like Spring Framework."
---

## Overview

Design patterns act as blueprints or templates for designing software solutions. The Factory Design Pattern is a creational pattern focused on object creation. This pattern, a crucial piece of the design structure, provides a guide for developers to create objects without specifying the exact class of the object that will be created.<!--excerpt-->

## Overview of Factory Design Pattern

In software development, especially when employing the Object-Oriented Programming (OOP) model, the structure or form of the application is pivotal. This is where the Factory Design Pattern comes into play. The Factory Pattern allows developers to create objects through the use of a factory method, rather than directly using the _new_ keyword, allowing for more flexibility and cleaner code.

## History of the Factory Pattern

The Factory Pattern, as we know it today, has its roots in the annals of software engineering literature and is one of the foundational design patterns that guide object-oriented software design.

The Factory Pattern was formally introduced to the wider software community in the seminal book "Design Patterns: Elements of Reusable Object-Oriented Software" [^1] , authored by Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides in 1994. Collectively, these authors are often referred to as the "Gang of Four" or simply "GoF."

Prior to this publication, the concept of using factories or centralized methods for object creation was already in circulation among software developers. However, the "Gang of Four" book provided a formal structure, clear terminology, and specific guidelines on how to implement this pattern effectively, thereby making it widely recognized and adopted.

The book recognized the challenge developers faced in creating objects directly, leading to tightly coupled code that was difficult to maintain and extend. To address this, the Factory Pattern advocated for delegating the responsibility of object creation to specialized factory methods, thereby promoting the principle of separation of concerns and making code more modular and extensible.

Over the years, the Factory Pattern has been instrumental in shaping the trajectory of software design, with its principles being incorporated into numerous software libraries, frameworks, and applications. Its timeless relevance stems from the core idea that the process of object creation should be abstracted away to enable greater flexibility and ease of maintenance.

In summary, while the core idea of the Factory Pattern predates the "Gang of Four" book, it was this particular publication that crystallized the concept, gave it a formal definition, and presented it systematically, leading to its widespread adoption and continued prominence in the realm of software design.

### Key Components

1. **Interface (or Abstract Class):** This acts as a protocol or contract that defines the blueprint of methods and attributes. The interface specifies what operations an object can do.
2. **Concrete Classes:** These are specific or tangible class implementations of the interface. They provide the actual business logic.
3. **Factory Class:** The producer or manufacturer of objects. It determines which class to instantiate based on input or configuration.

## An Example Factory Design Pattern Implementation in Java

Imagine we have a simple shape interface, and we want to create various shapes (Circle, Rectangle, Square) based on the provided input.

### Shape Interface
```java
public interface Shape {
    void draw();
}
```

### Concrete Classes for Different Shapes

#### Circle
```java
public class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a Circle.");
    }
}
```

#### Rectangle
```java
public class Rectangle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a Rectangle.");
    }
}
```

#### Square
```java
public class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a Square.");
    }
}
```

### ShapeFactory: The Creator Class
```java
public class ShapeFactory {
    
    public Shape getShape(String shapeType) {
        if (shapeType == null) {
            return null;
        }   
        if (shapeType.equalsIgnoreCase("CIRCLE")) {
            return new Circle();
        } else if(shapeType.equalsIgnoreCase("RECTANGLE")) {
            return new Rectangle();
        } else if(shapeType.equalsIgnoreCase("SQUARE")) {
            return new Square();
        }
        return null;
    }
}
```

### Using the Factory to Instantiate Objects
```java
public class FactoryPatternDemo {
    public static void main(String[] args) {
        ShapeFactory shapeFactory = new ShapeFactory();

        // Get an object of Circle and call its draw method
        Shape shape1 = shapeFactory.getShape("CIRCLE");
        shape1.draw();

        // Get an object of Rectangle and call its draw method
        Shape shape2 = shapeFactory.getShape("RECTANGLE");
        shape2.draw();

        // Get an object of Square and call its draw method
        Shape shape3 = shapeFactory.getShape("SQUARE");
        shape3.draw();
    }
}
```
### Class Diagram

Here's a PlantUML class diagram representation of the Factory Design Pattern based on the provided Java examples:

<img src="https://cdngh.kapresoft.com/img/design-pattern-factory-diagram-68b0734.png" 
alt="Factory Pattern Design Diagram">

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/XP513e9034NtFKMN68C7O458J3o0U85cg3W93jWf6gBUNI13a9X85rtylkR_ffbN4csl5O1rod8cmvXVg65y0lQrBOGUqIR1UsqBU0EOYhp7lHLJhJ17DagkNCFoMqkonWo93cIqbcuYIzPHZlpGJrt32UOgrfNz-ZWPzaFGk6tYLnhaETX23a4M6YoSTxjqkZn18qpA7jDVPZRuYmN3RmOoTiNuZWy0" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=XP513e9034NtFKMN68C7O458J3o0U85cg3W93jWf6gBUNI13a9X85rtylkR_ffbN4csl5O1rod8cmvXVg65y0lQrBOGUqIR1UsqBU0EOYhp7lHLJhJ17DagkNCFoMqkonWo93cIqbcuYIzPHZlpGJrt32UOgrfNz-ZWPzaFGk6tYLnhaETX23a4M6YoSTxjqkZn18qpA7jDVPZRuYmN3RmOoTiNuZWy0" target="_blank">PlantText</a></small>

In this diagram:

- The _Shape_ interface has a method named _draw()_.
- The _Circle_, _Rectangle_, and _Square_ classes implement the _Shape_ interface, each providing their specific implementation of the _draw()_ method.
- The _ShapeFactory_ class has a method _getShape()_ which returns an instance of _Shape_ (based on the input string).
- The relationships between _ShapeFactory_ and the shape classes (_Circle_, _Rectangle_, _Square_) indicate the "creates" relationship.

## Factory Design Pattern in Modern Programming Languages

Over time, the Factory Design Pattern has found its way into various modern programming tools and frameworks. One prominent example is the **Spring Framework**.

### Spring Framework and Factory Pattern

Spring, a widely-used framework in the Java ecosystem, utilizes the Factory Design Pattern extensively. The Spring container acts like a factory of beans (objects). Developers define the bean specifications in the configuration file, and the Spring container, acting as the Factory, then creates and manages the life cycle of these beans.

The _BeanFactory_ in Spring is an example of the Factory Pattern. It is responsible for managing, creating, and supplying beans as and when required. The Factory Pattern in Spring allows for more manageable and decoupled code, as beans can be injected wherever needed without directly instantiating them. This leads to cleaner and more modular code.

#### Class Diagram

<img src="https://cdngh.kapresoft.com/img/design-pattern-factory-spring-framework-beanfactory-0b2c322.png"
alt="Spring Framework BeanFactory Factory Design Pattern" />

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/pL9DJyCm3BtdLqGxRGBr1-o0Defs12GuS7KphmhB5uwhKG7_7QSQKZT6prY93_vwxyLPPGRYpZkb4fWzjAXdaTeg9xAXtH5uF4JQLmr2o3FzeRIO3Ooq0uFwLi8RC1ofF-QANRN89JCFqhxKJrncBPRweNb5mzDbrvhmhRE4s-S-IRHsaFE5NXC3Wmtv4auJevFmKFobpYYlKtBM0DiOQfc1xwpbOjZc2JLtDYS7_RtWp1S_I2SLZq0Ok2H_0vmKhZkE1z5NGuB6uGXpQFupUrHJ_E1CUHZzujsOjVN9eHSYKsB-qMhad2cegi-RCNUbLhARya6_0G00" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=pL9DJyCm3BtdLqGxRGBr1-o0Defs12GuS7KphmhB5uwhKG7_7QSQKZT6prY93_vwxyLPPGRYpZkb4fWzjAXdaTeg9xAXtH5uF4JQLmr2o3FzeRIO3Ooq0uFwLi8RC1ofF-QANRN89JCFqhxKJrncBPRweNb5mzDbrvhmhRE4s-S-IRHsaFE5NXC3Wmtv4auJevFmKFobpYYlKtBM0DiOQfc1xwpbOjZc2JLtDYS7_RtWp1S_I2SLZq0Ok2H_0vmKhZkE1z5NGuB6uGXpQFupUrHJ_E1CUHZzujsOjVN9eHSYKsB-qMhad2cegi-RCNUbLhARya6_0G00" target="_blank">PlantText</a></small>


## Conclusion

The Factory Design Pattern, a significant design blueprint, offers an efficient way of object creation by separating the use of objects from their actual creation. This pattern enhances code readability, reusability, and flexibility. Its relevance in modern frameworks like Spring shows its continued importance and applicability in evolving software development landscapes. As software design evolves, patterns like the Factory Pattern remain crucial, guiding developers to create efficient, clean, and modular code.

## References

[^1]: E. Gamma, R. Helm, R. Johnson, and J. Vlissides, *Design Patterns: Elements of Reusable Object-Oriented Software*. Addison-Wesley, 1994.
