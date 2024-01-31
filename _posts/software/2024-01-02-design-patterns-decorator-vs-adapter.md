---
title: "Decorator vs Adapter Design Pattern"
title_style: title2w
section_style: article1
category: software
tags:
  - "design patterns"
canonical_url: https://www.kapresoft.com/software/2024/01/02/design-patterns-decorator-vs-adapter.html
description: "Explore the differences between Decorator and Adapter design patterns in software engineering, and their unique applications."
---

## Overview

<a href="/java/2023/10/18/factory-design-pattern.html" target="_blank">Design patterns</a> in software engineering are akin to blueprints that address recurring problems in software design. These patterns offer standardized, time-tested solutions, making the development process more efficient and the end result more robust. They are essential tools in a developer's arsenal, enabling the creation of flexible, reusable, and maintainable code.<!--excerpt-->

In this exploration, we delve into two prominent design patterns: the <a href="/software/2023/12/27/decorator-design-pattern.html" target="_blank">Decorator</a> and the <a href="/software/2024/01/03/design-patterns-adapter.html" target="_blank">Adapter</a>. Each holds a unique place in object-oriented design. The Decorator pattern excels in adding responsibilities to objects dynamically, enhancing their functionality without altering the original structure. On the other hand, the Adapter pattern focuses on enabling communication between incompatible interfaces, bridging the gap between different parts of a system. Understanding their distinct purposes and applications is crucial for developers to make informed decisions in their design strategy.


## Understanding the Decorator Pattern

The Decorator pattern is a structural design pattern used extensively in object-oriented programming. Its primary purpose is to add new responsibilities to objects dynamically while avoiding subclassing. This pattern is particularly useful when you need to extend the functionality of classes at runtime without modifying their structure.

### Key Characteristics
1. **Dynamic Extension:** Decorator allows adding new functionalities to an object dynamically without altering its structure.
2. **Flexibility:** It provides a flexible alternative to subclassing for extending functionality.
3. **Multiple Inheritance Alternative:** In languages like Java that do not support multiple inheritance, Decorator offers a viable solution to achieve similar functionality.

### Code Example in Java
Consider a <a href="/java/2018/08/15/getting-started-with-java.html" target="_blank">Java</a> example of a simple coffee shop where you can customize your coffee with various add-ons like milk, sugar, or whipped cream. In this scenario, the base component could be a plain coffee, and the decorators would be the add-ons.

```java
// The base component
interface Coffee {
    String getDescription();
    double getCost();
}

// Concrete component
class BasicCoffee implements Coffee {
    public String getDescription() {
        return "Basic Coffee";
    }

    public double getCost() {
        return 2.00;
    }
}

// Abstract Decorator
abstract class CoffeeDecorator implements Coffee {
    protected Coffee decoratedCoffee;

    public CoffeeDecorator(Coffee coffee) {
        this.decoratedCoffee = coffee;
    }

    public String getDescription() {
        return decoratedCoffee.getDescription();
    }

    public double getCost() {
        return decoratedCoffee.getCost();
    }
}

// Concrete Decorators
class MilkDecorator extends CoffeeDecorator {
    public MilkDecorator(Coffee coffee) {
        super(coffee);
    }

    public String getDescription() {
        return decoratedCoffee.getDescription() + ", Milk";
    }

    public double getCost() {
        return decoratedCoffee.getCost() + 0.50;
    }
}

class SugarDecorator extends CoffeeDecorator {
    public SugarDecorator(Coffee coffee) {
        super(coffee);
    }

    public String getDescription() {
        return decoratedCoffee.getDescription() + ", Sugar";
    }

    public double getCost() {
        return decoratedCoffee.getCost() + 0.20;
    }
}

// Usage
public class DecoratorDemo {
    public static void main(String[] args) {
        Coffee myCoffee = new BasicCoffee();
        myCoffee = new MilkDecorator(myCoffee);
        myCoffee = new SugarDecorator(myCoffee);

        System.out.println("Description: " + myCoffee.getDescription());
        System.out.println("Cost: " + myCoffee.getCost());
    }
}
```

In this example, _BasicCoffee_ is the component being decorated. _CoffeeDecorator_ serves as an abstract wrapper, and _MilkDecorator_ and _SugarDecorator_ are concrete decorators that add respective features to the coffee.

**Figure 1.** Decorator Pattern Class Diagram

