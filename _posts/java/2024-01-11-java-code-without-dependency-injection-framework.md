---
title: "Handcrafting Java: The Art of Coding Without DI Frameworks"
title_style: title2w
section_style: article1
category: java
related: java
canonical_url: https://www.kapresoft.com/java/2024/01/11/java-code-without-dependency-injection-framework.html
description: "Explore Java coding without a DI framework, using a manual approach to replicate features of frameworks like Spring."
---

## Overview

Imagine navigating the world of <a href="/java/2018/08/15/getting-started-with-java.html" target="_blank">Java</a> development without the convenience of Dependency Injection (DI) frameworks like <a href="/java/2024/01/03/spring-getting-started.html" target="_blank" alt="Spring">Spring</a> or <a href="/java/2024/01/11/java-guice-for-beginners.html" target="_blank" alt="Guice">Guice</a>. What if you had to manage every component and its dependencies manually? It might sound daunting, but there's a certain charm and depth in this alternative approach: coding without a DI framework. 

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/java-code-without-di-c83b734.webp" alt="Image: Java • Code Without Dependency Injection Framework">
</div>

This article takes you on an intriguing journey through the lesser-traveled path of Java development, unraveling the nuances of manually controlling component creation and dependencies. 

Get ready to dive into a realm where simplicity meets effectiveness, as we demonstrate a hands-on method to replicate and understand features typically handled by DI frameworks. Let the adventure begin!

## The Concept of Manual Dependency Management

Manual dependency management in Java represents a stark contrast to the automated convenience of frameworks like Spring. At its core, this method involves explicitly defining and managing the relationships and dependencies between different components in a Java application. Unlike Spring's automated dependency injection, which seamlessly wires components together, manual management demands a more in-depth understanding of how these components interact and depend on each other.

This approach necessitates a granular level of control over the lifecycle of each component, from creation to destruction. Developers must consciously design and implement the logic for creating instances, handling dependencies, and managing the lifecycle of each component in their application. It's a process that requires careful planning and a thorough understanding of the application's architecture, as well as the roles and responsibilities of each component within it.

Opting for manual dependency management often leads to more <a href="/java/2023/03/13/lombok-overview.html" target="_blank" alt="boilerplate">boilerplate</a> code and a hands-on approach to managing component relationships, providing developers with a clearer insight into the inner workings of their application. This method shines in scenarios where customized control is paramount, or in environments where using a full-fledged framework like Spring isn't feasible or necessary.

## Real World Example:  Register User

For the purpose of this article and to demonstrate the concept of not using dependency injection, we start out with this use case: In this scenario, we explore the process of a user registering with the system by providing their email and personal information. The system validates this information, ensures it's unique, and upon successful registration, sends a confirmation email to the user. This use case involves the direct participation of the user and the system, detailing the step-by-step flow from initial data submission to the completion of registration.

#### Description
A user can register by providing their email and personal information. After successful registration, the system sends a confirmation email to the user.

#### Main Flow
1. User provides email and personal information.
2. System validates and checks for duplicate email addresses.
3. If valid and unique:
   - a. System creates a new user account.
   - b. System sends a confirmation email with a verification link.
4. User receives the email, clicks the link, and confirms their email.
5. User is registered and can log in.

### Understanding User Registration

The user registration process in a Java application without a Dependency Injection (DI) framework can be complex, involving multiple components interacting with each other. A sequence diagram helps in visualizing the flow of this process. The diagram below outlines the sequence of interactions between different components during user registration.

**Figure 1.**  User Registration Flow

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/java-code-without-di-1-865f65b.webp">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/RL7B3i8m3BltAtA4mtvWGWW4d96O-82e3IZIra6QyVrqOK1vN5h9TkquNIL5qQ5hdRAs10rT1ugUOCju5kngE2OIED2Pamegzz4vzDgB4UwINxFd2qOre26viQSVVBlUVs2x3hdz9vw86BAvi-ngMJhN83OBoGZEncFk2lufpu4rU25KCk7m4cO6gbArCHLW391oCNeq-_8i1yx6VJonT0QkGn1AQKeeTHPJ5AeXvRlSfP5_IYogwZsVa0uIfp81nXpdLjbf_BOx" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=RL7B3i8m3BltAtA4mtvWGWW4d96O-82e3IZIra6QyVrqOK1vN5h9TkquNIL5qQ5hdRAs10rT1ugUOCju5kngE2OIED2Pamegzz4vzDgB4UwINxFd2qOre26viQSVVBlUVs2x3hdz9vw86BAvi-ngMJhN83OBoGZEncFk2lufpu4rU25KCk7m4cO6gbArCHLW391oCNeq-_8i1yx6VJonT0QkGn1AQKeeTHPJ5AeXvRlSfP5_IYogwZsVa0uIfp81nXpdLjbf_BOx" target="_blank">PlantText</a>
   </small>
