---
title: "Spring 6 Error Handling Best Practices"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/05/15/spring-error-handling-best-practices.html
category: java
related: spring
description: "Spring 6 revolutionizes error handling in RESTful APIs, leveraging RFC 7807 for consistent and customizable problem details."
---

## Overview

Error handling and exception design are integral components of developing Spring RESTful APIs, ensuring the application's reliability, stability, and user experience. These practices enable developers to effectively address unexpected scenarios, such as invalid requests, database errors, or service failures, by providing graceful error responses.<!--excerpt--> Through proper error handling, clients receive clear and meaningful messages, enabling them to efficiently diagnose and resolve issues.

In addition to facilitating error communication, well-designed exception handling plays a crucial role in system stability and security. It prevents system crashes and minimizes the exposure of sensitive information, safeguarding the application against potential vulnerabilities. By prioritizing error handling and exception design, developers bolster the robustness and resilience of their Spring RESTful APIs, resulting in heightened user satisfaction and instilling trust in the application.

[Spring Framework 6](https://docs.spring.io/spring-framework/reference/) has introduced significant advancements in exception handling, revolutionizing and simplifying the process. It introduces the "[ErrorResponse](https://docs.spring.io/spring-framework/docs/6.0.x/javadoc-api/org/springframework/web/ErrorResponse.html)" contract, aligned with the specifications outlined in [RFC 7807](https://www.rfc-editor.org/rfc/rfc7807), to standardize error responses across the API. This contract provides a structured format for conveying error details, ensuring consistency and enabling interoperability. Leveraging the capabilities of Spring Framework 6, developers can streamline their exception handling workflow and enhance the overall quality of their RESTful APIs.

By embracing these best practices and leveraging the features of Spring Framework 6, developers can achieve a more efficient and effective approach to error handling and exception design. This, in turn, contributes to the overall success and satisfaction of their Spring RESTful APIs, empowering both developers and API consumers alike.

## Introducing RFC 7807: Standardizing Problem Details for HTTP APIs

RFC 7807, also known as "Problem Details for HTTP APIs," is a specification that offers a standardized approach to structuring and presenting error responses in HTTP-based APIs. This specification defines a common format for communicating information about encountered errors during interactions with an API.

When developers adhere to the RFC 7807 standard, they ensure consistent error handling across different API endpoints and facilitate better understanding and processing of error responses by clients. By employing this standard, API providers can deliver error messages in a structured and uniform manner, improving interoperability and easing troubleshooting for API consumers.

In the context of the Spring Framework, adherence to RFC 7807 allows developers to include problem details in the body of error responses. Whenever an exception arises during the processing of an API request, the framework can automatically generate an error response containing the appropriate problem details. This empowers API consumers to receive structured error information and take appropriate actions based on the encountered problem.

Integrating RFC 7807 into Spring API development aligns with the best practices for error handling. By leveraging the provided abstractions, such as the _ProblemDetail_ and _ErrorResponse_ classes, developers can easily incorporate standardized error responses into their applications. This promotes better communication and understanding between the API provider and consumer, leading to more effective troubleshooting and issue resolution.

### ProblemDetail

The _ProblemDetail_ class, defined in the RFC 7807 specification, is a representation for a problem detail within an error response. It serves as a container for both standard fields defined in the specification and additional custom fields. The fields of the _ProblemDetail_ class provide structured information about the encountered problem. Here's a description of the commonly used fields:

1. **_type_**: Represents a URI that uniquely identifies the specific problem type. It helps to categorize and identify the type of error.

2. **_title_**: Provides a brief, human-readable summary of the problem. It gives a concise description of the error in a user-friendly format.

3. **_status_**: Specifies the HTTP status code associated with the problem. It indicates the nature of the error, such as 404 for "Not Found" or 500 for "Internal Server Error".

4. **_detail_**: Contains a more detailed explanation or description of the problem. It can provide additional context or guidance to help API consumers understand the error.

5. **_instance_**: Represents a URI that refers to a specific instance of the problem. It can be used to identify a particular occurrence of the error.

6. **Custom Fields**: The _ProblemDetail_ class allows for the inclusion of custom fields beyond the standard ones. These fields can be defined based on the specific needs of the API or the application, providing additional relevant information about the problem.

By utilizing these fields within the _ProblemDetail_ class, API providers can convey comprehensive information about errors in a structured and consistent manner. API consumers can then interpret and handle the error responses more effectively, enabling smoother communication and troubleshooting.

When implementing error handling in Spring APIs, the _ProblemDetail_ class can be used to encapsulate these fields and construct meaningful error responses. It is often used in conjunction with the _ErrorResponse_ contract, which exposes the HTTP error response details, including the status, headers, and the body in the format of RFC 7807.

### ErrorResponseException

The _ErrorResponseException_ is a _RuntimeException_ that implements the _ErrorResponse_ interface, allowing it to expose an HTTP status, response headers, and a body formatted as an RFC 7807 _ProblemDetail_. This exception class is designed to encapsulate the details of an error response and provide a standardized representation of the problem.

Developers can use _ErrorResponseException_ as-is or extend it to create more specific exceptions that populate additional fields such as the _type_ or _detail_ fields, or even add other non-standard properties. By extending this exception class, specific exceptions can carry relevant information about the encountered problem, making it easier for consumers to understand and handle the error.

The advantage of using _ErrorResponseException_ is that it ensures consistency in the structure and formatting of error responses throughout the application. It adheres to the RFC 7807 specification, allowing for a standardized approach to handling and communicating errors in HTTP APIs.

By leveraging the capabilities of _ErrorResponseException_, developers can create robust error handling mechanisms that provide clear and structured information about encountered problems, facilitating effective debugging and troubleshooting.

## Error Handling

### Before Spring 6

In this example, the _@ControllerAdvice_ annotation marks the class as an error handler that intercepts exceptions thrown by controllers within the Spring application. The _@ExceptionHandler_ annotation specifies the specific exception type (_ObjectNotFoundException_) that this method handles.


```java
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@RestControllerAdvice
public class CustomExceptionHandler {

    @ExceptionHandler(ObjectNotFoundException.class)
    public ResponseEntity<String> handleObjectNotFound(ObjectNotFoundException ex) {
        // Custom logic for handling the ObjectNotFoundException
        // You can perform additional operations, such as logging the error or customizing the error response
        
        // In this example, we return a ResponseEntity with a 404 status and an error message
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Object not found");
    }
}
```

Inside the _handleObjectNotFound()_ method, you can add custom logic to handle the _ObjectNotFoundException_ as per your application's requirements. This may include logging the error, performing additional processing, or customizing the error response. In this example, we simply return a _ResponseEntity_ with a 404 status and a message indicating that the object was not found.

### After Spring 6


You might be tempted to think that with the introduction of _ProblemDetails_, you can rewrite the previous example to leverage its capabilities. However, simply replacing the custom exception with _ProblemDetails_ in a Spring 6 context is not necessarily an improvement over the pre-Spring 6 approach.

```java
    @ExceptionHandler(NotFoundException.class)
    protected ResponseEntity<Object> handleNotFoundException(NotFoundException ex) {
        ProblemDetail p = ProblemDetail
            .forStatusAndDetail(HttpStatus.NOT_FOUND, ex.getMessage());
        p.setTitle("Object Not Found");
        p.setInstance(URI.create("/api/users/2"));
        p.setType("https://yoursite.acme.com/errors/" + ex.getErrorCode());
    
        return ResponseEntity.body(p);
    }
```

[//]: # (The above can be further simplified and abstracted by utilizing the _ErrorResponse_ contract utilizing the default implementation in _ResponseEntityExceptionHandler_.)

The complexity and abstraction mentioned above can be further simplified and abstracted by leveraging the _ErrorResponse_ contract and making use of the default implementation provided by _ResponseEntityExceptionHandler_.

### What is ResponseEntityExceptionHandler?

The _ResponseEntityExceptionHandler_ is a class in the Spring Framework that provides a convenient base for handling exceptions raised by Spring MVC. It is often used as a base class for an _@RestControllerAdvice_ to implement global exception handling in an application.

The main purpose of _ResponseEntityExceptionHandler_ is to handle Spring MVC exceptions and return a _ResponseEntity_ with RFC 7807 formatted error details in the response body. It simplifies the process of generating consistent and standardized error responses across the application.

Subclasses of _ResponseEntityExceptionHandler_ can override individual methods to handle specific exceptions and customize the error response for each case. Additionally, the _handleExceptionInternal_ method can be overridden to provide common handling for all exceptions, allowing for centralized error handling logic.

Another method that can be overridden is _createResponseEntity_, which intercepts the final step of creating the _ResponseEntity_ from the selected HTTP status code, headers, and body. This gives further flexibility to customize the response entity creation process.

By utilizing _ResponseEntityExceptionHandler_, developers can streamline the handling of Spring MVC exceptions and ensure a consistent approach to error responses. It promotes code reuse and simplifies the implementation of global exception handling throughout the application.

To activate the exception handler in your Spring MVC application, you can create a class annotated with _@RestControllerAdvice_ and extend the _ResponseEntityExceptionHandler_ class. By extending this class, you inherit the default implementation, which provides built-in handling for various types of exceptions and utilizes the RFC 7807 _ProblemDetails_ format.

Here's an example of how you can implement the exception handler:

```java
import org.springframework.http.*;
import org.springframework.web.*;

@RestControllerAdvice
public class APIExceptionHandler extends ResponseEntityExceptionHandler {
    // Custom exception handling methods can be added here
}
```

In this example, the _APIExceptionHandler_ class is annotated with _@RestControllerAdvice_, indicating that it will handle exceptions globally for the application. By extending _ResponseEntityExceptionHandler_, you inherit the base functionality for handling exceptions and generating appropriate error responses.

By extending _ResponseEntityExceptionHandler_ and adding custom exception handling methods, you can centralize your exception handling logic and ensure consistent and well-formatted error responses throughout your Spring MVC application.

You can further customize the _APIExceptionHandler_ class by adding your own or overriding exception handling methods. For adding additional properties to the error response, the _createResponseEntity()_ method can be overridden.

```java
import org.springframework.http.*;
import org.springframework.web.*;

@RestControllerAdvice
public class APIExceptionHandler extends ResponseEntityExceptionHandler {
    
    @Override
    protected ResponseEntity<Object> createResponseEntity(Object body, HttpHeaders headers, HttpStatusCode statusCode, WebRequest request) {
        if (!(body instanceof ProblemDetail)) {
            return super.createResponseEntity(body, headers, statusCode, request);
        }

        // Add custom details
        ProblemDetail p = (ProblemDetail) body;
        p.setProperty("env", "dev");

        return super.createResponseEntity(body, headers, statusCode, request);
    }

}
```
### RFC 7807 Content-Type: application/problem+json

When an exception occurs in the Spring MVC application, the error response generated follows the RFC 7807 specification for problem details. This means that when you make the same API call that previously triggered an exception, you will now receive a response that adheres to the RFC 7807 format.

One important aspect of the RFC 7807 compliant response is the inclusion of the "Content-Type" header with the value "application/problem+json". This header informs the client that the response body contains a JSON representation of the problem details. By specifying the appropriate content type, clients can easily parse and handle the error response using JSON processing libraries.

With the inclusion of the "Content-Type=application/problem+json" header, the error response becomes more standardized and interoperable across different systems and programming languages. This improves the overall consistency and compatibility of the API, enabling easier integration and consumption by clients.

Here is an example error response:

```json
{
  "type": "https://yoursite.acme.com/error-code/user-not-found",
  "title": "User with ID is not found: 2",
  "status": 404,
  "instance": "/api/users/2",
  "env": "dev"
}
```

You can further enhance the exception hierarchy by creating a custom exception that is automatically handled by the _ResponseEntityExceptionHandler_ class.

```java
import org.springframework.http.*;
import org.springframework.lang.Nullable;
import org.springframework.web.*;
import java.net.URI;

public class NotFoundResponseException extends ErrorResponseException {

    private static final String ERROR_CODE_URI = "https://yoursite.acme.com/error-code";

    public NotFoundResponseException(String errorCode, String detail, @Nullable Exception rootCause) {
        super(HttpStatus.NOT_FOUND, rootCause);
        setTitle("Object not found.");
        setDetail(detail);
        setTypeFromErrorCode(errorCode);
    }
    
    private void setTypeFromErrorCode(String errorCode) {
        URI type = new DefaultUriBuilderFactory()
                .uriString(ERROR_CODE_URI)
                .pathSegment(errorCode)
                .build();
        setType(type);
    }
    
}
```

In this example, we create a _NotFoundResponseException_ class that extends the _ErrorResponseException_. This custom exception inherits the functionality provided by _ErrorResponseException_, which implements the _ErrorResponse_ contract for generating error responses in the RFC 7807 _ProblemDetails_ format.

The _NotFoundResponseException_ class takes parameters such as _errorCode_, _detail_, and _rootCause_ to construct the exception. It sets the HTTP status to _HttpStatus.NOT_FOUND_, and customizes the title and detail fields of the error response.

The _setTypeFromErrorCode_ method is used to generate a unique URI for the _type_ field of the error response. It utilizes the _DefaultUriBuilderFactory_ to build the URI based on the given _errorCode_ and the predefined _ERROR_CODE_URI_. This helps in categorizing and identifying the specific type of error.

By creating this custom exception and utilizing the existing hierarchy provided by _ErrorResponseException_, you can easily handle not found errors and generate appropriate error responses with the necessary details according to the RFC 7807 standard.

### Throwing the Exception Becomes Trivial

In the previous example, let's consider the usage of the _NotFoundResponseException_ within the _UserService_ class:

```java
@Service
public class UserService {

    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public User getUserById(Long id) {
        return Optional.ofNullable(userDao.findByUserId(id))
                .orElseThrow(() -> new NotFoundResponseException("user-not-found", "User with id not found: " + id));
    }

}
```

By utilizing the _NotFoundResponseException_ in the _UserService_ class, we not only handle the case where a user is not found but also enhance the testability and maintainability of the service.

The introduction of the custom exception allows the _UserService_ to focus primarily on its core business logic of retrieving users from the data source. The exception handling logic is abstracted away and moved to the appropriate exception handler, such as the _ResponseEntityExceptionHandler_ we discussed earlier.

This separation of concerns means that the _UserService_ class remains focused on its primary responsibility without being contaminated by exception handling code. It promotes a cleaner and more maintainable codebase, as the business logic and exception handling logic are decoupled.

Furthermore, the testability of the _UserService_ is greatly improved. By throwing the _NotFoundResponseException_ when a user is not found, it becomes trivial to write test cases that verify the behavior in such scenarios. The exception can be caught in the test environment, allowing for precise assertions and verifying that the appropriate response is generated.

Overall, by using custom exceptions like _NotFoundResponseException_ and delegating the exception handling to the _ResponseEntityExceptionHandler_, we achieve better separation of concerns, improved testability, and a clearer focus on the business logic within the _UserService_ class.

## Internationalization

[Internationalization](https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-ann-rest-exceptions.html#mvc-ann-rest-exceptions-i18n) plays a crucial role in developing robust and user-friendly applications, and error response handling is no exception. It is a common requirement to internationalize error response details and customize problem details for Spring MVC exceptions. Fortunately, Spring Framework provides comprehensive support for internationalization, allowing developers to create multilingual error responses that cater to diverse user bases.

In Spring Framework's error response handling mechanism, each ErrorResponse object exposes a message code and arguments, which can be resolved through a MessageSource. The message code represents a unique identifier for a specific error scenario, while the arguments provide dynamic values that are inserted into the error response. For example, the message code "HTTP method {0} not supported" can be expanded with the actual HTTP method value retrieved from the arguments.

Furthermore, the ErrorResponse also exposes a message code specifically meant to resolve the "title" field of the error response. This allows developers to customize the title based on the specific error scenario.

The ResponseEntityExceptionHandler class, the default exception handler in Spring Framework, leverages the message code and arguments to resolve both the "detail" and "title" fields of the error response. This ensures that the error messages displayed to the user are appropriately localized and reflect the intended language.

By default, the message code for the "detail" field follows a convention of "problemDetail." followed by the fully qualified exception class name. The "title" field of the error response is automatically populated with a message code based on the fully qualified exception class name.However, some exceptions may expose additional message codes, which are appended to the default message code to provide more specific error details.


```properties
problemDetail.FQ-PKG.NotFoundResponseException = 'The object was not found'
problemDetail.title.FQ-PKG.NotFoundResponseException = 'Not Found'
```

To facilitate internationalization in Spring MVC exceptions, a table is provided that lists the message arguments and codes associated with different types of exceptions. This enables developers to easily customize and translate error messages for each specific exception, ensuring consistent and meaningful error responses across different locales.


## In Conclusion

With the introduction of Spring 6, error handling in Spring APIs has been further enhanced, providing developers with more powerful tools and streamlined approaches.

One notable improvement in Spring 6 is the seamless integration of RFC 7807: Problem Details for HTTP APIs. This specification has been embraced by the Spring Framework, enabling developers to leverage the _ProblemDetail_ abstraction to represent error details in a standardized and consistent manner. By adopting this specification, Spring 6 promotes interoperability and improves the clarity and consistency of error responses across different API endpoints.

The _ResponseEntityExceptionHandler_ class, a cornerstone of error handling in Spring, has also seen advancements in Spring 6. By extending this class and utilizing its built-in functionality, developers can handle exceptions more efficiently and generate error responses that conform to RFC 7807. This simplifies the implementation of error handling logic and reduces the amount of boilerplate code needed to handle different types of exceptions.

Spring 6 encourages the use of custom exceptions that inherit from the _ErrorResponseException_ class. By creating domain-specific exceptions, developers can tailor the error scenarios to their application's requirements and provide more contextual and meaningful error responses. This approach enhances the expressiveness of error messages and allows for fine-grained control over the error handling process.

The testability of applications in Spring 6 has also been a focus of improvement. By separating the exception handling logic from the core business logic, developers can easily write unit tests that specifically target the business functionality without the need to deal with exception handling intricacies. This promotes a more modular and maintainable codebase, making it easier to verify the correctness of the application's behavior.

Spring 6 empowers developers to build robust and reliable APIs with enhanced error handling capabilities. By embracing the features and best practices provided by Spring 6, developers can create APIs that adhere to industry standards, promote code sharing, and provide a seamless experience for API consumers.
