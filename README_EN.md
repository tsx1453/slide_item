### Introduction

Flutter list item sliding menu component, flutter_slidable_list_view [github] (https://github.com/tsx1453/flutter_slidable_list_view), [pub] (https://pub.dev/packages/flutter_slidable_list_view) optimized and refactored version
Part of the implementation borrowed from [Provider] (https://pub.dev/packages/provider). Because the previous stable_list_view was too sloppy, it also added a flutter header. Now it is no longer visible, so I revisit this In the project ~~ Refactoring ~~ (Rewrite), if there are any problems, please point out the issues, and I will deal with them in time (flag.png)


The number of menu Actions and widgets of each Item can be customized freely. Compared to the previous flutter_slidable_list_view, it is no longer bound to ListView, and at the same time, it optimizes performance. Previously, sliding all elements of an entire list to rebuild, now only a very small part will be reconstructed At present, the refresh range has been controlled to a minimum. If there is room for optimization in the future, it will continue to be optimized.


![example](./slide_item_example.gif)

### how to use

Based on the original ListView, the outer layer uses `SlideConfiguration` to wrap the relevant configuration information of the sliding menu, and then
The original item can be wrapped with `SlideItem`. For the usage method, please refer to the code of the sample program. The meaning of the parameters of the involved classes will be explained below.

#### note
Because InheritedWidget is used, this package development environment uses flutter -v1.12 version, which has been obtained using the latest methods such as `dependOnInheritedWidgetOfExactType`
InheritedWidget, if you need to use the old version, you can use the version with the suffix -adapt

### parameter-meaning

##### SlideConfiguration

| parameter|  meaning | type |
|:-:| :-: |:-:|
|  child |child Widget | Widget |
| config | configuration Beans Of Type SlideConfig | SlideConfig |

##### SlideConfig

|          parameter           |                             meaning                             |   type   |    defaults    |
| :---------------------: | :----------------------------------------------------------: | :------: | :----------: |
|    supportElasticity    | whether to support elastic sliding |   Bool   |     True     |
| closeOpenedItemOnTouch  |  Whether to close the menu when the opened item touches the content area on the left |   Bool   |     fal      |
|     slideProportion     |   The proportion of the width of each menu item (relative to the width of the entire ListItem)   |  double  |     0.25     |
|  elasticityProportion   |                    extra threshold for elastic sliding                    | dou b le |     0.1      |
|   actionOpenThreshold   |                minimum side slip ratio needed to open menu               |  double  |     0.5      |
|     backgroundColor     | Item's background color (because the menu item implemented by Stack, if the list elements are transparent will cause overlap), cannot be Colors.transparent |  Color   | Colors.white |
|  slideOpenAnimDuration  | The duration of the animation that opens the side menu. The time here is from 0 to the total time of full opening. The actual animation time after the finger is lifted will obtain the actual time according to the proportion | Duration |    200ms     |
| slideCloseAnimDuration  |            Duration of closing side menu animation (same as above)         | Duration |    200ms     |
| deleteStep1AnimDuration | The duration of the first phase of the deletion animation (the size of the delete button widget expands to the size of the entire list item) duration | Duration |    200ms     |
| deleteStep2AnimDuration |          Delete the duration of the second phase of the animation (the height of the item)        | Duration |    200ms     |


##### SlideItem

|    parameter     |          meaning          |type| defaults |
| :---------: | :--------------------: | :--------------: | :----: |
| indexInList | position of the current item in the list |       int        |  null  |
|   actions   |   list of elements of menu item   | List<SlideAction> |  []  |
|    child    |         child          |      Widget      |  null  |
|  slidable   |      whether it can slide      |       bool       |  true  |
| leftActions| menu item swiping from left to right | List<SlideAction> | [] |



##### SlideAction

|      parameter      |                             meaning                             |       type        | defaults |
| :------------: | :----------------------------------------------------------: | :---------------: | :----: |
| isDeleteButton |          Whether it is a delete button, used to mark the deletion of the widget to perform the animation    |       bool        | false  |
|  actionWidget  |        item widget for side menu          |      Widget       |  null  |
|  tapCallback   | The callback when the action is clicked, which will provide the animation of the Slide object that can be used to perform operations such as closing and deleting. | ActionTapCallaack |  Null  |



##### Slide

| Method / member   | meaning| parameter           | returnValue      |
| ----------- | -------------------- | ----------------------------- | ---------------------------- |
| close       | close the sliding menu       | Nothing                           | void                         |
| delete      | perform delete animation    | optional parameter use animation default value is true | Future，returns the future of the animation |
| indexInList | item position in the list | Nothing                            | int                          |