</div>

#### Sequence Diagram Explanation
- **Actor (User)**: Represents the end-user or client initiating the registration process.
- **Participant (UserService)**: This is the service layer that orchestrates the user registration process. It acts as the primary coordinator for various actions required during registration.
- **Participant (UserDAO)**: The Data Access Object (DAO) for the user. It is responsible for handling all data-related operations, like creating and storing user details in the database.
- **Participant (EmailService)**: A service dedicated to handling email operations. It is invoked to send confirmation emails as part of the registration process.
- **Participant (EmailSender)**: This represents the actual mechanism or service used to send emails, such as an SMTP server or a third-party email service.

#### Sequence of Events
1. **User to UserService**: The sequence begins with the 'User' initiating a _registerUser(User)_ call to the _UserService_.
2. **UserService to UserDAO**: The _UserService_ then interacts with _UserDAO_ to create a new user by invoking _createUser(user)_.
3. **UserDAO Operations**: _UserDAO_ processes the request, creating and storing the user details in the database.
4. **UserService to EmailService**: Once the user is created, _UserService_ calls _EmailService_ to confirm the user's email address through the method _confirmEmailAddress(user)_.
5. **EmailService to EmailSender**: _EmailService_ delegates the task of sending the registration email to _EmailSender_, which could be an internal or external email dispatching service.
6. **UserDAO to UserService**: Finally, _UserDAO_ returns the created user to the _UserService_, completing the registration process.

This sequence diagram effectively illustrates the flow of actions and interactions between different components during the user registration process in a Java application, specifically

in one that manages dependencies manually. The diagram underscores the need for clear communication and coordination between various components, highlighting the importance of well-defined interfaces and responsibilities in each part of the system.

Through this interaction flow, the diagram showcases how the application handles a user registration request, from receiving the initial user data to persisting it in the database and sending out a confirmation email. It also reflects the layered architecture commonly used in Java applications, where the service layer (UserService) acts as a mediator between the presentation layer (represented by the User actor) and the data access layer (UserDAO), with additional services like EmailService providing specific functionalities.

This visual representation aids in understanding the intricacies and dependencies involved in the process, making it easier to identify potential areas for optimization or refactoring, especially in a setup where dependency injection is not utilized. By breaking down the process into discrete steps and clarifying the role of each component, developers can ensure that each part of the system functions efficiently and cohesively, leading to a robust and reliable user registration feature in the application.

## Creating the _ApplicationContext_

The _ApplicationContext_ class in Java, especially in scenarios without a Dependency Injection (DI) framework like Spring, is crucial for managing the lifecycle and dependencies of various components within an application. This class acts as a custom-built alternative to DI frameworks, allowing for manual control and instantiation of application components.

### Structure and Functionality
In the updated implementation of the _ApplicationContext_, several key components are defined, each playing a vital role in the application's functionality:

1. **UserService (_UserServiceImpl_)**: This singleton service is responsible for user-related operations, such as user management and interactions with the data access layer.

2. **EmailService (_EmailServiceImpl_)**: Another singleton service, this component handles email-related functionalities, including the preparation and sending of emails through the EmailSender.

3. **UserDAO (_UserDAOImpl_)**: Defined as a prototype, the UserDAO is responsible for data access operations, particularly for user data. Being a prototype means that a new instance of _UserDAOImpl_ is created whenever it is requested.

4. **EmailSender (_EmailSenderImpl_)**: Also a prototype, this component is the actual mechanism for sending emails, such as interfacing with an SMTP server or another email dispatch system.

**Code Listing 1.**  The ApplicationContext