The following diagram effectively illustrates the relationship between the base component _Coffee_, the concrete component _BasicCoffee_, the abstract decorator _CoffeeDecorator_, and the concrete decorators _MilkDecorator_ and _SugarDecorator_.

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/design-patterns-decorator-vs-adapter-1-04ea6e2.webp">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/hP8n3i8m34Ltdy8I2mYr1wWwLBGhKqyG4hUA20bAt8boToeQ0GrirAFzzRxzaogmy3nS36ZBv3iX2MlNTKHu0vngZprnGq5wVMNjx7Q71RRijUtVyze5VWwK6qw6u0uWZGW13o9ekI9lHZKadHViV6HkKCqTKj6hYCeLB8_Qd5F3_uZjq0k_5Z8UN8vv_fdsef-a1ccAvPXbopj_IvQBVsdS97dbdoLF0XLPDVsp1m00" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=hP8n3i8m34Ltdy8I2mYr1wWwLBGhKqyG4hUA20bAt8boToeQ0GrirAFzzRxzaogmy3nS36ZBv3iX2MlNTKHu0vngZprnGq5wVMNjx7Q71RRijUtVyze5VWwK6qw6u0uWZGW13o9ekI9lHZKadHViV6HkKCqTKj6hYCeLB8_Qd5F3_uZjq0k_5Z8UN8vv_fdsef-a1ccAvPXbopj_IvQBVsdS97dbdoLF0XLPDVsp1m00" target="_blank">PlantText</a>
   </small>
</div>

In this PlantUML diagram for the Decorator design pattern, we see a clear representation of how the pattern is structured in the context of a coffee customization scenario:

- **_Coffee_ Interface:** This is the core interface defining the methods _getDescription()_ and _getCost()_. It represents the base component in the Decorator pattern, outlining the basic structure and functionalities expected from any coffee type.

- **_BasicCoffee_ Class:** Implements the _Coffee_ interface. This class serves as the concrete component, representing a basic coffee without any additional decorations or enhancements. It provides the standard implementation for the methods defined in the _Coffee_ interface.

- **_CoffeeDecorator_ Class:** This is an abstract class that also implements the _Coffee_ interface. It serves as the base decorator, holding a reference (_decoratedCoffee_) to a _Coffee_ object. The _CoffeeDecorator_ class delegates the calls to the methods of the _Coffee_ interface to the object it decorates, thereby allowing additional behaviors to be added.

- **_MilkDecorator_ and _SugarDecorator_ Classes:** These are concrete decorator classes extending the _CoffeeDecorator_ class. Each of these classes adds specific functionalities (like adding milk or sugar) to the coffee. They override the _getDescription()_ and _getCost()_ methods to incorporate their respective enhancements along with those of the coffee object they are decorating.

- **Inheritance and Composition Relations:**
   - Both _BasicCoffee_ and _CoffeeDecorator_ are shown as implementing the _Coffee_ interface, indicated by the dashed lines with open arrowheads.
   - _MilkDecorator_ and _SugarDecorator_ are depicted as subclasses of _CoffeeDecorator_, showing the inheritance relationship with solid lines and closed arrowheads.
   - The composition relationship between _CoffeeDecorator_ and _Coffee_ is illustrated with a solid line and a diamond at the _CoffeeDecorator_ end, indicating that _CoffeeDecorator_ contains a reference to a _Coffee_ object.

This diagram effectively captures the essence of the Decorator pattern, highlighting the dynamic addition of responsibilities to the coffee object through various decorators like _MilkDecorator_ and _SugarDecorator_.

### Real-World Examples and Use Cases
1. **GUI Toolkits:** Adding features like scrolling, borders, or shadows to UI components.
2. **I/O Streams in Java:** Wrapping basic I/O classes with functionalities like buffering, filtering, and reading/writing various data types.
3. **Web Development:** Middleware in web frameworks can be seen as decorators adding functionalities like logging, authentication, or data compression to HTTP requests and responses.

The Decorator pattern excels in scenarios where you need to layer multiple behaviors or responsibilities on objects dynamically and reversibly, providing a highly flexible approach to system design.

## Exploring the Adapter Pattern

The Adapter pattern, a fundamental structural design pattern in object-oriented programming, serves as a bridge between two incompatible interfaces. This pattern allows objects with incompatible interfaces to collaborate by wrapping their own interface around an existing class.

### Key Characteristics
1. **Interface Compatibility:** Adapter makes classes with incompatible interfaces work together by wrapping their interface.
2. **Simplicity and Transparency:** Clients interact with the adapter as if it were a target class without needing to be aware of the adapted class's interface.
3. **Reusability and Flexibility:** The pattern allows the reuse of existing classes even if their interfaces do not match the required standard.

