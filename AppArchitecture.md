## App Architecture
*The entire structure of the application. How applications are divided into different interfaces and layers. As well as the control flow and data flow paths between the different components.*

- The importance of app architecture:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - who constructs the model and views and connects the two.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how view actions are handled.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how the model data is applied to the view.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how the *view state* is handled.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how events flow through layers.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - expectations on whether components should have _compile time_ or _run time_ references to each other.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how data should be read or mutated.

There are 2 common layers in app atchitecture:
- *Model Layer*:  Contains the applications contents which is in full control of the programmer without having to depend on any framework. Typically contains *model object*(any data used in the app) and *coordinating object*(objects that persist data on disk)
- *View Layer*:  The application dependent framework which makes the model layer visible and user interactable. Usually always uses UIKit or AppKit/SceneKit/OpenGL. The view layer typically forms a view controller hierarchy. Where views are structured like a tree where the screen is the trunk and branches out with smaller views toward the leaves.

#### Applications are a feedback loop
Since having to communicate between layers, there are 2 actions
- The *Interactive Logic* consists of the *view action*(user initiated event) which can lead to *model actions*(instruction to perform an action or update)
- The *Presentation Logic* consists of a *model notification*(usually triggered from the model action) which leads to *view change*

#### Architectural tools
- *Notification*: broadcasts value from a single source to multiple listeners.
- *KVO*: report changes from one object to another.
- *Reactive programming*: transformation between source and destination

Use *Reactive programming* and *KVO* to create **bindings**: they take in a source and target. Whenever the source has changes, it updates the target. Bindings are important in MVVM.

#### Application design patterns
1. *MVC* Common pattern in cocoa applications.
2. *MVVM+C* A variant of MVC with a seperate view-model to manage the view controller hierarchy.
---
### 1. **MVC**
The controller layer recieves all view action, handles all interaction logic, recieves all model notifications, prepares all data for presentation, and displays changes to the view.\
**Construction**: Application starts contruction of top level view controllers which load and configure views and include which data from the model must be presented. A controller either creates it's own model layer or attempts to create its own through a lazily singleton. This construction should ensure the contruction of these 3 objects: *UIApplicationObject(info.plist)*, *application delegate(AppDelegate.swift)*, and *root view controller(Main.storyboard)*\
**Upating**: When the controller layer recieves view events(target-action, delegates), since the controller knows what kind of views it's connected to but the view has does not know the controller interface, the controller changes it's internal state, changes the model, or direct view hierarchy.\
**Changing the view**: The controller should not change the view directly. Instead, the controller is subscribed to the models notifications and then changes the view hierarchy once the model notification arrives.\
**Changing the model**: The observer pattern is essential to maintaining a clean separation of model and view. This makes sure that the UI will be in sync with the model data no matter where the change oriented from (e.g. view action, background task, network) Steps in changing the model include:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. A view event is triggered\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. The event triggers the model to change\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. The view controller observes the models change. (Notification)\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4. The view controller changes view from the observer.\
**Changing the view state**: Changes that happen excluded from the model. The event loop may just be looping within the view or view and controller.\
**Testing**: It's hard to write unit tests since view controllers are tightly integrated with other components. Instead, we use integration testing to build sections of the view, model, and controller layers.

###### View state: A state that does not follow any particular path through the program. Any state that is ritten to the document during a save operation is considered part of the model. Anything outside of that, is excluded from the definition of MVC (e.g. navigation state, temporary search and sort values, feedback from asynchronous tasks, and uncommited edits, UISwitch which has ON and OFF properties[the event loop is within the view], updating a button.[the event loop is within the view and controller], pushing view controllers)


There are 3 ways to set the initial model data on view controllers:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. Immedietely accessing a global model object on construction.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Initially setting references to nil and keeping everything in a blank state.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. Passing model object on construction(dependency injection)


#### Discussion
There are two common problems to MVC: Observer pattern failures, and massive view controllers\

1. **Observer pattern failures**: This is when the model and view fall out of synchronization. Common mistake is to read model value on construction and not subsribe subsequent noifications. Another is to change the view hierarchy at the same time of changing the model (assuming the result of the change instead of waiting for an observation on model change)\
\
*Improvements* Using KVO and notifications. We can use NotificationCenter and the concept of KVO together allowing us to combine the concepts of *set initial value* and *observe subsequent values* into a single pipeline. (example of where we would use this is with notification observers in the viewDidLoad which calls another @objc function) {pg.68} this reduces the number of change paths in our code.
2. **Massive view controllers**: MVC in particular can lead to large view controllers where it must contain the view layer responsibility and the model layer responsibility. When the entire file is a single class, any mutable state will be shared across the all parts of the file with each function having to cooperatively read and maintain the state to prevent inconsistency.\
\
*Improvements* Moving as much functionality over to the model layer. Common funcions that end up in the controller is sorting, fetching, and processing data. These should be in the model since they relate to an applications data and domain logic. Other ways are to use child objects, create utility classes--like getting users locations--and the code will just require the construction of the task and the callback closure, create models!