```java
public class ApplicationContext {

    private static class Holder {
        private static final ApplicationContext CTX = new ApplicationContext();
        private static final UserService USER_SERVICE = new UserServiceImpl();
        private static final EmailService EMAIL_SERVICE = new EmailServiceImpl();
    }

    public static ApplicationContext getInstance() {
        return Holder.CTX;
    }

    public UserService userService() {
        return Holder.USER_SERVICE;
    }

    public EmailService emailService() {
        return Holder.EMAIL_SERVICE; 
    }

    // Prototype
    public UserDAO userDAO() {
        return new UserDAOImpl();
    }

    // Prototype
    public EmailSender emailSender() {
        return new EmailSenderImpl();
    }

}
```
<div class="link">
<small>Github: <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/ApplicationContext.java" target="_blank" alt="ApplicationContext">ApplicationContext.java</a></small>
</div>



### Implementation Details
The _ApplicationContext_ uses a static nested class _Holder_ to initialize and hold these components. The use of the static nested class pattern ensures that the singleton instances of _UserService_ and _EmailService_ are created lazily and are thread-safe without requiring synchronization.

The _getInstance()_ method provides a global point of access to the _ApplicationContext_, ensuring consistent use of the same instance across the application.

The methods _userService()_, _emailService()_, _userDAO()_, and _emailSender()_ provide access to the respective components. The distinction between singleton and prototype scoped components is evident here. While _UserService_ and _EmailService_ are singletons, _UserDAO_ and _EmailSender_

are created anew with each call, adhering to the prototype pattern. This distinction is crucial in managing the state and lifecycle of these components:

- **Singleton Components**: The single instance of _UserService_ and _EmailService_ ensures that these services maintain their state across the application, providing a consistent point of interaction for all components that depend on them.

- **Prototype Components**: The prototype scope of _UserDAO_ and _EmailSender_ allows for the creation of a new instance each time they are requested. This approach is beneficial for components that need to be stateless or where each operation requires a fresh instance to avoid shared state issues.

### Practical Usage
In practice, the _ApplicationContext_ enables centralized control over the creation and provisioning of core components, contrasting with Dependency Injection (DI) frameworks which automate dependency management, reducing manual control but simplifying the process. For example, when a part of the application requires access to _UserService_, it calls _ApplicationContext.getInstance().userService()_, ensuring that it interacts with the same instance of _UserService_ throughout the application.

Similarly, when a new instance of _UserDAO_ or _EmailSender_ is needed, the application calls _userDAO()_ or _emailSender()_ methods, respectively, on the _ApplicationContext_. This manual management of component instantiation and dependency handling allows for a clear understanding of the application's flow and dependencies, providing a more hands-on approach compared to automated DI frameworks.

The updated _ApplicationContext_ structure thus becomes a pivotal element in the application, demonstrating an effective way to manage dependencies and component lifecycles in Java applications, especially in scenarios where the use of a DI framework like Spring is not preferred or feasible.

### Simplifying the Dependency Resolution

The implementation of the _ApplicationContextSupport_ interface in Java plays a pivotal role in streamlining the process of dependency resolution within an application, especially in environments without traditional Dependency Injection (DI) frameworks. This interface, equipped with default methods, significantly simplifies the task of accessing dependent objects.

#### Design and Utility
The _ApplicationContextSupport_ interface is designed to provide default methods that directly interface with the _ApplicationContext_. These methods act as shortcuts to access various components like _UserDAO_, _EmailSender_, _UserService_, and _EmailService_. By doing so, it eliminates the repetitive task of fetching the _ApplicationContext_ instance and then calling the specific method to obtain the required object.

**Code Listing 2.**  The ApplicationContextSupport

```java
public interface ApplicationContextSupport {

    default ApplicationContext applicationContext() {
        return ApplicationContext.getInstance();
    }

    default UserDAO userDao() {
        return applicationContext().userDAO();
    }

    default EmailSender emailSender() {
        return applicationContext().emailSender();
    }

    default UserService userService() {
        return applicationContext().userService();
    }

    default EmailService emailService() {
        return applicationContext().emailService();
    }

}
```
<div class="link">
<small>Github: <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/ApplicationContextSupport.java" target="_blank" alt="ApplicationContextSupport.java">ApplicationContextSupport.java</a></small>
</div>


