## App Architecture
*The entire structure of the application. How applications are divided into different interfaces and layers. As well as the control flow and data flow paths between the different components.*

- The importance of app architecture:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - who constructs the model and views and connects the two?\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how are view actions handled\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how is the model data applied to the view
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how is the *view state* handled. (non model state) 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how events flow through layers.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - expectations on whether components should have _compile time_ or _run time_ references to each other.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how data should be read or mutated.

There are 2 common layers in app atchitecture:
- *Model Layer*:  Contains the applications contents which is in full control of the programmer without having to depend on any framework. Typically contains model object and coordinating object
- *View Layer*:  The application dependent framework which makes the model layer visible and user interactable. Usually always uses UIKit or AppKit/SceneKit/OpenGL. The view layer typically forms a view controller hierarchy. Where views are structured like a tree where the screen is the trunk and branches out with smaller views toward the leaves.

#### Applications are a feedback loop
Since having to communicate between layers, there are 2 actions
- The *Interactive Logic* consists of the *view action*(user initiated event) which can lead to *model actions*(instruction to perform an action or update)
- The *Presentation Logic* consists of a *model notification*(usually triggered from the model action) which triggers *view change*

#### Architectural tools
- *Notification*: broadcasts value from a single source to multiple listeners.
- *KVO*: report changes from one object to another.
- *Reactive programming*: transformation between source and destination

Use *Reactive programming* and *KVO* to create **bindings**: they take in a source and target. Whenever the source has changes, it updates the target.

#### Application design patterns
1. *MVC* Common pattern in cocoa applications.
2. *MVVM* A variant of MVC with a seperate view-model to manage the view controller hierarchy.
---
1. MVC 
The controller layer recieves all view action, handles all interaction logic, recieves all model notifications, prepares all data for presentation, and displays changes to the view.\
**Construction**: Application starts contruction of top level view controllers which load and configure views and include which data from the model must be presented. A controller either creates it's own model layer or attempts to create its own through a lazily singleton.\
**Upating**: When the controller layer recieves view events(target-action, delegates), since the controller knows what kind of views it's connected to but the view has does not know the controller interface, the controller changes it's internal state, changes the model, or direct view hierarchy.\
**Changing the view**: The controller should not change the view directly. Instead, the controller is subsribed to the models notifications and then changes the view hierarchy once the model notification arrives.\
**Testing**: It's hard to write unit tests since view controllers are tightly integrated with other components. Instead, we use integration testing to build sections of the view, model, and controller layers.