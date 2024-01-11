---
title: "Spring • Intro to WebTestClient"
title_style: title2w
section_style: article1
category: java
related: spring
canonical_url: https://www.kapresoft.com/java/2024/01/10/spring-intro-to-webtestclient.html
description: "Explore the essentials of WebTestClient in Spring Framework - a key tool for effective and efficient web application testing."
---

## Overview

In the ever-evolving landscape of web application development, the <a href="/java/2024/01/03/spring-getting-started.html" target="_blank" alt="Spring Framework">Spring Framework</a> stands out as a robust, versatile platform. Among its myriad tools and features, _WebTestClient_ emerges as a pivotal component, especially in the realm of testing. This introductory article will navigate through the basics of _WebTestClient_, unraveling its role in enhancing the testing capabilities of Spring-based web applications.<!--excerpt-->

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/spring-intro-to-webtestclient-cover-fd964d7.webp" alt="Image: Spring • Intro To Webtestclient">
</div>

WebTestClient is particularly renowned for its non-blocking nature, a crucial attribute in today's demand for highly responsive and efficient web services. By integrating this tool into your Spring projects, developers gain the ability to conduct more rigorous and realistic tests, simulating various real-world scenarios. Moreover, its versatility extends to testing both functional and reactive web components, making it an indispensable tool in the modern Spring developer's toolkit. The following sections will dive deeper into the functionality, integration, and best practices surrounding WebTestClient, illustrating why it is a game-changer in the world of Spring application testing.

## The Basics of WebTestClient

WebTestClient is a specialized tool within the Spring Framework ecosystem, designed to revolutionize how developers approach testing in web applications. At its core, it's a non-blocking, reactive web client used for testing web applications, **supporting both traditional web and reactive web models**. This tool is part of the Spring 5 and above versions, aligning perfectly with the modern reactive programming paradigm that Spring has embraced. WebTestClient provides a fluent API for initiating web requests and inspecting responses, making it an essential asset for testing RESTful services and web applications efficiently.

Distinguishing itself from traditional testing tools in Spring, such as <a href="/java/2023/11/16/spring-boot-mockmvc-best-practices.html" target="_blank" alt="_MockMvc_">_MockMvc_</a>, WebTestClient offers unique features tailored to the demands of contemporary web development. While MockMvc is suitable for servlet-based applications and operates in a blocking manner, WebTestClient is designed from the ground up to be non-blocking. This makes it a versatile tool, suitable for both regular web and reactive web applications. The non-blocking nature of WebTestClient aligns with the reactive stacks like <a href="/java/2023/10/17/spring-webflux-reactive-faqs.html" target="_blank" alt="Spring WebFlux">Spring WebFlux</a> and ensures that tests run faster and more efficiently. Additionally, WebTestClient can be used both in a serverless environment and an actual running server, providing developers with the flexibility to test in a more realistic environment.

In the realm of the Spring Framework, WebTestClient thus emerges as a more versatile, efficient, and future-proof choice for a wide range of web applications, catering to both traditional and reactive programming needs. This versatility makes it an invaluable tool for developers looking to build robust, well-tested applications in the Spring ecosystem.

## Integration with Spring Boot

Integrating _WebTestClient_ into a Spring Boot application is a straightforward process, reflecting Spring's overarching philosophy of ease of use and efficiency. This integration not only enhances the testing capabilities of a Spring Boot application but also aligns seamlessly with the rapid development cycles that Spring Boot is known for.