#### Example of Simplified Access
In the given example, a class implementing _ApplicationContextSupport_ can straightforwardly access dependencies. For instance:

```java
// UserServiceImpl implements ApplicationContextSupport
@Override
public User findUser(String email) throws UserNotFoundException {
    return userDao().findUserByEmail(email));
}
```

In this scenario, the _findUser_ method utilizes the _userDao()_ from _ApplicationContextSupport_ to access the _UserDAO_. This method abstracts the underlying complexity of fetching the _ApplicationContext_ and then the _UserDAO_. Instead of writing _ApplicationContext.getInstance().userDAO().findUserByEmail(email)_, the method call is succinctly reduced to _userDao().findUserByEmail(email)_.

#### Benefits
1. **Code Clarity**: Implementing this interface brings clarity to the code. Developers can focus on business logic rather than dealing with the intricacies of fetching dependencies.

2. **Reduced Boilerplate**: It significantly cuts down the boilerplate code, as there's no need to repeatedly call _ApplicationContext.getInstance()_.

3. **Enhanced Readability**: The code becomes more readable and maintainable, enhancing overall development efficiency.

4. **Flexibility**: This approach offers flexibility in managing dependencies and

can be easily adapted or extended for additional components, should the need arise.

5. **Consistency**: By standardizing how components are accessed throughout the application, _ApplicationContextSupport_ ensures a consistent approach to dependency resolution.

To sum up, the _ApplicationContextSupport_ interface with its default methods provides a convenient and efficient way to access and manage dependencies in a Java application. This design not only simplifies the process of dependency resolution but also aligns well with best practices of clean and maintainable code, particularly in environments that opt out of using conventional DI frameworks.

## A Test-Driven Approach

Let's start out with a test-driven approach to this implementation, a methodology that not only ensures the robustness of our code but also guides the development process in a structured manner. Test-Driven Development (TDD) in Java is particularly effective when exploring alternative methods like coding without a Dependency Injection (DI) framework. This approach allows us to first define the expected behavior through tests and then develop the implementation to meet these expectations.

### Testing the User Registration
The code snippet provided is a JUnit test case for the user registration functionality in a Java application. This test is part of the _UserServiceTest_ class which implements the _ApplicationContextSupport_ interface. The interface simplifies the process of accessing the application context and its dependencies, as demonstrated in the test method _registerUser()_. For the purpose of simplicity, this test will not verify the confirmation email.

**Code Listing 3.**  Register User Test

```java
class UserServiceTest implements ApplicationContextSupport {

    @Test
    void registerUser() {
        User newUser = User.builder().email("steve.rogers@gmail.com")
                .first("Steve").last("Rogers")
                .active(true).build();

        User createdUser = userService().registerUser(newUser);
        assertThat(createdUser).isNotNull().satisfies(u -> {
            assertThat(u.getId()).as("Id")
                    .isGreaterThan(0L);
            assertThat(u.getEmail()).as("Email")
                    .isEqualTo("steve.rogers@gmail.com");
            assertThat(u.getFirst()).as("First Name")
                    .isEqualTo("Steve");
            assertThat(u.getLast()).as("Last Name")
                    .isEqualTo("Rogers");
        });
    }

}
```
<div class="link">
<small>Github: <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/test/java/com/kapresoft/articles/nodi/service/UserServiceTest.java" target="_blank" alt="UserServiceTest.java">UserServiceTest.java</a></small>
</div>


#### Breakdown of the Test Method

1. **Creating a New User**: The test begins by building a new _User_ object, _newUser_, with predefined attributes. This step mimics the data input from a user during the registration process.

2. **Registering the User**: It then calls the _registerUser(newUser)_ method on _userService()_, obtained through _ApplicationContextSupport_. This step is critical as it tests the actual registration process implemented in the _UserService_.

3. **Assertions**: The test uses _assertThat_ from the AssertJ library to validate the outcome. It ensures that the _createdUser_:
   - Is not null, confirming that the registration process returns a user object.
   - Has an ID greater than 0, indicating successful storage and ID assignment in the database.
   - Retains the correct email, first name, and last name as provided, ensuring data integrity.

