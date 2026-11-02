# Import / Export <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

The import/export functionality in openITCOCKPIT is the right way to transfer configuration items between multiple systems. It is part of the Import Module.

As a first step you are able to export items for commands, timeperiods, contacts, contactgroups servicetemplates and servicetemplate groups as a json file. If there are dependencies between e.g. servicetemplates and contacts they will be automatically detected and exported.

The second step is the import the file on a different master system. It's as easy as the export. The module detects (as an example) if the imported servicetemplate is a new one or if it already exists. If it's a new one a banner will indicate, that there are no import conflicts. If the servicetemplate already exists, a notification will be displayed and the differences between the current configuration and the new configuration.

Navigate to `Administration -> Object Import -> Export / Import`

## Exporting configuration items

First, select all items that should be exported. As already mentioned, the module also recognises dependencies to other items. For example, if you export a service template  you don't have to worry about which command is used or which contacts are needed, the import/export module takes care of everything.

![Screenshot: Exporting configuration items](/images/import_export/export_items.png)

Clicking on __*Export configuration items*__ generates a .json file that is ready to use for the import on a different system.

!!! info "Hint"
    Do not try to change the content of the file. During the import, the checksum of the file is checked and will only be imported if the checksum is correct.

## Importing configuration items

!!! warning "Hint"
    Before starting the import it is recommended that you create a backup of your database first.

For the import only an exported .json file is needed. You can simply drop it to the upload field or click on the field to search for the file.

![Screenshot: Importing configuration items](/images/import_export/import_file.png)

### Summary information
After the file has been selected, the module displays a summary of the import and possible conflicts.

![Screenshot: Summary information](/images/import_export/import_summary.png)

### Only new items found

If only new items are imported, the module shows in the __*Import*__ area that no conflicts were found and that the import is ready.

![Screenshot: Only new items found](/images/import_export/import_ready.png)

### Changes to existing items found

In case of overwriting existing items, the module outputs a warning and displays the changes in detail.

![Screenshot: Changes to existing items found](/images/import_export/import_danger.png)

The import can be executed even if there are differences in the configuration.

### Import finished successfully

A final message shows that the import has been successfully completed and that all changes have been logged in the changelog.

![Screenshot: Import finished successfully](/images/import_export/import_finished.png)

## Changelog

As usual, all changes are logged in the changelog. The logged-in user is used as the user who made the changes. In this way, it is also possible to track who made the changes during an import.

![Screenshot: Changelog](/images/import_export/changelog.png)