##### Code instead of storyboard
The biggest advantage of using code to define the view hierarchy is that you have better control over deoendencies (e.g. when instantiating a view controller, you can pass in objects as parameters) and we gain more control over the construction process

##### Reusing code with extensions
Sharing code between view controller. A way is to create a super class containing the shared functionality but it has a downside, we can only pick one super class for our new class. (e.g. not possible for conforming to both UIPageViewController and UITableViewController). Another way is to use extensions where we might create a protocol and create an extension for if the class conforming to that protocol is a UIViewController. To be able for all UIViewControllers to have the access of functions in the extension.

##### Reusing code with child view controllers
If there are mainly two functionalities inside one view controller, we can split them and put them both into a container view controller then switch between the two depending on the state

##### Extracting objects
A mediating controller is a reusable controller object. In iOS, a protocol conformance is a good candidate for a mediating controller. Pulling out the conformances into seperate objetcs can be an effective way to make view controllers smaller. An example would be extracting the tableViewDataSource. Creating an entire class for it and then passing in the requirements and then declaring a laxy var for that class to set the delegate to that. {pg. 77}

---

### 2. **MVVM+Coordinator**
This uses a *view-model* for each scene to desribe the presentation and interaction logic of the scene. Since the view-model is coupled to the scene, there is the coordinator that provides logic between scene transitions. The view controller here notifies the coordinator through delegates about view actions and the coordinator presents new view controllers and sets their model data. Other words, the view controller hierarchy is controlled by the coordinator not the view controller. The coordinator which has direct reference to the model layer.\
MVVM aims to improve upon MVC in a way where all model related tasks are moved out of the controller layer to the view-model layer (view-modle sit between the model and the view controller). It uses some form of binding to keep properties on one object in sync with properties on another object. These bindings will be what constructs the properties on the view-model and properties on the view. We will be using *reactive profgramming* to implement these bindings. Reactive programming here will build a data pipeline between the model and view unlike MVC where it is a single observer pattern between those.

> Quick intro to reactive programming:  Reactive programming is a pattern for describing data flow between sources. It keeps the observers, the transformations, and subscribers seperate. Uses better in RxSwift (reactive programming framework) which is best use case since they come with bindings to UIKit--RxCocoa. These bindings remove a lot of code from view controllers.

**Construction**: The view controller is built up and creates the view-model upon construction. This view-model binds each view to the view controller. Unlike MVC, MVVM does not present all model object on construction but creates the model-view to handle that instead. And the view-model controls the model.\
**Updating**: When there's a view action, the view or view controller doesn't directly change it's internal state. Instead, it calls a method on the view-model to change it's internal state.\
**Changing the view**: The view-model observes the model and transforms the model notification to be communicated with the view controller. The view controller subsribes to the view-models changes, typically using binding; in this pattern, reactive programming framework.\
**Changing the model**: The view-model being the mediator between the view controller and the model. Steps in changing the model include:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. A view event is triggered\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. The view controller changes the view-model\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. The view-model changes the model.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4. The view-model observes teh model changes.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4. The view controller observes the view-model and updates the views\
**Testing**: Uses interface testing on the view-model since the view-model is de-coupled from the view layer and the controller layer.

#### Integration Tests vs. Interface Tests
View Integration tests require extensive knowledge on how view hierarchy works and the handling of view effects that happen asynchronously. (Used in MVC). Xcode UI tests are similar to integration tests.

#### Discussion
The code can be simpler if you stick to the pattern but does not mean it will be easy to implement. MVVM mitigates the massive view controller problem in MVC. Binding in MVVM also resolves in the model and view getting out of sync because binding unifies the code path of initial set up and updates.

---

### Networking
How networking fits into an app. There are two ways to add networking support into our app. The first variant(*controller-owned networking*) removes the model layer and lets the view controller handle the network requests. The second variant(*model-owned networking*) retains the model of the *MVC* and adds a networking layer beneath it.
- *Controller-owned Networking*: This version fetches data directly from the network and the data is not persisted. The data is cached in memory in the view controller as a *view state*. Which means this will only work with a network connection. This way makes it difficult to share data between view controllers since controller-owned networking is independent on its own. (**in memory cache**) Unlike *model-owned networking* where they instead observe changes in the model.
- *Model-owned Networking*: This version retains the model layer of the *MVC* and serves as an offline cache for the data. Additionally, changes in the model are picked up from the controller using the observe pattern. An advantage to this is that all view controllers draw their data from the store and subsribe to its change notifications.

**Resources**\
objc App Architecture *iOS Application Design Patterns in Swift* book by Chris Eidhof, Matt Gallagher, and Florian Kugler