To illustrate the Adapter pattern using a PlantUML class diagram, let's create a text representation based on the Java example previously discussed, where an _JsonToXmlAdapter_ allows a client to use an _XmlParser_ as if it were a _JsonParser_.

**Figure 2.**  Adapter Pattern Class Diagram

The diagram below illustrates the class diagram of the Adapter Pattern. It visually represents how this design pattern connects incompatible interfaces, enabling them to work together seamlessly. The diagram offers a clear view of the structural components and their interactions within the Adapter Pattern.

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/design-patterns-decorator-vs-adapter-2-376b5af.webp">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuUBAp2j9BKfBJ4vLy2hEpmj8B2fEBLAevb800cs50X0N9AwH1IHS4aiI5QmKWakAClFIDO6iilpC5AvQBgxadCJYOeM8t1nise726XMvEGGqWom9oGUgTKn9B2Y1cw6hK04trGfX0sdEG_AOJOsU7ePTN1YMwwRab-VfsY5voKf15-uIBYw7rBmKOEW10000" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=SoWkIImgAStDuUBAp2j9BKfBJ4vLy2hEpmj8B2fEBLAevb800cs50X0N9AwH1IHS4aiI5QmKWakAClFIDO6iilpC5AvQBgxadCJYOeM8t1nise726XMvEGGqWom9oGUgTKn9B2Y1cw6hK04trGfX0sdEG_AOJOsU7ePTN1YMwwRab-VfsY5voKf15-uIBYw7rBmKOEW10000" target="_blank">PlantText</a>
   </small>
</div>

In this diagram:
- The _JsonParser_ interface defines the _parseJson_ method that the client expects to use.
- The _XmlParser_ class represents the existing incompatible class with the _parseXml_ method.
- The _JsonToXmlAdapter_ class, implementing the _JsonParser_ interface, acts as an adapter. It contains a reference to an _XmlParser_ object and converts the JSON data to XML format before delegating the XML parsing to the _XmlParser_.

This diagram visually encapsulates the Adapter pattern, showing how it bridges the gap between incompatible interfaces, enabling objects to work together harmoniously.

### Code Example in Java
Consider a scenario in software development where a client expects to interact with a _JsonParser_ interface, but the available parser is an _XmlParser_. The Adapter pattern can be used to make the _XmlParser_ compatible with the _JsonParser_ interface.

```java
// Target interface
interface JsonParser {
    void parseJson(String jsonData);
}

// Adaptee class
class XmlParser {
    void parseXml(String xmlData) {
        System.out.println("Parsing XML: " + xmlData);
    }
}

// Adapter class
class JsonToXmlAdapter implements JsonParser {
    private XmlParser xmlParser;

    public JsonToXmlAdapter(XmlParser xmlParser) {
        this.xmlParser = xmlParser;
    }

    public void parseJson(String jsonData) {
        // Convert JSON to XML
        String xmlData = convertJsonToXml(jsonData);
        xmlParser.parseXml(xmlData);
    }

    private String convertJsonToXml(String jsonData) {
        // Conversion logic
        return "<xml>Data converted from JSON</xml>";
    }
}

// Usage
public class AdapterDemo {
    public static void main(String[] args) {
        XmlParser xmlParser = new XmlParser();
        JsonParser parser = new JsonToXmlAdapter(xmlParser);

        parser.parseJson("{json: data}");
    }
}
```

In this example, _XmlParser_ is the existing class (adaptee), while _JsonToXmlAdapter_ is the adapter class implementing the _JsonParser_ interface. The adapter translates the JSON input into XML format, allowing the client to use _XmlParser_ indirectly.

### Real-World Examples and Use Cases
1. **Legacy Code Integration:** Wrapping legacy code or third-party libraries, making them compatible with new systems.
2. **Data Format Conversion:** Converting data from one format to another, such as JSON to XML or vice versa.
3. **Device Interface Compatibility:** In electronics and software drivers, where new devices need to be compatible with old systems or vice versa.

The Adapter pattern is particularly useful in situations where modifying the existing code is impractical or impossible. It is a powerful tool for achieving compatibility and reusability in software systems, ensuring that existing classes or components can work in new environments without significant changes to their original code.

## Key Differences Between Decorator and Adapter

Understanding the distinctions between the Decorator and Adapter patterns is crucial for effective design in software engineering. While both are structural patterns used for object composition, their intents, implementations, and applications differ significantly.

### Intent and Purpose
- **Decorator Pattern:** The primary intent of the Decorator is to _add new responsibilities_ to objects dynamically. It enhances an object’s behavior by wrapping it with additional functionalities. The focus is on extending capabilities without modifying the underlying structure of the object.
- **Adapter Pattern:** The Adapter's goal is to _enable collaboration_ between incompatible interfaces. It acts as a bridge, making one class look like another class by converting the interface of one class into another interface expected by the clients.