To begin the integration, the first step involves adding the necessary dependency to your project’s build file. For a <a href="/java/2018/08/16/getting-started-with-maven.html" target="_blank" alt="Maven">Maven</a> project, this means updating the _pom.xml_ file with the _spring-boot-starter-webflux_ dependency. This starter includes everything needed for both developing and testing reactive applications, including WebTestClient.

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-webflux</artifactId>
</dependency>
```

For <a href="/java/2018/08/14/getting-started-with-gradle.html" target="_blank" alt="Gradle">Gradle</a>, a similar dependency would be added to the _build.gradle_ file. Once the dependency is in place, Spring Boot’s <a href="/java/2024/01/06/spring-intro-to-java-based-configuration.html" target="_blank" alt="auto-configuration">auto-configuration</a> capabilities take over. This means that a _WebTestClient_ instance can be automatically injected into your tests without the need for extensive configurations.

In a typical test class, you can inject a _WebTestClient_ bean using Spring’s _@Autowired_ annotation. This instance is pre-configured and ready to use, allowing developers to start writing tests right away.

```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class WebApplicationTest {

    @Autowired
    private WebTestClient webClient;

    // test methods
}
```
See Example Source Here:  <a href="https://github.com/kapresoft/kapresoft-examples/blob/fdeb0f5d52422937a6831b7f84f0552e32f92df3/spring-boot-api/src/test/java/com/kapresoft/articles/api/resource/UserResourceWebClientTest.java" target="_blank" alt="UserResourceWebClientTest.java">UserResourceWebClientTest.java</a>

The _WebEnvironment.RANDOM_PORT_ configuration starts the server with a random port, ideal for integration tests where you want to avoid port conflicts and ensure the test environment closely mirrors production. When you use this configuration, the _WebTestClient_ injected into your tests automatically knows the local server's address and the randomly chosen port, thus connecting seamlessly to the server for testing purposes.

This simplicity in setup and configuration makes WebTestClient ideal for rapid development cycles typical of Spring Boot projects. Developers can quickly write and run tests, ensuring their web applications are robust and reliable, without getting bogged down by complex testing setups.

## Testing WebFlux Applications

When it comes to testing reactive applications built with Spring WebFlux, _WebTestClient_ stands out for its compatibility and effectiveness. Its design is inherently suited for the reactive paradigm that Spring WebFlux advocates, offering specific advantages that make it a preferred choice for developers working with reactive applications.

One of the primary advantages of using WebTestClient in this context is its non-blocking nature, which aligns perfectly with the asynchronous and event-driven model of reactive applications. This ensures that tests are not only efficient but also reflect the real-world behavior of these applications under various load conditions. Moreover, WebTestClient's fluent API facilitates a more intuitive and readable approach to writing tests, allowing developers to easily send requests to reactive endpoints and assert responses.

Let's look at an example to illustrate the simplicity and power of testing a reactive endpoint using WebTestClient:

```java
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class ReactiveEndpointTest {

    @Autowired
    private WebTestClient webClient;

    @Test
    public void testReactiveEndpoint() {
        webClient.get().uri("/reactive-endpoint")
                 .accept(MediaType.APPLICATION_JSON)
                 .exchange()
                 .expectStatus().isOk()
                 .expectBody(String.class).isEqualTo("Response from Reactive Endpoint");
    }
}
```

In this example, a test is written for a hypothetical reactive endpoint ("/reactive-endpoint"). The test uses WebTestClient to send a GET request to this endpoint and then asserts that the response status is _OK (200)_ and the body contains the expected string. The use of _exchange()_ method initiates the request and receives the response in a non-blocking manner, which is crucial for testing reactive endpoints. This test demonstrates not just the ease of setting up and executing tests with WebTestClient, but also its capacity to handle the unique characteristics of reactive streams and endpoints.

Thus, WebTestClient proves to be an invaluable tool for developers working with Spring WebFlux, simplifying the complexity of testing reactive applications and ensuring that these applications are thoroughly tested for performance and reliability.

## Functional Tests with WebTestClient

WebTestClient is not only adept at handling reactive applications but also excels in facilitating functional testing for Spring-based web applications. This capability allows developers to craft more comprehensive and in-depth test cases, ensuring that the web applications perform as expected under various scenarios. Functional testing with WebTestClient involves testing the application's endpoints for specific functionalities, making sure that all parts of the application work together seamlessly.

The strength of WebTestClient in functional testing lies in its fluent API, which enables the simulation of real-world user interactions with the application. This approach ensures that the tests are not just isolated unit tests but rather integrated scenarios that mimic actual user behavior. Developers can send requests to various endpoints, handle different types of payloads, and assert responses, covering a wide range of user interactions.

### Functional Testing

Let's consider an example of a functional test for a typical web application scenario using WebTestClient:

```java
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class UserEndpointTest {

    @Autowired
    private WebTestClient webClient;

    @Test
    public void testCreateUser() {
        User newUser = new User("Alice", "alice@example.com");
        webClient.post().uri("/users/create")
                 .contentType(MediaType.APPLICATION_JSON)
                 .bodyValue(newUser)
                 .exchange()
                 .expectStatus().isCreated()
                 .expectBody(User.class).isEqualTo(newUser);
    }

    @Test
    public void testGetUserDetails() {
        String userId = "123";
        webClient.get().uri("/users/" + userId)
                 .exchange()
                 .expectStatus().isOk()
                 .expectBody()
                 .jsonPath("$.name").isEqualTo("Alice")
                 .jsonPath("$.email").isEqualTo("alice@example.com");
    }
}
```

In this example, two functional test cases are demonstrated for a user management system. The first test, _testCreateUser(..)_, tests the functionality of creating a new user. It sends a POST request with a _User_ object as the body, expecting a 201 (Created) status in response and the same user object returned. The second test, _testGetUserDetails(..)_, tests retrieving a user's details by sending a GET request to the user’s endpoint. It asserts that the response status is OK (200) and verifies specific fields in the JSON response.

### Test a Locally Running Server

Testing a locally running server is a common scenario in web application development. This involves directly interacting with the actual server instance, which is crucial for integration and end-to-end testing. WebTestClient provides a straightforward way to connect to a locally running server, allowing developers to perform real HTTP requests and receive actual responses. This is particularly useful for validating the application's behavior in an environment that closely mirrors production.

Here's an example of how to use WebTestClient to test a locally running server:

```java
class UserEndpointTest {