#### Importance of This Test-Driven Approach
By adopting a TDD approach, we validate the functionality of our user registration process in a controlled environment. It allows us to confirm that the application behaves as expected even without relying on a DI framework. Moreover, it ensures that any changes in the application's code can be immediately tested against these defined behaviors, maintaining the reliability and stability of the application over time.

In brief, this test-driven approach is not just a best practice but an essential part of developing robust Java applications, particularly when exploring alternative methods like manual dependency management.

## Mocking the ApplicationContext

In contexts without a Dependency Injection (DI) framework, mocking the _ApplicationContext_ becomes a vital strategy for effective unit testing. It allows for simulating the application's environment and dependencies in a controlled manner. This approach is especially useful for testing classes that depend on the _ApplicationContext_ for their dependencies. By mocking the _ApplicationContext_, we can ensure that our unit tests are focused solely on the class under test, without any interference from the actual implementation of the dependencies.

### Example with UserService

To demonstrate this, let’s consider a test case for the _UserService_ class, where we mock the _ApplicationContext_ and use it to provide mock dependencies. Here's an example using Mockito:

```java
@ExtendWith(MockitoExtension.class)
public class UserServiceIntegrationTest {

   @Mock
   private UserDAO userDAOMock;
   @Mock
   private EmailService emailServiceMock;
   @Mock
   private ApplicationContext applicationContextMock;
   @Spy
   private UserServiceImpl userService;

   @BeforeEach
   public void setUp() throws Exception {
      when(applicationContextMock.userDAO()).thenReturn(userDAOMock);
      when(applicationContextMock.emailService()).thenReturn(emailServiceMock);
      doReturn(applicationContextMock).when(userService).applicationContext();
   }

   @Test
   public void testRegisterUser() {
      User newUser = User.builder().email("steve.rogers@gmail.com")
              .first("Steve")
              .last("Rogers")
              .build();
      doNothing().when(userDAOMock).createUser(newUser);
      when(userDAOMock.findUserByEmail(anyString())).thenReturn(of(newUser));

      User registeredUser = userService.registerUser(newUser);

      verify(userDAOMock).createUser(newUser);
      verify(userDAOMock).findUserByEmail(newUser.getEmail());
      verify(emailServiceMock).confirmEmailAddress(newUser);
      assertThat(registeredUser).isNotNull();
      // Additional assertions as needed
   }

}
```
<div class="link">
<small>Github: <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/test/java/com/kapresoft/articles/nodi/service/UserServiceIntegrationTest.java" target="_blank" alt="">UserServiceIntegrationTest.java</a></small>
</div>

In this setup:

- The _@Spy_ annotation on _UserServiceImpl_ creates a spy around an instance of _UserServiceImpl_, allowing the testing of real methods with the option to override certain calls.

- Mocks for _UserDAO_ and _EmailService_ are created and then injected into the _ApplicationContext_ mock.

- The _applicationContext()_ method in _UserServiceImpl_ is stubbed to return the mocked _ApplicationContext_. This ensures that when the class under test calls _applicationContext()_, it gets a controlled, mock environment.

- The _testRegisterUser()_ method constructs a test scenario where a new user is registered, verifying the interactions with the mocked dependencies and asserting the expected outcomes.

This approach, where the _ApplicationContext_ is mocked and its methods stubbed to return specific mocks, offers a powerful and flexible way to test classes in isolation. It demonstrates the efficacy of using Mockito for testing in Java, especially in situations where dependency injection is manually handled and not facilitated by frameworks like Spring.

As you can see, mocking can be quite involved. In this case, we had to use a spy to effectively oversee the real behavior of _UserServiceImpl_ while having the ability to control its interaction with dependencies. This combination of spies and mocks is essential when you want to test the functionality of a class in a near-real scenario, but with full control over external dependencies. It provides a delicate balance between testing with real objects and ensuring predictable outcomes by mocking external interactions.

Using a spy is particularly useful when you need to test the class's actual code but override some of its behavior, typically external calls. However, it's important to use this technique judiciously as it can lead to tests that are more complex and potentially fragile. In the context of manual dependency management, as opposed to automatic DI, such complexities are more common, and understanding how to effectively leverage Mockito's spying and mocking capabilities becomes crucial for writing comprehensive and reliable tests.

