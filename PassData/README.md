# Passing data between view controllers

View controllers contain a lot of information. And it would make sense for an app with many view controllers to have the same data. With some data in view controllers being inherited from others. There are multiple ways to do this as below.\
There are multiple examples to this. Some are - Populating an information page based on what service users select, and - Displaying images on new view controller based on what users searched. Both these examples use some form of code reuse or inheritance. Let's see some ways we can create this using some following choices below.

## Delegates
Also called as the delegation pattern. A high level would be where you create a protocol which will act as a collection of actions that any view controller can instantiate and access. Then different view controllers that want to have access to when the view controllers call the methods, can conform to the protocol and specify which view controllers they want to have access to from the protocol.\
\
Here are the steps to successfully set up the delegation pattern:
1. Declare a protocol. Which will contain the methods that will act as the delegation actions.
2. Create a delegate instance to the protocol in a view controller (*ViewControllerB*)
3. Conform another view controller (*ViewControllerA*) to the protocol.
4. Inform somehow that *ViewControllerB*'s delegate is tied to *ViewControllerA* to ensure data retrieval.
5. Actoins will occur whenever *ViewControllerB* calls methods on the delegate.

*ViewControllerA* would be actioned by *ViewControllerB*'s actions since it created that *ViewControllerB*'s delegate is of *ViewControllerA*'s. The delegation pattern allows in proficcient acess. Where a controller wants access based on other view controller's action. The delegator (*ViewControllerB*) will not need to know anything about the viewController but instead comminicates to the protocol and any viewController that sets conforms to the delegate, setting it to the delegator view controller, will have access to everytime the delegator calls a function (within the protocol).

#### Sample delegation pattern setup among two view controllers 

```Swift

protocol DataDelegate {
    func viewLoaded()
}

class ViewControllerA: UIViewController, DataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func viewLoaded() {
        print("delegator view loaded")
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewB = storyboard.instantiateViewController(withIdentifier: "viewControllerB") as! ViewControllerB
        viewB.delegate = self
        
        self.present(viewB, animated: true, completion: nil)
    }
}

class ViewControllerB: UIViewController {
    
    var delegate: DataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.viewLoaded()
    }
}
```

Whenever *ViewControllerB* is instantiated from *ViewControllerA*, by specifically stating the delegate is of *ViewControllerA*'s, the `viewLoaded` with get called in *ViewControllerA*. Therefore, printing `"delegator view loaded"` in the console

> Note: \
> Wherever the delegator view controller is going to be presented, the delegate must be declared of which it belongs to. Or else the delegation would not work.

## Notification Center
## KVO
## Instantiation / prepareForSegue


---


> **Resources**:
> - [delegates](https://medium.com/swift2go/when-i-say-delegate-you-say-what-54df1108ba58), Swift2Go