    private WebTestClient webTestClient;

    @BeforeEach
    void before() {
        // Setup WebTestClient to bind to the local server
        webTestClient = WebTestClient.bindToServer()
                .baseUrl("http://localhost:8080")
                .build();
    }
    
    @Test
    void allUsers() {
        // Test to fetch all users
        webTestClient.get().uri("/users/")
                .exchange()
                .expectStatus().is2xxSuccessful().expectBody()
                .jsonPath("$.link").isEqualTo("/users/") // Asserting the 'link' field
                .jsonPath("$.results.length()").isEqualTo(2) // Asserting the size of 'results'
                .jsonPath("$.results['1'].id").isEqualTo("1") // Asserting the 'id' of the first user
                .jsonPath("$.results['1'].email").isEqualTo("steve.rogers@gmail.com"); // Asserting the 'email' of the first user
    }
}
```

See Example Source Here:  <a href="https://github.com/kapresoft/kapresoft-examples/blob/1e7aaf711c4dfefc494f676dbc08bf5083829d71/spring-boot-api/src/test/java/com/kapresoft/articles/api/webfn/UserHandlerWebClientTest.java#L12" target="_blank" alt="UserHandlerWebClientTest">UserHandlerWebClientTest</a>

In this test, _WebTestClient.bindToServer()_ is used to create a _WebTestClient_ instance that is configured to send requests to a server running at _http://localhost:8080_. The _allUsers(..)_ test method sends a GET request to the _/users/_ endpoint and then performs a series of assertions to verify the response. This includes checking the HTTP status code, the structure of the JSON response, and the values of specific fields. Testing against a locally running server provides an effective way to ensure that the server's endpoints behave as expected in a real-world scenario.

These examples highlight how WebTestClient can be used to write functional tests that closely resemble user interactions, making it a powerful tool for ensuring the functional integrity of web applications developed with Spring.

## Built-in Assertions in WebTestClient

WebTestClient in Spring offers a comprehensive suite of assertions that developers can use to validate various aspects of HTTP responses in their tests. These assertions enable fine-grained control and detailed validation, essential for ensuring the robustness and correctness of web applications. The JavaDoc for WebTestClient provides a complete reference, but here's an overview of some key available assertions:

### Status Assertions
- **expectStatus()**: This assertion is used to verify the HTTP status code of the response. It allows checking whether the response status is as expected, such as _isOk()_, _isNotFound()_, _is4xxClientError()_, etc.

### Header Assertions
- **expectHeader()**: This assertion focuses on validating HTTP headers in the response. It can be used to check for the presence of specific headers, their values, or even patterns.

### Body Assertions
- **expectBody()**: Used to assert and verify the body of the response. It can decode the response to a specific class and apply assertions on it.
- **expectBodyList()**: Similar to _expectBody()_, but specifically for responses expected to be lists. It allows asserting on list-specific properties, like size or content.
- **expectBodyClass()**: Asserts that the response body can be decoded to a specific class.

### Cookie Assertions
- **expectCookie()**: Enables testing cookies set in the HTTP response. This can include assertions on cookie values, their properties, and presence.

### Advanced Assertions
- **expectAll()**: This method allows applying multiple assertions in a single chained call, ensuring all assertions are evaluated even if one or more fail. It is useful for grouping related assertions logically.

### Custom Assertions: Using ObjectMapper and AssertJ

In complex testing scenarios, developers often require more nuanced validation than what is available through the standard assertions. This is where custom assertions come into play, leveraging tools like ObjectMapper and AssertJ to dissect and assert on JSON responses in a more detailed manner. Let's explore this through an example.

Consider a scenario where we are testing a REST endpoint that returns user details in JSON format. The response might look like this:

```json
{
  "link": "/fn/user/1",
  "id": 1,
  "active": true,
  "first": "Steve",
  "last": "Rogers",
  "email": "steve.rogers@gmail.com"
}
```

To test this, we can use WebTestClient to perform a GET request, check the response status and header, and then apply custom assertions on the JSON body:

```java
@Test
void specificUser_CustomAssertion() {
    webTestClient.get().uri("/fn/user/1")
            .exchange()
            .expectStatus().isOk()
            .expectHeader().contentType(MediaType.APPLICATION_JSON)
            .expectBody(JsonNode.class).consumeWith(response -> {
                JsonNode userJson = response.getResponseBody();
                // Custom assertions using AssertJ
                assertThat(userJson).isNotNull();
                assertThat(userJson.isNull()).isFalse();

                assertThat(userJson.get("link").textValue())
                        .isEqualTo("/fn/user/1");
                assertThat(userJson.get("first").textValue())
                        .isNotNull()
                        .isEqualToIgnoringCase("steve");
            });
}
```

In this test, we're using _consumeWith()_ to handle the response body as a _JsonNode_, which is part of the Jackson library. This allows us to navigate the JSON tree easily. The _assertThat()_ method from AssertJ is then used to perform assertions on the JSON content. We're checking the _link_ and _first_ fields for specific values, ensuring that our endpoint returns the correct data. The combination of ObjectMapper and AssertJ gives us the flexibility to create precise and readable assertions, making our tests both robust and maintainable.

### Custom Assertions: Returned Result
- **returnResult()**: While not an assertion in the traditional sense, this method is crucial for scenarios where you need to perform custom assertions or further processing of the response.

These assertions provided by WebTestClient are designed to cover a wide range of testing needs in web application development, ensuring that every aspect of the HTTP response can be thoroughly tested.

For more detailed information and examples of using these assertions, you can refer to the [WebTestClient ResponseSpec documentation](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/test/web/reactive/server/WebTestClient.ResponseSpec.html).

## Advanced Features and Customizations

WebTestClient offers a range of advanced features and customization options, which cater to more complex and specific testing needs. These capabilities are particularly beneficial for developers who require more control over the request and response handling or who need to test against intricate application behaviors.

### Custom Exchange Strategies

One of the advanced features of WebTestClient is the ability to define custom exchange strategies. An exchange strategy in the context of WebTestClient refers to how a request is processed and how a response is handled. By default, WebTestClient uses a standard strategy suitable for most use cases. However, in scenarios where there is a need for a specific request handling or response processing logic, developers can define their custom strategies.

For instance, a custom exchange strategy can be employed to add common headers to every request or to log details of every exchange for debugging purposes. Here's an example of how a custom exchange strategy might be implemented:

```java
ExchangeStrategies strategies = ExchangeStrategies
    .builder()
    .codecs(clientDefaultCodecsConfigurer -> {
        clientDefaultCodecsConfigurer.defaultCodecs().jackson2JsonEncoder(new Jackson2JsonEncoder(new ObjectMapper(), MediaType.APPLICATION_JSON));
        clientDefaultCodecsConfigurer.defaultCodecs().jackson2JsonDecoder(new Jackson2JsonDecoder(new ObjectMapper(), MediaType.APPLICATION_JSON));
    })
    .build();

