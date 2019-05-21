## App Architecture
*The entire structure of the application. How applications are divided into different interfaces and layers. As well as the control flow and data flow paths between the different components.*

- The importance of app architecture:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - How events flow through layers.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - expectations on whether components should have _compile time_ or _run time_ references to each other.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how data should be read or mutated.

There are 2 common layers in app atchitecture:
- *Model Layer*:  Contains the applications contents which is in full control of the programmer without having to depend on any framework. Typically contains model object and coordinating object
- *View Layer*:  The application dependent framework which makes the model layer visible and user interactable. Usually always uses UIKit or AppKit/SceneKit/OpenGL. The view layer typically forms a view controller hierarchy. Where views are structured like a tree where the screen is the trunk and branches out with smaller views toward the leaves.

#### Applications are a feedback loop
Since having to communicate between layers, there are 2 actions
- The *Interactive Logic* consists of the *view action*(user initiated event) which can lead to *model actions*(instruction to perform an action or update)
- The *Presentation Logic* consists of a *model notification*(usually triggered from the model action) which triggers *view change*