## UserService

The _UserService_ in this Java application exemplifies a sophisticated approach to managing dependencies, particularly in an environment where Dependency Injection (DI) frameworks are not utilized. The key aspect of this implementation is its reliance on the _ApplicationContextSupport_ interface to access dependent objects. This design choice highlights the utility of the interface in simplifying dependency management.

### The _ApplicationContextSupport_ Integration
By implementing _ApplicationContextSupport_, _UserServiceImpl_ inherits methods that provide easy access to other components in the application, like _UserDAO_ and _EmailService_. This approach is a form of behavioral inheritance, where _UserServiceImpl_ gains the behavior of accessing dependencies through methods defined in _ApplicationContextSupport_. It's a strategic design that leverages interface default methods to reduce boilerplate code and centralize the logic for accessing application components.

### Analysis of _UserServiceImpl_
1. **Registration Process**: The _registerUser()_ method in _UserServiceImpl_ demonstrates a clear and efficient process for registering a new user. It first calls _userDao().createUser(user)_ to persist the user's information. Following this, it retrieves the newly created user by email and throws a _CreateUserFailedException_ if the user is not found. Finally, it uses _emailService().confirmEmailAddress(createdUser)_ to send a confirmation email, demonstrating a seamless integration of various components.

2. **Finding a User**: The _findUser()_ method provides a concise way to retrieve a user by their email. It uses a fluent API style with _Optional_, calling _userDao().findUserByEmail(email)_ and handling the case where the user is not found by throwing a _UserNotFoundException_.

**Code Listing 4.** The UserService Implementation

```java
public class UserServiceImpl implements UserService, ApplicationContextSupport {

    @Override
    public User registerUser(User user) throws BusinessException {
        userDao().createUser(user);
        String email = user.getEmail();
        var createdUser = userDao().findUserByEmail(email)
                .orElseThrow(() -> new CreateUserFailedException(email));
        emailService().confirmEmailAddress(createdUser);
        return createdUser;
    }

    @Override
    public User findUser(String email) throws UserNotFoundException {
        return ofNullable(email)
                .flatMap(em -> userDao().findUserByEmail(em))
                .orElseThrow(() -> new UserNotFoundException(email));
    }

}
```
<div class="link">
<small>Github: <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/service/UserService.java" target="_blank" alt="UserService.java">UserService.java</a>, <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/service/UserServiceImpl.java" target="_blank" alt="UserServiceImpl.java">UserServiceImpl.java</a></small>
</div>

### Emphasizing the Role of _ApplicationContextSupport_
The incorporation of _ApplicationContextSupport_ in _UserServiceImpl_ is a strategic move that brings several benefits:

- **Simplified Access to Dependencies**: Instead of manually fetching instances from the _ApplicationContext_, the service class can directly access dependencies like _UserDAO_ and _EmailService_ through inherited methods. This simplifies the code and makes it more readable.

- **Decoupling of Service Logic from Dependency Management**: By inheriting dependency access methods, _UserServiceImpl_ keeps its focus on business logic, leaving dependency management to _ApplicationContextSupport_. This separation of concerns leads to cleaner and more maintainable code.

- **Consistency Across Services**: As other service classes in the application can also implement _ApplicationContextSupport_, this creates a consistent pattern for accessing dependencies, enhancing the overall design and scalability of the application.

To recap, the _UserService_ implementation in this Java application demonstrates an effective approach to managing dependencies without a DI framework. By leveraging the _ApplicationContextSupport_ interface, it achieves a clean, maintainable, and efficient way of integrating and utilizing various components of the application. This approach not only simplifies dependency resolution but also enriches the service class with clear and focused business logic.

### UserDao

The code below introduces the _UserDAOImpl_, a crucial component of our Java application that manages the data access layer, specifically for user-related data. It stands as an example of how to implement essential database operations without the aid of a Dependency Injection framework, showcasing an alternative yet effective approach to handling data persistence and retrieval in Java.

**Code Listing 5.**  The User Data Access Object