### Implementation
- **Decorator Pattern Implementation:** In Decorator, the pattern typically involves a base component interface, concrete components implementing this interface, and several decorator classes that also implement the interface and add extra functionality. Decorators wrap the original component, either directly or by wrapping other decorators.
- **Adapter Pattern Implementation:** The Adapter involves two distinct interfaces and a third component, the adapter, that facilitates the interaction between the two. The adapter implements the target interface and holds a reference to an instance of the adaptee class.

### Code Structure
- **Decorator Pattern:** In Java, Decorator often uses abstract classes for the decorator's base class and concrete decorators extending this base to add functionalities.
- **Adapter Pattern:** The Adapter in Java can be implemented in two ways: class adapter (using inheritance) and object adapter (using composition).

### Use Cases
- **Decorator Pattern Use Cases:** It's widely used in UI libraries for adding features like borders, scrolling, or color changes to widgets. It's also prevalent in stream I/O operations in Java, where you can dynamically add functionalities like buffering, data conversion, etc.
- **Adapter Pattern Use Cases:** Commonly used in system integration where existing classes need to work with others without modifying their source code, like integrating new libraries or APIs into existing systems.

### Problem Solving
- **Decorator Pattern:** Solves the issue of rigid inheritance hierarchies by allowing dynamic extension of object behavior, thereby promoting flexibility and scalability in the application design.
- **Adapter Pattern:** Addresses the problem of incompatible interfaces. It is vital in scenarios where making changes to existing code is not feasible, ensuring the new and existing systems can work together seamlessly.

To wrap it up, while the Decorator pattern focuses on adding responsibilities to objects dynamically, the Adapter pattern is about making existing interfaces compatible with each other. Both play distinct and critical roles in software design, offering solutions to different types of structural problems in object-oriented programming. Understanding when and how to use each pattern is a key skill in a software engineer's repertoire.

## When to Use Decorator vs Adapter

Choosing between the Decorator and Adapter patterns depends largely on the specific problem at hand and the objectives of your design. Each pattern serves a distinct purpose and is advantageous in different scenarios.

### Guidelines for Choosing
1. **Objective of Design:**
    - Use the _Decorator_ when the goal is to add new responsibilities or behaviors to objects dynamically without altering their structure.
    - Opt for the _Adapter_ when you need to make existing classes with incompatible interfaces work together.

2. **Nature of the Problem:**
    - If the problem is about extending functionality and adding flexibility to a system, the Decorator is the suitable choice.
    - When the issue is about integrating new functionalities or components that don't match the existing system's interface, the Adapter pattern is more appropriate.

3. **Design Flexibility:**
    - The Decorator is ideal for scenarios where enhancements or changes are expected to evolve dynamically at runtime.
    - Adapter is better suited for scenarios where a clear-cut interface mismatch needs to be bridged, typically at compile-time.

### Scenarios for Each Pattern
1. **Decorator Use Cases:**
    - In user interface development, where you might need to add features like scrolling or borders to widgets dynamically.
    - In I/O stream manipulation, like adding buffering or data conversion capabilities to basic data streams.

2. **Adapter Use Cases:**
    - In system integration, especially when incorporating legacy systems or third-party libraries without source code modification.
    - In situations where a new component needs to interact with an older system, and altering the existing system's code is impractical or impossible.

## Conclusion

The exploration of the <a href="/software/2023/12/27/decorator-design-pattern.html" target="_blank">Decorator</a> and Adapter design patterns reveals their distinct roles in object-oriented software development. The Decorator pattern excels in dynamically enhancing objects with additional responsibilities without altering their core structure, offering a flexible alternative to subclassing. It is particularly useful in scenarios requiring runtime extension of functionalities, like GUI enhancements or <a href="/java/2023/12/09/java-streams-filter-map-beyond-basics.html" target="_blank">stream</a> manipulation.

Conversely, the Adapter pattern addresses interface incompatibility issues, acting as a bridge between classes with mismatched interfaces. It's essential in integrating disparate parts of a system, such as legacy code integration or third-party library adaptation, without modifying the existing codebase.

Selecting the appropriate pattern hinges on understanding the specific needs of your software design. While the Decorator pattern enhances flexibility and functionality, the Adapter focuses on compatibility and integration. The correct application of these patterns not only resolves structural problems in software design but also contributes to more maintainable, scalable, and robust systems.
