With the container visualization tree, containers can be arranged and visualized in a freely definable tree structure, independent of permissions. The assignment is done via parent/child relationships and serves exclusively for the clear presentation and grouping of containers, without affecting access rights.

On the browser overview `/browser` page, an alternative view of the container structure is displayed. This overview is used to visually represent the organizational structure and its dependencies.

![status_tree](/images/organizational_trees/status_tree.png)

The overview takes into account the user permissions stored in the system. This means that all containers to which a user does not have access rights are automatically hidden. Based on the container ID, an additional tab for the organizational chart will be displayed.

![browser_tree](/images/organizational_trees/browser_tree.png)

Multiple virtual trees can be created per container. For the host status overview, the setting of the virtual container `is_recursive` is taken into account for resolving all child containers. Additionally, multiple users (openITCOCKPIT users) can be assigned (optional) to be identified as the correct contact person in the event of a failure.

## Configuration of Virtual Trees

In the configuration area, an organizational chart can be created and edited. The following fields are available:

* Name of the tree (required)
* Description (optional)

On the left side, there is a selection of available container types, such as:

* Tenant
* Location
* Node

This selection can be dragged and dropped and positioned freely.

![config_edit](/images/organizational_trees/config_edit.png)

By clicking the `Edit` button, the editing area of a specific node can be opened.

![edit](/images/organizational_trees/edit.png)

A new window opens in which, depending on the type, a specific container can be selected. Additional settings can also be made:

* Container name (required)
* `is_recursive` If this option is enabled, the host and service status overview for all child containers of the selected container will be considered and displayed.
* Regional manager (optional)
* Manager (optional)
* User (optional)

![config_modal](/images/organizational_trees/config_modal.png)