```java
public class UserDAOImpl implements UserDAO {

    private static final Random RANDOM_ID = new Random(1000L);
    private final static Map<String, User> dataSource = new HashMap<>();

    @Override
    public Optional<User> findUserByEmail(String email) {
        // Example: A sql datasource to query to retrieve user info
        return ofNullable(dataSource.get(email));
    }

    public void createUser(User user) {
        String email = ofNullable(user).map(User::getEmail)
                .orElseThrow(() -> new IllegalArgumentException("Email missing"));
        if (dataSource.containsKey(user.getEmail())) {
            throw new UserExistsException(email);
        }
        final User newUser = user.withId(RANDOM_ID.nextLong(0, Long.MAX_VALUE));
        dataSource.put(email, newUser);
    }

}
```
<div class="link">
<small>Github: <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/dao/UserDAO.java" target="_blank" alt="UserDao.java">UserDao.java</a>, <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/dao/UserDAOImpl.java" target="_blank" alt="UserDaoImpl.java">UserDaoImpl.java</a></small>
</div>

### EmailService

The code listing provided reveals the _EmailServiceImpl_, an integral part of our application, designed to manage email-related functionalities. This implementation not only handles the process of sending confirmation emails to users but also demonstrates the effective use of _ApplicationContextSupport_ for streamlined access to dependent services like _EmailSender_.

**Code Listing 6.** The Email Service Implementation

```java
public class EmailServiceImpl implements EmailService, ApplicationContextSupport {

    /**
     * Email confirm the email address on the newly created account.
     */
    @Override
    public void confirmEmailAddress(User user) {
        String email = user.getEmail();
        String subject = "Confirm Email Address";
        String body = "Please confirm email address: " + email;
        emailSender().sendEmail(email, subject, body);
    }

}
```
<div class="link">
<small>Github: <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/service/EmailService.java" target="_blank" alt="EmailService.java">EmailService.java</a>, <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/service/EmailServiceImpl.java" target="_blank" alt="EmailServiceImpl.java">EmailServiceImpl.java</a></small>
</div>

### EmailSender

The _EmailSenderImpl_ class, as showcased here, serves as a fundamental component of our application's email infrastructure. This class encapsulates the specifics of email dispatch, highlighting a simplified yet efficient approach to managing email communications within a Java environment.  

For demonstration purposes, the implementation details within _EmailSenderImpl_ are left blank. However, in a practical scenario, this is where one could integrate robust email services such as AWS Simple Email Service (SES) to handle email dispatch efficiently.

**Code Listing 7.**  The Email Sender Implementation

```java
public class EmailSenderImpl implements EmailSender {
   @Override
   public void sendEmail(String email, String subject, String body) {
      // implementation details
   }
}
```
<div class="link">
<small>Github: <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/email/EmailSender.java" target="_blank" alt="EmailSender.java">EmailSender.java</a>, <a href="https://github.com/kapresoft/kapresoft-examples/blob/2024.01.03/java-examples/src/main/java/com/kapresoft/articles/nodi/email/EmailSenderImpl.java" target="_blank" alt="EmailSenderImpl.java">EmailSenderImpl.java</a></small>
</div>

## In Conclusion

This article's journey through Java development without Dependency Injection (DI) frameworks like Spring or Guice offers a unique perspective, revealing the intricacies and challenges of manual dependency management. Through the implementation of components like _UserService_, _UserDAO_, and _EmailService_, and the strategic use of _ApplicationContextSupport_, we gained a deeper understanding of the underlying processes and architecture of Java applications.

The hands-on experience with a DI-less environment makes one truly appreciate the sophistication and convenience of DI frameworks. These frameworks, often taken for granted, significantly streamline development by handling the complexities of dependency management and component lifecycle.

Furthermore, the test-driven approach in this exploration mirrors real-world scenarios, demonstrating both the positive and negative aspects of manual management in production code. Experiencing these challenges firsthand not only enhances our appreciation for DI frameworks but also enriches our understanding of their importance in simplifying and improving the reliability of our code.

In conclusion, this article underscores the value of DI frameworks in modern software development, while also emphasizing the importance of understanding core principles of Java programming. Whether it's the clarity brought by manual dependency management or the ease provided by DI frameworks, each approach offers valuable insights, contributing to our growth and adaptability as Java developers.

## Github
The entire source for this article is available on Github at [kapresoft/kapresoft-examples](https://github.com/kapresoft/kapresoft-examples/tree/2024.01.03/java-examples)