WebTestClient webClient = WebTestClient
    .bindToServer()
    .baseUrl("http://localhost:8080")
    .exchangeStrategies(strategies)
    .build();
```

In this code snippet, a custom _ExchangeStrategies_ object is created to customize JSON encoding and decoding. This can be particularly useful if your application requires a specific configuration of the Jackson JSON processor.

### Request and Response Manipulations

Another area where WebTestClient shines is in its ability to manipulate requests and responses. This is critical when testing applications that have complex business logic or require detailed assertions.

For example, you can customize request headers, query parameters, or body content to test how your application behaves under different conditions. Similarly, response assertions can go beyond simple status codes or content checks. You can inspect headers, extract specific parts of the response body, or even compare the response against a JSON schema.

```java
webClient.get().uri("/users/{id}", 1)
         .header("Authorization", "Bearer some-token")
         .exchange()
         .expectStatus().isOk()
         .expectHeader().contentType(MediaType.APPLICATION_JSON)
         .expectBody()
         .jsonPath("$.name").isEqualTo("Alice");
```

In this example, a GET request is made with a custom _Authorization_ header. The test then asserts not just the response status and content type, but also a specific field in the JSON response.

These advanced features and customization options make WebTestClient a highly flexible tool, capable of handling a wide range of testing scenarios. By leveraging these features, developers can tailor their testing approach to meet the specific requirements and complexities of their Spring-based web applications.

## Best Practices and Common Pitfalls

Using _WebTestClient_ effectively in Spring projects involves adhering to certain best practices and being aware of common pitfalls. This ensures that tests are not only reliable and maintainable but also accurately reflect the behavior of the application under test.

### Best Practices

1. **Keep Tests Focused and Isolated:** Each test should concentrate on a single functionality or endpoint. Avoid combining multiple test scenarios in one test method. This approach makes tests easier to understand and maintain.

2. **Use Descriptive Test Names:** Choose test method names that clearly describe what the test is verifying. This makes it easier for others (and future you) to understand the purpose of the test at a glance.

3. **Leverage @WebFluxTest for Sliced Testing:** When testing controllers, consider using the _@WebFluxTest_ annotation. This annotation loads only the components necessary for testing the controller, making the tests faster and more focused.

4. **Utilize Assertive Error Handling:** Ensure your tests are assertive in checking both the expected successful outcomes and potential error conditions. This helps in catching unanticipated behaviors early.

5. **Mock External Services:** If your application interacts with external services, use mocking instead of making actual calls in your tests. This makes tests faster and more reliable, as they won’t depend on external factors.

6. **Consistent Data Setup:** Ensure a consistent testing environment by setting up (and tearing down) your test data effectively. This can involve using _@BeforeEach_ or _@AfterEach_ annotations for setup and cleanup.

### Common Pitfalls

1. **Overlooking Blocking Calls:** When testing a reactive stack, ensure that you don’t inadvertently introduce blocking calls. This can skew the test results or lead to timeouts.

2. **Ignoring Response Details:** Not thoroughly checking the response details (like headers, status codes, body) can lead to missed edge cases. Ensure your tests cover these aspects comprehensively.

3. **Misconfigured Routes or Endpoints:** Ensure that the routes or endpoints specified in the tests match those defined in the application. Mismatches here are a common source of false negatives.

4. **Excessive Mocking:** While mocking is useful, over-mocking can lead to tests that pass regardless of changes in the actual application logic. Strive for a balance to ensure tests remain effective.

5. **Ignoring Non-Happy Paths:** Focusing solely on the 'happy path' (where everything works as expected) can leave your application vulnerable to untested scenarios. Include tests for potential failure modes and error conditions.

6. **Neglecting Performance Aspects:** Especially in reactive applications, pay attention to how your tests might behave under load or in high-throughput scenarios. This can reveal issues not apparent under normal conditions.

By following these best practices and avoiding common pitfalls, developers can maximize the effectiveness of WebTestClient in their Spring projects, leading to more robust and reliable web applications.

## Conclusion

In conclusion, _WebTestClient_ emerges as an indispensable tool in the toolkit of any developer working with the <a href="/java/2024/01/03/spring-getting-started.html" target="_blank" alt="Spring Framework">Spring Framework</a>, particularly those focusing on web applications. It is tailored to the demands of both traditional and reactive web services, offering a non-blocking, reactive approach that aligns seamlessly with the modern web development landscape. The key takeaways from our exploration of WebTestClient in Spring include its ease of integration with Spring Boot, its effectiveness in functional testing, and its advanced features that cater to a variety of testing scenarios.

WebTestClient's seamless integration with Spring Boot simplifies the setup and configuration process, aligning perfectly with Spring Boot's philosophy of rapid development. This ease of integration enables developers to quickly write and execute tests, ensuring their web applications are robust and reliable. The tool's adeptness in testing WebFlux applications highlights its suitability for the reactive programming model, ensuring efficient and accurate testing of asynchronous and event-driven applications.

Furthermore, the functional testing capabilities of WebTestClient allow for more comprehensive test coverage, simulating real-world user interactions. Its advanced features, including custom exchange strategies and request/response manipulations, offer the flexibility to tailor tests to specific requirements. Moreover, adhering to best practices and avoiding common pitfalls when using WebTestClient ensures that tests are focused, descriptive, and reflective of the application’s real-world behavior.

The importance of WebTestClient in building robust, well-tested Spring applications cannot be overstated. It not only enhances the quality of tests but also contributes to the overall reliability and performance of web applications. In a world where web application performance and reliability are paramount, WebTestClient stands as a key ally for developers striving to achieve excellence in their Spring-based projects.

